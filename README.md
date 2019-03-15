# TaskTracker

## Some design decisions / concerns with the code currently:

* There is a bug where if you try to create a task without an assignee, it has trouble loading the tasks pages afterward. So make sure there is an assignee selected. 
* Under /tasks, I decided to display the underlings' tasks first, and then a list of all tasks for manager users. For underlings, currently it displays the regular tasks list without the "underlings tasks" section. 
* The buttons to modify timeblocks are on the tasks -> show page, when opening a single task to view it. 
