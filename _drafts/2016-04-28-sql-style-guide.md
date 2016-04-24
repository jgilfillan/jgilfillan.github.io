---
layout: post
title: SQL Style Guide
comments: true
disqus_id: 
tags:
- blog
- sql
---

## Basic select layout

```sql
-- inline comments should have a space between the second dash and the start of the comment
select
   a.col1    -- indent first select column by three spaces
  ,a.col2    -- indent second select column by two spaces, and include comma at start of line
  ,a.col3
  ,b.col4
  ,sum(b.col5) as col5
from table1 a

-- blank line between from and each join statement and comment preceding join indicating why join is required
left join table2 b      -- ANSI joins
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
