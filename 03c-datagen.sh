#!/usr/bin/env bash
## use pip to install required libraries
## ************************************************* ##
## ************************************************* ##

#gcloud components update
# Setup environment
export GOOGLE_APPLICATION_CREDENTIALS="/Users/sobhan/Documents/projects/ikeademo20/sa-dsm-ikeademo2-sb1.json"
#gcloud auth login
#pip install google-cloud-pubsub
#pip3 install apache_beam
pip install -r requirements.txt

export REGION=us-central1
#echo $REGION

export PROJECT_ID1='ingka-dsm-dataplatform-dev'
#echo $PROJECT_ID1

gcloud config set project $PROJECT_ID1

## 1
## Create a Pub/Sub topic, called streaming_topic, 
## to handle streaming events (this is SOLACE topic)
export SOURCE='cleveron'
# ikeademo1-sb1-cleveron-streaming-topic
export STREAMING_TOPIC=${PROJECT_ID1}-${SOURCE}-streaming-topic1
#echo $STREAMING_TOPIC


#cat data.json | while read line; do gcloud pubsub topics publish <YOUR_INPUT_TOPIC_NAME> --message "$line"; done

cat data.json | while read line; do gcloud pubsub topics publish ${STREAMING_TOPIC} --message "$line"; done

