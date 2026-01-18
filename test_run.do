* ================================
* test_run.do
* ================================

clear all
set more off

display "Hello, Stata! VS Code is connected successfully."

sysuse auto, clear

summarize price mpg weight

reg price mpg weight

display "Test run finished."

