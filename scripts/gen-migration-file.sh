#!/bin/bash

# Function to handle Ctrl+C
trap "echo -e '\nScript interrupted by user'; exit" SIGINT

# Default migrations directory relative to the current directory
default_migrations_dir="./db/migrations"

# Use the first argument as the migrations directory if provided, otherwise use the default
migrations_dir="${1:-$default_migrations_dir}"

# Ensure the migrations directory exists
mkdir -p "$migrations_dir"

# Prompt the user for a description of the migration
read -p "Enter the description of the Flyway migration change (press Enter to exit): " description

# Exit if the description is empty
if [ -z "$description" ]; then
  echo "No description provided. Exiting."
  exit 0
fi

# Get the latest version number from existing migration files
latest_version=$(ls $migrations_dir | grep -E '^V[0-9]+__' | sort -V | tail -n 1 | sed -E 's/^V([0-9]+)__.*$/\1/')

# Increment the version number
if [ -z "$latest_version" ]; then
  new_version=1
else
  new_version=$((latest_version + 1))
fi

# Format the new version number with leading zeros (optional)
formatted_version=$(printf "%04d" $new_version)

# Create the new migration file name
migration_file="$migrations_dir/V${formatted_version}__$(echo $description | tr ' ' '_').sql"

# Create the new migration file with the description as a comment at the top
echo "-- $description" > $migration_file

# Notify the user
echo "Created new Flyway migration file: $migration_file"