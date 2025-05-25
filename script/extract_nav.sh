#!/bin/bash

# Download the NAV data
nav_url="https://www.amfiindia.com/spages/NAVAll.txt"
output_file="amfi_nav_data_$(date +'%Y%m%d').tsv"

# Fetch the data and process it
curl -s "$nav_url" | awk -F ';' '
BEGIN {
    print "Scheme Name\tAsset Value (₹)"
}
{
    if ($4 ~ /[0-9]+\.[0-9]+/) {
        printf "%s\t%s\n", $4, $5
    }
}' > "$output_file"

echo "Data extracted to $output_file"