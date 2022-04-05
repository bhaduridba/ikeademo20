#!/usr/bin/env bash
## use pip to install required libraries
## ************************************************* ##
## ************************************************* ##

#gcloud components update
# Setup environment
export GOOGLE_APPLICATION_CREDENTIALS="/Users/sobhan/Documents/projects/ikeademo20/sa-dsm-ikeademo2-sb1.json"
# gcloud auth login

pip install -r requirements.txt

export REGION=us-central1
#export REGION=eu-north1
#echo $REGION
# git clone https://github.com/bhaduridba/ikeademo20.git .
# cd ikeademo20

## Create streaming source and destination sinks
## Create the Cloud Storage bucket

## Source is PROJECT 1 and PROJECT 2 is our DSM
export PROJECT_ID2='ikeademo2-sb1'
echo $PROJECT_ID2

#export PROJECT_ID2='ikeademo2-sb1'
#echo $PROJECT_ID2

#gcloud config set project $PROJECT_ID2
gcloud config set project $PROJECT_ID2

## 2
# create bucket to write the streaming events 
export SOURCE='cleveron'
export TARGET='dsm'
export CLEVERON_SOURCE_OUTPUT=${SOURCE}_${TARGET}_source
echo $CLEVERON_SOURCE_OUTPUT

# gs://ikeademo2-sb1-cleveron-dsm-input-files
gsutil mb -c regional -l ${REGION} gs://${CLEVERON_SOURCE_OUTPUT}

##3
# create bigquery dataset
export BQ_DEMO_DATASET3='jsondemo3'

bq --location='EU' mk -d \
--default_table_expiration 7200 \
--description "This is a JSON demo3 temporary dataset." \
${BQ_DEMO_DATASET3}

# create table
export BQ_DEMO_TABLE3='demo3'

bq mk \
  --table \
  --expiration 7200 \
  --description "This is a demo temporary table demo3" \
  --label organization:development \
  ${BQ_DEMO_DATASET3}.${BQ_DEMO_TABLE3} \
  jsondemo1schema.json
