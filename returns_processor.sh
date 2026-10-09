#!/bin/bash
INCOMING_DATA_PATH="input"
TRACHES_PATH="trash"
ARCHIVE_PATH="archive"
TODAY_DATE=$(date '+%Y-%m-%d')
### GOAL: Count Returns by category, for all 3 branches


countReturnByCategory() {
    echo "---- Start Getting all csv files ----"
    # Get CSV files from input folder
    for entry in `ls $INCOMING_DATA_PATH`; do
        # Check if CSV File
        COMPLET_PATH="$INCOMING_DATA_PATH/$entry"
        if [[ -f $COMPLET_PATH && $entry == *.csv ]]; then
            echo "**** Processed File ${COMPLET_PATH} ****"

            # Hide the First Line & Get Count By Catgory For Each File
            data=$(awk -F, '{a[$3]=NR;}END{for(i in a)print i", "a[i];}' $COMPLET_PATH)
            echo $data
        else
            # move file to traches folder
            mv $COMPLET_PATH $TRACHES_PATH/$(basename $COMPLET_PATH)_$TODAY_DATE
            echo "$entry is not csv file"
        fi
        mv "$file" "archive/$(basename "$file" .csv)_$TODAY.csv"
    done
}
countReturnByCategory

# Look at Columns (reason, category)
# Count How Many prodcut returned by catogory (defective, wrong_item, changed_mind)
# Archive the processed file with today's date, exactly like the lab.

# Append Them in output/report.csv file as (id,date,city,reason,count)
# Created Them As Function


awk -F, '{a[$3]=NR;}^CD{for(i in a)print i", "a[i];}' returns_agadir.csv
