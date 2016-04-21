---
layout: post
title: SQL Style Guide
comments: true
disqus_id: e85b0126-38e8-4f6b-9c74-861189797115
tags:
- blog
- sql
---

## Basic select layout

```
select
   a.col1
  ,a.col2
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
  and b.col4 != 'Condition 2'

group by 
   a.col1
  ,a.col2
  ,a.col3
  ,b.col4

having sum(b.col5) > 100
```

---
