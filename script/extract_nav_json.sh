#!/bin/bash

# Download the NAV data and convert to JSON
nav_url="https://www.amfiindia.com/spages/NAVAll.txt"
output_file="amfi_nav_data_$(date +'%Y%m%d').json"

# Fetch the data and process it to JSON
echo "[" > "$output_file"
curl -s "$nav_url" | awk -F ';' '
{
    if ($4 ~ /[0-9]+\.[0-9]+/) {
        if (NR > 1) printf ",\n"
        printf "  {\n"
        printf "    \"scheme_name\": \"%s\",\n", $4
        printf "    \"asset_value\": \"%s\"\n", $5
        printf "  }"
    }
}
END {
    printf "\n"
}' >> "$output_file"
echo "]" >> "$output_file"

echo "Data extracted to $output_file"