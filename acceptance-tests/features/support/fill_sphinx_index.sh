#!/bin/bash

# First create the xml string, then write it to testXML.xml, then tell sphinx to index it
testXMLFile="/home/robintibor/work/rizzoma-query-language/acceptance-tests/features/support/testXML.xml" 
documentsXML=$1
XMLSTART='<?xml version="1.0" encoding="utf-8"?>
<sphinx:docset>'
XMLEND="</sphinx:docset>"

# Remove old testXML
rm $testXMLFile

# Add new Xml to testXMLFile
echo $XMLSTART>>$testXMLFile
cat /home/robintibor/work/rizzoma-query-language/acceptance-tests/features/support/search_scheme.xml>>$testXMLFile
echo "">>$testXMLFile
echo $documentsXML >> $testXMLFile
echo $XMLEND >> $testXMLFile

#Now reindex sphinx
sudo -u sphinxsearch INDEX_TYPE=delta INDEX_SIZE=full indexer --config /home/robintibor/work/rizzoma-query-language/acceptance-tests/features/support/sphinx.conf.testXML --rotate index_delta_dev
sudo restart sphinxsearch
sleep 1

