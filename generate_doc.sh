#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm -rf $DIR/doc_rdoc/
rm -rf $DIR/doc_yard/
rdoc --root="$DIR" -x $DIR/cache/ -x spec/ -x data/ -x coverage/ -x doc_rdoc/ -x log.txt -x wordlist.txt -x debug.log -o $DIR/doc_rdoc
yard doc --protected --private -o $DIR/doc_yard/ --exclude "\/(doc_.+?\|cache|spec|data|coverage)/" --exclude "log\.txt" --exclude "wordlist\.txt" --exclude "debug\.log"
