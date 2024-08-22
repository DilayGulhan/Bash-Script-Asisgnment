#!/bin/bash

create_grading() {
    if [ ! -d "grading" ]; then
    	echo "Creating grading folder..." 
        mkdir "grading"
    fi
}

create_grading
echo "Checking arguments.." 
if [[ $# != 3 ]]
 then
    echo "ERROR: Please Enter 3 parameters!" >> log.txt
    exit 1
fi

if [[ $1 -le 0 ]]
then 
   echo "Max grade should be a positive integer"
   exit 1 
fi 

if [[ ! -d $3 ]]
then
echo "Submission folder does not exist" 
exit 1
fi


file_number=$( ls $3 | wc -l )

if [[ $file_number = 0 ]]
then 
echo "Submission folder is empty"
exit 1
else 
echo "$file_number student submitted their homework"
fi 

if [[ ! -f $2 ]]
then
echo "Correct output file does not exist" 
exit 1 
fi



check_exec() {
    
    if [[ ! -x $1 ]]; then
        echo "Changed the permission of $1 to executable"
        chmod +x $1
    fi

    file_name="322_h1_[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].sh"
    
    if [[ ! $1 =~ $file_name ]]; then
        echo "Incorrect file format: $1" >> log.txt
        echo "Incorrect file name" 
        return 1
    fi
    return 0 
}

check_out() {
    if [ -f "out.txt" ]
     then
        mv "out.txt" "grading/322_h1_${substring}_out.txt"
    fi
}

take_substring() {
    content="$1"
    substring=$(echo ${content} | cut -d '_' -f 3 | cut -d '.' -f 1)
}

check_exec_time() { 
    
    timeout 60 bash "$1" > out.txt 2>&1
    
   
    if [ $? -eq 124 ]; then
        take_substring "$1"
        echo "Timeout has occured" 
        echo "$substring: Too long execution " >> log.txt
        echo "Student ID: $substring  Grade: 0" >> result.txt
        check_out
    fi
}

for file in $3/*; do
    take_substring "$file"
    echo "Grading process for $file started" 
    check_exec "$file"
    if [ $? -ne 0 ]; then
        continue
    fi
    echo "id is $substring"
    check_exec_time "$file"
    
    if [ -f "out.txt" ]; then
        different_lines=$(diff "golden.txt" "out.txt" | grep "<" | wc -l)
        max_score=$1
        score=$((max_score - different_lines))
        take_substring "$file"
        echo "Student ID : $substring Grade: $score" >> result.txt
        mv "out.txt" "grading/322_h1_${substring}_out.txt"
    fi
done

