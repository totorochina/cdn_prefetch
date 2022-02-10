#!/bin/bash
# Update the project id, private key file, known_hosts file
# Execution: prefetch.sh http://sample.com/file

PROJECT=dave-selfstudy01
KEY=~/.ssh/prefetch_key
KNOWN_HOSTS=~/.ssh/known_hosts

FETCH_URL=$1

echo '' > result.log
for host in $(gcloud compute instances list --filter="name~'cdn-prefetch*'" --format="csv[no-heading](EXTERNAL_IP)")
do
	echo "running on $host"
	ssh -oStrictHostKeyChecking=no -i $KEY prefetch@$host curl $FETCH_URL -o download 2>&1 >> result.log &
done
echo 'done!'
