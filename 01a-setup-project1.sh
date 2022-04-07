#!/usr/bin/env bash
## use pip to install required libraries
## ************************************************* ##
## ************************************************* ##

# 1. setup gcloud in your local laptop or in a cloud vm 
#    gcloud components update
# Setup environment
# create a service account in DSM project for Locker
# I have create a service account sa-dsm-ikeademo2-sb1
# create key and use it for the script

### KEEP THE KEY CONFIDENTIAL ###
export GOOGLE_APPLICATION_CREDENTIALS="/Users/sobhan/Documents/projects/ikeademo20_b/sa-dsm-ikeademo2-sb1.json"

# OTHERWISE YOU CAN USE YOUR EMAIL 
# gcloud auth login

pip install -r requirements.txt

#### FOR SOME REASON EU-NORTH-1 DID NOT WORK ###
#export REGION=eu-north1
export REGION=us-central1
#echo $REGION

#### GIT CLONE my code and follow through 
# git clone https://github.com/bhaduridba/ikeademo20_b.git .
# cd ikeademo20_b

## Source is PROJECT 1 where we get Streaming data from SOLACE pubsub+ topic
## in our PoC we will mock-up that SOLACE Queue with a sample PubSub topic in our dev project
## Once we get access to SOLACE queue we can  replace that with all relevant details

export PROJECT_ID1='ikeademo1-sb1'
#echo $PROJECT_ID1
gcloud config set project $PROJECT_ID1

# and PROJECT 2 is our DSM

#export PROJECT_ID2='ikeademo2-sb1'
#echo $PROJECT_ID2

## 1
## Create a Pub/Sub topic, called streaming_topic, 
## to handle streaming events (this is SOLACE topic)
export SOURCE='cleveron'

export STREAMING_TOPIC=${PROJECT_ID1}-${SOURCE}-streaming-topic1
#echo $STREAMING_TOPIC
# ikeademo1-sb1-cleveron-streaming-topic
gcloud pubsub topics create ${STREAMING_TOPIC}

## creating a notification
#gsutil notification create -t projects/${PROJECT_ID2}/topics/${STREAMING_TOPIC} -f  \
#                    json gs://${output_dir}

# creating a subscription for source topic (SOLACE)
gcloud pubsub subscriptions create sub1-${STREAMING_TOPIC}  \
            --topic projects/${PROJECT_ID1}/topics/${STREAMING_TOPIC}

exit







