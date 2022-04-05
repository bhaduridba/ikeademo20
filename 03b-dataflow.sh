#!/usr/bin/env bash
## use pip to install required libraries
## ************************************************* ##
## ************************************************* ##

#gcloud components update
# Setup environment
export GOOGLE_APPLICATION_CREDENTIALS="/Users/sobhan/Documents/projects/ikeademo20/sa-dsm-ikeademo2-sb1.json"
#gcloud auth login
pip install -r requirements.txt

export REGION=us-central1
echo $REGION

export PROJECT_ID1='ikeademo1-sb1'
echo $PROJECT_ID1

export PROJECT_ID2='ikeademo2-sb1'
echo $PROJECT_ID2

gcloud config set project $PROJECT_ID2

export SOURCE='cleveron'
export TARGET='dsm'

export STREAMING_TOPIC=${PROJECT_ID1}-${SOURCE}-streaming-topic1

export CLEVERON_SOURCE_OUTPUT=${SOURCE}_${TARGET}_source
echo $CLEVERON_SOURCE_OUTPUT

export BQ_DEMO_DATASET3='jsondemo3'
echo $BQ_DEMO_DATASET3
export BQ_DEMO_TABLE3='demo3'
echo $BQ_DEMO_TABLE3


gcloud dataflow jobs run demo23  \
--gcs-location gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery  \
--region $REGION  \
--max-workers 3  \
--num-workers 2  \
--service-account-email sa-dsm@ikeademo2-sb1.iam.gserviceaccount.com  \
--staging-location gs://${CLEVERON_SOURCE_OUTPUT}/temp  \
--parameters inputTopic=projects/${PROJECT_ID1}/topics/${STREAMING_TOPIC},outputTableSpec=${PROJECT_ID2}:${BQ_DEMO_DATASET3}.${BQ_DEMO_TABLE3}



