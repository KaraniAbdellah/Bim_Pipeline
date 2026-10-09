#!/bin/bash
INCOMING_DATA_PATH="input"
TRACHES_PATH="trash"
ARCHIVE_PATH="archive"
OUTPUT_PATH="output/report.csv"
TODAY_DATE=$(date '+%Y-%m-%d')
### GOAL: Count Returns by category, for all 3 branches


countReturnByCategory() {
    echo "---- Start Getting all csv files ----"
    # Append id,date,city,reason,count to report.csv
    HEADER=$(head -n 1 $OUTPUT_PATH)
    echo $HEADER
    if [[ $HEADER != *id* ]]; then
        echo "id,date,city,reason,count" >> $OUTPUT_PATH
    fi
    # Get CSV files from input folder
    for entry in `ls $INCOMING_DATA_PATH`; do
        ID=0
        # Check if CSV File
        COMPLET_PATH="$INCOMING_DATA_PATH/$entry"
        if [[ -f $COMPLET_PATH && $entry == *.csv ]]; then
            echo "**** Processed File ${COMPLET_PATH} ****"
            # Hide the First Line & Get Count By Catgory
            # id,date,city,reason,count
            tail -n +2 $COMPLET_PATH |
            awk -F, '
            {
                a[$3]+=1
                date=strftime("%Y-%m-%d")
                id=$ID
            }
            END {
                for(i in a)
                    print ++id "," date "," $4 "," i  "," a[i];
            }
            ' >> $OUTPUT_PATH
        else
            # move file to traches folder
            mv $COMPLET_PATH $TRACHES_PATH/$(basename $COMPLET_PATH)_$TODAY_DATE
            echo "$entry is not csv file"
        fi
    done
}
countReturnByCategory

# Look at Columns (reason, category)
# Count How Many prodcut returned by catogory (defective, wrong_item, changed_mind)
# Archive the processed file with today's date, exactly like the lab.

# Append Them in output/report.csv file as (id,date,city,reason,count)
# Created Them As Function
