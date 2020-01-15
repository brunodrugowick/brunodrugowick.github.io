---
layout: default
title: "Spring Data JPA Query Methods"
showOnHome: false
excerpt_separator: <!--more-->
devToUrl: https://dev.to/brunodrugowick/spring-data-jpa-query-methods-l43
---

# Spring Data JPA Query Methods

This is the post #3 of the series "Querying your Spring Data JPA Repository".

If you're following the series, by now you have an app with a list of Restaurants. The list is fetched using the method `findAll()` which you did not implement, because it was provided by Spring Data JPA when you created the `RestaurantRepository` class extending Spring's `JpaRepository` class.

Take a look at the previous post if you haven't already.

# The Task

Let's say that now you have to add a search bar on top of the list in order to filter it. The search must match any Restaurant name that contains the text the user types.

![Search Restaurants](https://thepracticaldev.s3.amazonaws.com/i/d2rnejoxbpen63ip8qv6.jpg)

<!--more-->

<a href="https://dev.to/brunodrugowick/spring-data-jpa-query-methods-l43" target="_blank">Continue reading at dev.to...</a>
