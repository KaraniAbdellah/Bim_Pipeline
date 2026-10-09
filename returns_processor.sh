#!/bin/bash
INCOMING_DATA_PATH="input"
TRACHES_PATH="trash"
ARCHIVE_PATH="archive"
LOGS_PATH="logs"
TODAY_DATE=$(date '+%Y-%m-%d')
OUTPUT_PATH="output/report.csv"

countReturnByCategory() {
    echo "------ START --------"
    # Check if Folder Already Exit
    if [[ ! -d "$TRACHES_PATH" ]]; then
        # Create all required directories
        mkdir "$INCOMING_DATA_PATH" "$TRACHES_PATH" "$ARCHIVE_PATH" "$LOGS_PATH" "$(dirname "$OUTPUT_PATH")"
        touch "$OUTPUT_PATH"
        echo "[$(date +%Y-%m-%d--%H:%M)] ---- Create Folders ----" >> $LOGS_PATH/logs_$TODAY_DATE
        echo "[$(date +%Y-%m-%d--%H:%M)] ---- Create Folders ----"
    fi

    echo "[$(date +%Y-%m-%d--%H:%M)] -------------------------------------" >> $LOGS_PATH/logs_$TODAY_DATE
    echo "[$(date +%Y-%m-%d--%H:%M)] ---- Start Getting all csv files ----" >> $LOGS_PATH/logs_$TODAY_DATE

    echo "[$(date +%Y-%m-%d--%H:%M)] -------------------------------------"
    echo "[$(date +%Y-%m-%d--%H:%M)] ---- Start Getting all csv files ----"

    # Append id,date,city,reason,count to report.csv
    HEADER=$(head -n 1 $OUTPUT_PATH)
    echo $HEADER
    if [[ $HEADER != *id* ]]; then
        echo "[$(date +%Y-%m-%d--%H:%M)] Append Columns to report.csv" >> $LOGS_PATH/logs_$TODAY_DATE
        echo "[$(date +%Y-%m-%d--%H:%M)] Append Columns to report.csv"
    fi

    # Get CSV files from input folder
    for entry in `ls $INCOMING_DATA_PATH`; do
        # Get Where I need to Start Inserting
        ID=$(($(wc -l < $OUTPUT_PATH) - 1))
        echo "[$(date +%Y-%m-%d--%H:%M)] Get Id = $ID" >> $LOGS_PATH/logs_$TODAY_DATE
        echo "[$(date +%Y-%m-%d--%H:%M)] Get Id = $ID"

        # Check if CSV File
        echo "[$(date +%Y-%m-%d--%H:%M)] Start Checking Csv file" >> $LOGS_PATH/logs_$TODAY_DATE
        echo "[$(date +%Y-%m-%d--%H:%M)] Start Checking Csv file"
        COMPLET_PATH="$INCOMING_DATA_PATH/$entry"
        if [[ -f $COMPLET_PATH && $entry == *.csv ]]; then
            echo "**** Processed File ${COMPLET_PATH} ****"
            echo "[$(date +%Y-%m-%d--%H:%M)] **** Processed File ${COMPLET_PATH} ****" >> $LOGS_PATH/logs_$TODAY_DATE
            echo "[$(date +%Y-%m-%d--%H:%M)] **** Processed File ${COMPLET_PATH} ****"

            # Hide the First Line & Get Count By Catgory
            tail -n +2 $COMPLET_PATH |
            awk -F, -v start_id=$ID '
            {
                a[$3]+=1
                date=strftime("%Y-%m-%d")
                id=0
            }
            END {
                id=start_id
                for(i in a)
                    print ++id "," date "," $4 "," i  "," a[i];
            }
            ' >> $OUTPUT_PATH
            echo "[$(date +%Y-%m-%d--%H:%M)] Move Processing File $COMPLET_PATH To Arhive" >> $LOGS_PATH/logs_$TODAY_DATE
            echo "[$(date +%Y-%m-%d--%H:%M)] Move Processing File $COMPLET_PATH To Arhive"

            # Move Processed File to Archive
            mv $COMPLET_PATH $ARCHIVE_PATH/$(basename $COMPLET_PATH)_$TODAY_DATE
            echo "[$(date +%Y-%m-%d--%H:%M)] Finich Processing File $COMPLET_PATH" >> $LOGS_PATH/logs_$TODAY_DATE
            echo "[$(date +%Y-%m-%d--%H:%M)] Finich Processing File $COMPLET_PATH"
        else
            # move file to traches folder
            mv $COMPLET_PATH $TRACHES_PATH/$(basename $COMPLET_PATH)_$TODAY_DATE
            echo "$entry is not csv file"
            echo "[$(date +%Y-%m-%d--%H:%M)] $entry is not csv file move it" >> $LOGS_PATH/logs_$TODAY_DATE
            echo "[$(date +%Y-%m-%d--%H:%M)] $entry is not csv file move it"
        fi
    done
}

countReturnByCategory
