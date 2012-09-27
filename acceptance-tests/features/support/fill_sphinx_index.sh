#!/bin/bash

# First create the xml string, then write it to testXML.xml, then tell sphinx to index it
# Change to directory of the bashscript file to be able to call subfiles no matter where the script is called form
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTDIR
testXMLFile="testXML.xml" 
documentsXML=$1
XMLSTART='<?xml version="1.0" encoding="utf-8"?>
<sphinx:docset>'
XMLEND="</sphinx:docset>"

# Remove old testXML
rm $testXMLFile

# Add new Xml to testXMLFile
echo $XMLSTART>>$testXMLFile
cat search_scheme.xml>>$testXMLFile
echo "">>$testXMLFile
echo $documentsXML >> $testXMLFile
echo $XMLEND >> $testXMLFile

#Now reindex sphinx
sudo -u sphinxsearch INDEX_TYPE=delta INDEX_SIZE=full indexer --config sphinx.conf.testXML --rotate index_delta_dev
sudo restart sphinxsearch
sleep 1
