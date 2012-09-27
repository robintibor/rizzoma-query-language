#!/bin/bash
# Script creates directories and runs first indexing
echo "clean:1/5 remove old data files"
sudo rm -rf /var/lib/sphinxsearch/data/

if [ -z $INDEX_SUFFIX ]; then
    INDEX_SUFFIX="_dev"
fi

SPHINX_DELTA=/var/lib/sphinxsearch/data/delta_tmp${INDEX_SUFFIX}
SPHINX_MAIN=/var/lib/sphinxsearch/data/main_tmp${INDEX_SUFFIX}

if [ -e $SPHINX_DELTA ] && [ -e $SPHINX_MAIN ]; then
    echo "${SPHINX_DELTA} or ${SPHINX_MAIN} already linked"
    exit 1
fi

sudo service sphinxsearch stop
sleep 1

cd $(dirname $0)/../

echo "clean:2/5 Creating dirs for indexes"

DATE=$(date +%Y-%m-%d_%H:%M:%S)
REAL_DELTA=/var/lib/sphinxsearch/data/${DATE}_delta${INDEX_SUFFIX}
REAL_MAIN=/var/lib/sphinxsearch/data/${DATE}_main${INDEX_SUFFIX}

sudo mkdir -p $REAL_DELTA
sudo mkdir -p $REAL_MAIN
sudo ln -s $REAL_DELTA $SPHINX_DELTA
sudo ln -s $REAL_MAIN $SPHINX_MAIN
sudo mkdir -p /var/log/sphinxsearch

echo "clean:3/5 Changing directories owner"

sudo chown -R sphinxsearch /var/log/sphinxsearch /var/lib/sphinxsearch /var/run/sphinxsearch

echo "clean:4/5 Creating empty indexes"

sudo -u sphinxsearch INDEX_TYPE=main indexer --rotate index_main_tmp${INDEX_SUFFIX}
sudo -u sphinxsearch INDEX_TYPE=delta INDEX_SIZE=empty indexer --rotate index_delta_tmp${INDEX_SUFFIX}

echo "clean:5/5 Renaming symbolic links"

PERMANENT_SPHINX_DELTA=${SPHINX_DELTA/_tmp_/_}
PERMANENT_SPHINX_MAIN=${SPHINX_MAIN/_tmp_/_}

sudo mv $SPHINX_DELTA $PERMANENT_SPHINX_DELTA
sudo mv $SPHINX_MAIN $PERMANENT_SPHINX_MAIN



sudo service sphinxsearch start

