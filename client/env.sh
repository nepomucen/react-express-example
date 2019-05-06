#!/bin/bash

# Script takes 1 optional argument, that allows to specify location of .env file (defaults to current directory '.')
# resulting env-config.js file will be written to the same location

ARG1=${1:-.}
ENV_CFG_PATH="$ARG1/env-config.js"
ENV_DEFAULT_PATH="$ARG1/.env"

# Recreate config file
rm -rf "$ENV_CFG_PATH"
touch "$ENV_CFG_PATH"

# Add assignment 
echo "window._env_ = {" >> "$ENV_CFG_PATH"

# Read each line in .env file
# Each line represents key=value pairs
while read -r line || [[ -n "$line" ]];
do
  # Split env variables by character `=`
  if printf '%s\n' "$line" | grep -q -e '='; then
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')
  fi

  # Read value of current variable if exists as Environment variable
  value=$(printf '%s\n' "${!varname}")
  # Otherwise use value from .env file
  [[ -z $value ]] && value=${varvalue}
  
  # Append configuration property to JS file
  echo "  $varname: \"$value\"," >> "$ENV_CFG_PATH"
done < "$ENV_DEFAULT_PATH"

echo "}" >> "$ENV_CFG_PATH"