#!/bin/bash
# Update the project id, private key file, known_hosts file
# Execution: prefetch.sh http://sample.com/file

PROJECT=dave-selfstudy01
KEY=~/.ssh/prefetch_key
KNOWN_HOSTS=~/.ssh/known_hosts

FETCH_URL=$1

:> result.log
for host in $(gcloud compute instances list --filter="name~'cdn-prefetch*'" --format="csv[no-heading](EXTERNAL_IP)")
do
	echo "running on $host" >> result.log
	nohup ssh -oStrictHostKeyChecking=no -i $KEY prefetch@$host curl $FETCH_URL -o download >> result.log 2>&1 &
done
echo 'done!'
