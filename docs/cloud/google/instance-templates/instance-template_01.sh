#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.



# https://cloud.google.com/compute/docs/instance-templates/create-instance-templates

# $ gcloud compute instance-templates create [INSTANCE_TEMPLATE_NAME]


# If you do not provide explicit template settings, gcloud compute creates a template with the following default values:

#     Machine type: n1-standard-1
#     Image: The latest Debian image
#     Boot disk: A new standard boot disk named after the instance
#     Network: The default VPC network
#     IP address: An ephemeral external IP address

# gcloud compute instance-templates create example-template-custom \
#     --machine-type n1-standard-4 \
#     --image-family debian-9 \
#     --image-project debian-cloud \
#     --boot-disk-size 250GB

