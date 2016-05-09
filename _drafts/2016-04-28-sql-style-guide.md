---
layout: post
title: SQL Style Guide
comments: true
disqus_id: 45668cd0-c6f9-4ce3-9d7c-271afd2395be
tags:
- blog
- sql
---

## Prologue
This guide is intended to promote a standard SQL coding style across the Strategic Information Services team at Griffith University.  It is guide, not canon.  Adapt as required.  I will also do this, and update this guide accordingly.

## Header

```
/* *************************************************************************************************
  Description:  
  Author:  Your name
  Create Date:  Date created
************************************************************************************************* */
```

## Basic select layout

* Avoid `select *`
* Commas at beginning rather than end of statements
* Your IDE's tab setting should be set to two spaces
* Use ANSI-92 joins, not SQL-86 joins (see [this Stack Overflow comment](http://stackoverflow.com/a/1599201/3827849))
* `--Annotate your code with comments!`
* Use whitespace to separate the logical parts of the query
* Write `where` statements as `where 1=1` to aid quick commenting / uncommenting of filter conditions without having to juggle `and` statements

```sql
-- inline comments should have a space between the second dash and the start of the comment
select
   a.col1    -- indent first select column by three spaces
  ,a.col2    -- indent second select column by two spaces, and include comma at start of line
  ,a.col3
  ,b.col4
  ,sum(b.col5) as col5

from table1 a

/*
  blank line between from and each join statement and comments
  preceding join indicating why join is required.
*/
left join table2 b      -- ANSI joins.  Omit "outer" keyword for left and right joins.
  on a.col1 = b.col1    -- indent join condition by 2 spaces
  and a.col2 = b.col2

where 1=1               -- always use "where 1=1" to facilitate easier commenting/uncommenting of filters 
  and a.col3 = 'Condition 1'
  and b.col4 != 'Condition 2'    -- use != rather than <>

group by
   a.col1
  ,a.col2
  ,a.col3
  ,b.col4

having sum(b.col5) > 100
```

---
