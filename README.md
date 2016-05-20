# shell-processparent
A shell script ‘process_parents' that will show a process and all of it’s parents.

Script accepts a parameter giving the process id (pid) to use as a starting point. If no parameter is given then the current process id (the script’s parent process) will be used. If a second parameter is provided then stop when that process id is reached. Remember that there may be parent processes that are not owned by you and those errors are handled as well. (for example insufficient permissions, process id’s that are or become invalid).
