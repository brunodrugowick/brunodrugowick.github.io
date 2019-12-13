---
layout: default
title: My first attempt at Generics (+Reflection)
showOnHome: false
excerpt_separator: <!--more-->
comments: true
---

# My first attempt at Generics...

... it turns out I didn't need it!

It's been a while that I wanted to try something with Generics. The opportunity just hit me when an implementation with Reflection was shown to me. Those are two topics I want to make myself more comfortable with, so... ideal opportunity!

<!--more-->

## The Opportunity

I was implementing a PATCH HTTP request on a controller for an entity called Restaurant as part of a REST API course I'm taking. The implementation that the instructor came up with was something like this (using Reflection):

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

### The Generic Class

This is the class that represents the code above but with Generics in mind:

```java
public class ObjectMerger<T> {

    private ObjectMapper objectMapper;
    private Class<T> type;

    private ObjectMerger(Class<T> type) {
        this.objectMapper = new ObjectMapper();
        this.type = type;
    }

    public static ObjectMerger of(Class type) {
        return new ObjectMerger(type);
    }

    public void mergeRequestBodyToGenericObject(Map<String, Object> objectMap, T objectToUpdate) {
        T newObject = objectMapper.convertValue(objectMap, type);

        objectMap.forEach((fieldProp, valueProp) -> {
            Field field = ReflectionUtils.findField(type, fieldProp);
            field.setAccessible(true);

            Object newValue = ReflectionUtils.getField(field, newObject);

            ReflectionUtils.setField(field, objectToUpdate, newValue);
        });
    }
}
```

You can see that I can instantiate this with any other class type (hence "generic") using `of` method and the class will provide a method to map a `Map<String, Object>` to the object type provided. This is Generics solution to implement partial updates to an object via a PATCH HTTP request.

### The new implementation for the PATCH HTTP method

This is the new implementation for the PATCH HTTP method of any Controller from now on (here, the Restaurant example):

```java
@PatchMapping("/{id}")
public ResponseEntity<?> partialUpdate(@PathVariable Long id, @RequestBody Map<String, Object> restaurantMap) {
    Restaurant restaurantToUpdate = restaurantCrudService.read(id);

    if (restaurantToUpdate == null) {
        return ResponseEntity.notFound().build();
    }

    ObjectMerger
        .of(Restaurant.class)
        .mergeRequestBodyToGenericObject(restaurantMap, restaurantToUpdate);

    return update(id, restaurantToUpdate);
}
```

## Wait... I was wrong!

### What I wanted to do was simply DRY.

`Don't Repeat Yourself`, i.e. a solution where I would not repeat myself for the PATCH HTTP requests (in this case). I thought Generics was the solution because... reasons! Well, I don't know exactly at this point. All I remember now is that I also had in mind that I didn't want to instantiate ojects with `new`.

So, here it goes for historial purposes, the Generics implementation: [the one where I was thinking with my ass](https://github.com/brunodrugowick/algafood-api/commit/0d5b7bc25bc1a7c69d523c19c4a1abef10f862ce).

### And I didn't even need configuration.

```java
public static ObjectMerger of(Class type) {
    return new ObjectMerger(type);
}
```

So I created a `of` method to return a new ObjectMerger: [the one where someone helped me to make a bit of sense](https://github.com/brunodrugowick/algafood-api/commit/940020631adab29a8c92707252e54c7df02af813).

### And to avoid instantiation I could cache on a map.

```java
public static ObjectMerger of(Class type) {

    if (!cacheEnabled) {
        // Cache is not enabled. A new instance is always created.
        return new ObjectMerger(type);
    }

    if (!objectMergerCache.containsKey(type)) {
        ObjectMerger objectMerger = new ObjectMerger(type);
        objectMergerCache.put(type, objectMerger);
        // Cache enabled. Instance created (first request).
        return objectMerger;
    }

    // Cache enabled. Returning existing instance.
    return objectMergerCache.get(type);
}

```

This ideia led to this implementation: [the one where I was almost there](https://github.com/brunodrugowick/algafood-api/commit/991c2ebe7e4ae4330b53291d9825c64ad3180aee).

### Well, what am I caching anyway?

```java
public class ObjectMerger {

    public static void mergeRequestBodyToGenericObject(Map<String, Object> objectMap, Object objectToUpdate, Class type) {
        ObjectMapper objectMapper = new ObjectMapper();
        Object newObject = objectMapper.convertValue(objectMap, type);

        objectMap.forEach((fieldProp, valueProp) -> {
            Field field = ReflectionUtils.findField(type, fieldProp);
            field.setAccessible(true);

            Object newValue = ReflectionUtils.getField(field, newObject);

            ReflectionUtils.setField(field, objectToUpdate, newValue);
        });
    }
}
```

I didn't need any properties on the class, it could be a helper class, no state, just function. So I made a dead simple static method: [the one where I felt like an idiot](https://github.com/brunodrugowick/algafood-api/commit/8c166780e172daa2e7fed84972c9012372334651).

## And that's it

It's working, I learnt a lot and I'm very pleased with myself. Hahahahaha.

You can see the history of this post [here](https://github.com/brunodrugowick/brunodrugowick.github.io/commits/master/_posts/2019-12-11-first-attempt-generics-reflection.md).
You can test the API [here](https://algafoodapi.herokuapp.com/).

# Comments

{% if page.comments %} 
<div id="disqus_thread"></div>
<script>

var disqus_config = function () {
this.page.url = '{{ page.id }}';  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = '{{ page.id }}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://drugowick.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}
