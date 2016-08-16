# Get standard gitignore files for the passed in arguments
#
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
