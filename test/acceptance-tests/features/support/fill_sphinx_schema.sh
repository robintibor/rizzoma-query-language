sudo -u sphinxsearch INDEX_TYPE=delta INDEX_SIZE=full indexer --config /home/robintibor/work/rizzoma-query-language/test/acceptance-tests/features/support/sphinx.conf.emptyxml --rotate index_delta_dev
sudo restart sphinxsearch
sleep 1
