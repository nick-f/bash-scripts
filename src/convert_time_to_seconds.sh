#!/usr/bin/env bash

convert_time_to_seconds() {
  local input_string="$1"
  local number
  local unit
  local seconds_per_unit
  local total_seconds

  [[ $input_string =~ ^([0-9]+\.?[0-9]*) ]]

  local number=${BASH_REMATCH[1]}

  if [[ $input_string == *"second"* ]]; then unit="seconds"; fi
  if [[ $input_string == *"minute"* ]]; then unit="minutes"; fi
  if [[ $input_string == *"hour"* ]]; then unit="hours"; fi
  if [[ $input_string == *"day"* ]]; then unit="days"; fi
  if [[ $input_string == *"week"* ]]; then unit="weeks"; fi

  case $unit in
  "seconds")
    seconds_per_unit=1
    ;;
  "minutes")
    seconds_per_unit=60
    ;;
  "hours")
    seconds_per_unit=3600
    ;;
  "days")
    seconds_per_unit=86400
    ;;
  "weeks")
    seconds_per_unit=604800
    ;;
  *)
    echo "Unsupported unit: $unit" >&2
    return 1
    ;;
  esac

  total_seconds=$(echo "$number * $seconds_per_unit" | bc -l)

  # Remove trailing `.0` or `.00`, etc. if present
  if [[ $total_seconds =~ \.0+$ ]]; then
    total_seconds=$(printf "%.0f" "$total_seconds")
  fi
  echo "$total_seconds"
}

convert_time_to_seconds "$1"
