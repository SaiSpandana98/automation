#!/bin/bash
arn=$(jq .TaskARN $ECS_CONTAINER_METADATA_FILE)
cluster=$(jq .Cluster $ECS_CONTAINER_METADATA_FILE)
temp="${arn%\"}"
temp="${temp#\"}"
cl="${cluster%\"}"
cl="${cl#\"}"
IFS='/' read -r -a array <<< $temp
taskId="${array[-1]}"
aws ecs stop-task --cluster $cl --task $taskId --region us-east-1
