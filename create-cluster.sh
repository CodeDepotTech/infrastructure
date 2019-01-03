gcloud container clusters create \
--enable-autoupgrade \
--machine-type=n1-standard-2 \
--preemptible \
--enable-autoscaling \
--max-nodes=5 \
--min-nodes=0 \
cluster01