---
layout: default
title: "Querying your Spring Data JPA Repository - Introduction"
showOnHome: false
excerpt_separator: <!--more-->
devToUrl: https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-introduction-4ani
---

# Querying your Spring Data JPA Repository - Introduction

In this series of posts I'll show you several methods to query your `Java` `JPA` `repositories` using `Spring Data JPA`. Throwing in some `Spring Boot` and `JPQL` and you have *too many words*!

## So... what do you need to know?

- Java and Spring: the [language](https://docs.oracle.com/en/java/javase/13/) and the [framework](https://spring.io), respectively.
- Java Persistence API (JPA): the specification for a ORM (Object-Relational Mapping) born from Hibernate, the first and most popular implementation of the JPA specification.
 - It's how you persist data to a relational database.
- Spring Data JPA: a [sub-project](https://spring.io/projects/spring-data-jpa) of [Spring Data](https://spring.io/projects/spring-data), one of the many (many!) projects of Spring Framework.
- Spring Data JPA Repository: a Java interface/class annotated with `@Repository` from `org.springframework.stereotype` package.

<!--more-->