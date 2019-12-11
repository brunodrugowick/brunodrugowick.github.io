---
layout: default
title: My first attempt at Generics (+Reflection)
showOnHome: false
excerpt_separator: <!--more-->
---

# My first attempt at Generics

It's been a while that I wanted to try something with Generics. The opportunity just hit me when an implementation with Reflection was shown to me. Those are two topics I want to make myself more comfortable with, so... ideal opportunity!

<!--more-->

## The Opportunity

I was implementing a PATCH HTTP request on a controller for a entity called Restaurant as part of a REST API course I'm taking. The implementation that the instructor came up with was something like this (using Reflection):

```java
  @PatchMapping("/{id}")
	public ResponseEntity<?> partialUpdate(@PathVariable Long id, @RequestBody Map<String, Object> restaurantMap) {
		Restaurant restaurantToUpdate = restaurantCrudService.read(id);

		if (restaurantToUpdate == null) {
			return ResponseEntity.notFound().build();
		}
    
		merge(restaurantMap, restaurantToUpdate);

		return update(id, restaurantToUpdate);
	}

  public merge(Map<String, Object> objectMap, Restaurant restaurantToUpdate) {
        ObjectMapper objectMapper = new OjectMapper()
        Restaurant newObject = objectMapper.convertValue(objectMap, Restaurant.class);

        objectMap.forEach((fieldProp, valueProp) -> {
            Field field = ReflectionUtils.findField(Restaurant.class, fieldProp);
            field.setAccessible(true);

            Object newValue = ReflectionUtils.getField(field, newObject);

            ReflectionUtils.setField(field, objectToUpdate, newValue);
        });
    }
```

And I'd have to reimplement this method on all my controllers (for other entities). So, I tried to create a solution with Generics.

## The Solution

TL;DR: [the commit with the solution](https://github.com/brunodrugowick/algafood-api/commit/0d5b7bc25bc1a7c69d523c19c4a1abef10f862ce).

### The Generic Class

This is the class that represents the code above but with Generics in mind:

```java
public class ObjectMerger<T> {

    private ObjectMapper objectMapper;
    private Class<T> type;

    public ObjectMerger(Class<T> type) {
        this.objectMapper = new ObjectMapper();
        this.type = type;
    }

    public T mergeRequestBodyToGenericObject(Map<String, Object> objectMap, T objectToUpdate) {
        T newObject = objectMapper.convertValue(objectMap, type);

        objectMap.forEach((fieldProp, valueProp) -> {
            Field field = ReflectionUtils.findField(type, fieldProp);
            field.setAccessible(true);

            Object newValue = ReflectionUtils.getField(field, newObject);

            ReflectionUtils.setField(field, objectToUpdate, newValue);
        });

        return objectToUpdate;
    }
}
```

You can see that I can instantiate this with any other class type (hence "generic") and the class will provide a method to map a `Map<String, Object>` to the object type provided. This is a solution to implement partial updates to an object via a PATCH HTTP request.

```
NOTE: I'm aware there are better solutions to this problem. =)
```

### The new implementation for the PATCH HTTP method

This is the new implementation for the PATCH HTTP method of any Controller from now on (here, the Restaurant example):

```java
// Injecting the correct objectMerger
@Autowired
private ObjectMerger<Restaurant> objectMerger;

//The PATCH endpoint simplified
@PatchMapping("/{id}")
	public ResponseEntity<?> partialUpdate(@PathVariable Long id, @RequestBody Map<String, Object> restaurantMap) {
		Restaurant restaurantToUpdate = restaurantCrudService.read(id);

		if (restaurantToUpdate == null) {
			return ResponseEntity.notFound().build();
		}

		restaurantToUpdate = objectMerger.mergeRequestBodyToGenericObject(restaurantMap, restaurantToUpdate);

		return update(id, restaurantToUpdate);
	}
```

### The Spring Configuration

I'm using Spring, as you may have noticed, so I configured a few Beans of ObjectMerger on a specific configuration class:

```java
@Configuration
public class ObjectMergerConfig {

    @Bean
    public ObjectMerger<Restaurant> restaurantObjectMerger() {
        return new ObjectMerger<>(Restaurant.class);
    }

    @Bean
    public ObjectMerger<Cuisine> cuisineObjectMerger() {
        return new ObjectMerger<>(Cuisine.class);
    }

    @Bean
    public ObjectMerger<City> cityObjectMerger() {
        return new ObjectMerger<>(City.class);
    }

    @Bean
    public ObjectMerger<Province> provinceObjectMerger() {
        return new ObjectMerger<>(Province.class);
    }
}
```

### And that's it

It's working fine and I'm very pleased with myself. Hahahahaha.

You can test the API [here](https://algafoodapi.herokuapp.com/).
