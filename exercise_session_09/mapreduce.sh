#!/bin/bash
cat trump_tweets_01.csv | python2 mapper.py| sort | python2 reducer.py > pymapred.out
