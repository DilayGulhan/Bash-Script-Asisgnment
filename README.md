# Bash Script Assignment
This Bash script is designed to automate the grading process for student submissions. It checks for correct submission formats, runs student scripts, and grades based on output differences compared to a golden output file.

## Features
# Directory Setup: 
Creates a grading directory if it doesn't already exist.
## Argument Validation:
Ensures that exactly 3 parameters are provided, including the maximum grade, the correct output file, and the submission folder.
## File Validation: 
Checks if the submission folder exists and is not empty, and if the correct output file exists.
## File Permission Check: 
Makes student scripts executable if they are not already.
## File Format Validation: 
Verifies that student script filenames follow the correct format.
## Execution Time Check: 
Limits script execution time to 60 seconds, logging any timeouts.
## Grading: 
Compares student script output to a golden output file and calculates grades based on differences.
# Usage
Prepare the Environment: Ensure the grading directory exists.

### Run the Script: 
./grading_script.sh <max_grade> <golden_output_file> <submission_folder>
