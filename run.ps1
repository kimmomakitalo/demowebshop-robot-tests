# Runs the Robot Framework tests. Any extra arguments are passed to robot.
#   .\run.ps1                              all tests, headless
#   .\run.ps1 --variable HEADLESS:False    watch the browser
#   .\run.ps1 --test "Home Page Loads"     a single test

# Robot crashes with the system-wide PYTHONIOENCODING=utf-8:surrogateescape, so override it for this run only.
$env:PYTHONIOENCODING = 'utf-8'
robot --outputdir "$PSScriptRoot\results" @args "$PSScriptRoot\tests"
