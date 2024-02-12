# autoGrader
I am lazy; therefore, I spend hours coding a script so that I don't need to tally grades. 

# Instructions
## `setupGradingEnvironment.m`
This script will take a directory of student submissions, like those downloaded from Canvas/Assignment/Download all:
![](https://i.imgur.com/nmpoiNu.png)

It will then extract any zipped files or directories into a format that is compatible with autograder.m.

## `autoGrader.m`
When grading, mark deductions starting on a new line with `%!`. End the line with a number in parentheses totalling the deduction. e.g.
`%! Error with disp() (-5)`

## `prepareForReturn.m`
This script will take the graded submissions and prepare them for return to the students. It will zip each graded student's submission and place it in a directory called "GradedSubmissions".