#!/bin/bash

# A better `kubectl get all -n <namespace>`

### see all resources in a namespace
# kubectl api-resources --verbs=list --namespaced -o name \
#  | xargs -n 1 kubectl get --show-kind --ignore-not-found -l <label>=<value> -n <namespace>
###
NAMESPACE=$1
RESOURCES=$(kubectl api-resources --verbs=list --namespaced -o name)

echo "Processing.."; echo "============"; echo ""
cnt='0'

for r in $RESOURCES
do
    echo $(kubectl get -n $NAMESPACE $r)
done

# if [ $cnt -eq 0 ]
# then    
#     echo "No resources found."
# fi
