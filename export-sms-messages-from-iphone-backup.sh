#!/usr/bin/env bash

timestamp=$(date +%s)
sqlite_location="/usr/bin/"
sqlite_db_path="$HOME/Library/Application Support/MobileSync/Backup/844cdc31973c83ab0a269ed782ee912195a5d90b"
sqlite_db_filename="3d0d7e5fb2ce288813306e4d4636395e047a3d28"

source shell-utils.sh

print_header "Exporting SMS messages from local iPhone backup"

check_database () {
  print_message "Checking SQLite database..."
  if [ -f "$sqlite_db_path/$sqlite_db_filename" ]; then
    indicator_green
    print_message "Making a local copy of the SQLite database..."
    cp "$sqlite_db_path/$sqlite_db_filename" .
    indicator_green
  else
    indicator_red
    print_message "Database file cannot be found..." "\n"
    exit 1
  fi
}

extract_data () {
  print_message "Extracting data from database..."
  $sqlite_location/sqlite3 "$sqlite_db_filename" <<EOF
.mode csv
.once SMSes.csv
SELECT date, text FROM message ORDER BY date;
.exit
.quit
EOF
  indicator_green
}

rename_file () {
  print_message "Renaming export file (adding timestamp)..."
  if [ -f "SMSes.csv" ]; then
    mv SMSes.csv sms-messages-$timestamp.csv
    indicator_green
  else
    indicator_red
    print_message "Exported data file (SMSes.csv) cannot be found..." "\n"
    exit 1
  fi
}

clean_up () {
  print_message "Deleting local DB file copies..."
  if [ -f "$sqlite_db_filename" ]; then
    rm "./$sqlite_db_filename"*
    indicator_green
  else
    indicator_red
    print_message "Database file cannot be found..." "\n"
    exit 1
  fi
}

  check_database
  extract_data
  rename_file
  clean_up

exit 0
