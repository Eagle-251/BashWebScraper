#!/bin/bash

Names=$(curl -s https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops | grep -o 'class="title.*"' | awk -F "=" {'print $3'} | sed 's/\"/\\n/; s/&quot/\"/; s/;.*//; s/\"//; s/\\n/|/g' | sed -e '1s/^.//')

Prices=$(curl -s https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops | grep -o 'class="pull-right price.*' | awk -F "<**>" {'print $2'} | sed 's/<.*//')

Descriptions=$(curl -s https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops | grep -o 'class="description.*' | sed 's/class="description">//; s/<\/p>/|/; s/&quot/inch/')

numberOfRecords=$(($(echo $Names | tr '|' '\n' | wc -l) + 1))

resultTable() {
    #echo "$(tput bold)Laptop Price Description$(tput sgr0)" | column --table
    for ((i = 1; i < $numberOfRecords; i++)); do
        printf "$(echo $Names | cut -d "|" -f $i) $(echo $Prices | cut -d " " -f $i) $(echo $Descriptions | cut -d "|" -f $i)\n ----- \n" | column --table
    done
}

resultTable
