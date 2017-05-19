# Restaurantr
---
Restaurantr is an app that returns New York City restaurants with health grades of A or B. 

Search by cuisine to get a list of ten matching most recently graded restaurants. 

It has one model called Restaurant with name, address, cuisine, grade, and grade_date.

* name, address, cuisine are strings with cuisine having a limit of 100 characters. No cuisines are currently longer than that. 
* grade is using enums so stored as an integer. 
* grade_date is stored as a DateTime so it's possible to filter on it.

ERD: [erd.pdf](https://github.com/alexshook/restaurantr/blob/master/erd.pdf)
