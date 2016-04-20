---
layout: post
title:  "Generate PDFs with Flying Saucer + Handlebars.java"
date:   2016-04-10 09:32:14
tags: pdf handlebars java
---
When it comes to generate PDFs using Java the de facto solution is Jasper Reports. Even though it provides a bunch of features and a great set of tools , such as iReport and JasperSoft Studio, the developer might want a simpler and flexible approach.
Recently I was involved in a project where I had to craft reports but I felt that using iReport was getting more and more kludgy and messy with lots of subreports. Then I gave Flying Saucer a try and never looked back. For the template engine Handlebars.java was chosen due to its simplicity and my previous experience with Handlebars.js.

### Enough talking, show me some code ###
