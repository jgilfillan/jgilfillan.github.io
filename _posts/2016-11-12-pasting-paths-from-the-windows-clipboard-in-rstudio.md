---
layout: post
title: Pasting paths from the Windows clipboard in RStudio
comments: true
disqus_id: eb0a2795-cee3-4ee7-97b1-8dcf5436acc0
tags:
- blog
- R
- rstudio
---

## Problem
Windows use of the backslash `\`  to delimit folders and files in paths is a cause of frustration.  Why couldn't they just have used a slash `/`?

R sees `\` within strings as an escape character, so Windows R users have two options when pasting paths into an RStudio worksheet:

  1. Find `\` and replace with `\\`
  2. Find `\` and replace with `/`.

Doing this repeatedly can be tedios, but using the RStudio snippets feature makes pasting Windows paths much simpler.

## Solution
Define an [RStudio snippet](https://support.rstudio.com/hc/en-us/articles/204463668-Code-Snippets) as follows:

```R
snippet pp
	"`r gsub("\\\\", "\\\\\\\\\\\\\\\\", readClipboard())`"
```

This snippet converts backslashes `\` into double backslashes `\\`.  The following version will work if you prefer to convert backslahes to forward slashes `/`.

```R
snippet pp
	"`r gsub("\\\\", "/", readClipboard())`"
```

Once your preferred snippet is defined, paste a path from the clipboard by typing `pp <TAB> <ENTER>` (that is `pp` and then the tab key and then enter) and the path will be magically inserted with R friendly delimiters.

I have an additional snippet defined which uses the above trick to set the working directory:

```R
snippet swd
  setwd("`r gsub("\\\\", "\\\\\\\\\\\\\\\\", readClipboard())`")
```

So if I had copied `C:\myworkingdir` to the clipboard, typing `swd <TAB>` would insert `setwd("C:\\myworkingdir")` in my current cursor position.

If you find this hack useful, please leave a comment!  Also, I'd love to hear what your top tips/tricks are for working with R/RStudio - leave them in the comments below.
