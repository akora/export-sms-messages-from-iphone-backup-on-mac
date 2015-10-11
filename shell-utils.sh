#!/usr/bin/env bash

color_red=$(tput setaf 1)
color_amber=$(tput setaf 3)
color_green=$(tput setaf 76)
color_reset=$(tput sgr0)

timestamp () {
  date "+%Y-%m-%d %H:%M:%S"
}

print_header () {
  title=$1
  title_length=${#title}
  header_length=76
  fill_character="*"
  number_of_fill_characters=$(((($header_length-2)-$title_length)/2))
  printf '%*s' "$number_of_fill_characters" | tr ' ' "$fill_character"
  if [ $((title_length%2)) -eq 0 ]; then
    printf '%s' " $title "
  else
    printf '%s' " $title $fill_character"
  fi
  printf '%*s\n' "$number_of_fill_characters" | tr ' ' "$fill_character"
}

print_message () {
  message=$1
  line_break=$2
  printf "%-67s${line_break}" "=== $message"
}

print_message_with_param () {
  message=$1
  param=$2
  printf "%-38s %28s" "=== $message" $param
}

print_message_with_timestamp () {
  message=$1
  line_break=$2
  printf "%-67s${line_break}" "$(timestamp) === $message"
}

indicator_red () {
  printf "${color_red}%9s${color_reset}\n" "[FAILED]"
}

indicator_amber () {
  printf "${color_amber}%9s${color_reset}\n" "[!!]"
}

indicator_green () {
  printf "${color_green}%9s${color_reset}\n" "[OK]"
}

# Usage for the below:
#
# Put the following lines into the main control flow of your script:
#
#  time_script_start
#
#  main script control flow steps...
#
#  time_script_end
#  time_script_total_runtime
#
# This will measure the total run time and print out the following:
#
#  === Total runtime: ... seconds

time_script_start () {
  start=$(date +%s.%n)
}

time_script_end () {
  end=$(date +%s.%n)
}

time_script_total_runtime () {
  diff=$(echo "$end - $start" | bc)
  print_message "Total runtime: $diff seconds" "\n"
}
