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
export PROJECT_ID1='ikeademo1-sb1'
echo $PROJECT_ID1

#export PROJECT_ID2='ikeademo2-sb1'
#echo $PROJECT_ID2

#gcloud config set project $PROJECT_ID2
gcloud config set project $PROJECT_ID1

## 1
## Create a Pub/Sub topic, called streaming_topic, 
## to handle streaming events (this is SOLACE topic)
export SOURCE='cleveron'
# ikeademo1-sb1-cleveron-streaming-topic
export STREAMING_TOPIC=${PROJECT_ID1}-${SOURCE}-streaming-topic1
echo $STREAMING_TOPIC
# ikeademo1-sb1-cleveron-streaming-topic
gcloud pubsub topics create ${STREAMING_TOPIC}

## creating a notification
#gsutil notification create -t projects/${PROJECT_ID2}/topics/${STREAMING_TOPIC} -f  \
#                    json gs://${output_dir}

# creating a subscription for source topic (SOLACE)
gcloud pubsub subscriptions create sub1-${STREAMING_TOPIC}  \
            --topic projects/${PROJECT_ID1}/topics/${STREAMING_TOPIC}


