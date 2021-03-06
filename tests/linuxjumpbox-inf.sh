#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi
az account set --subscription $subscriptionid

echo "creating linuxjumpbox"
az group deployment create \
--name sapbitsDeployment \
--resource-group $rgname \
--template-uri "https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzureCAT-GSI%2FHana-Test-Deploy%2Fmaster%2Flinuxjumpbox/linuxjumpbox-infra.json" \
--parameters \
vmName="$LINUXJUMPBOXNAME" \
vmUserName=$vmusername  \
             ExistingNetworkResourceGroup=$rgname \
             vnetName=$vnetname \
             subnetName=$mgtsubnetname \
                   osType="SLES 12 SP3" \
             vmPassword=$vmpassword \
             customUri=$customuri \
                   StaticIP=$LINUXJUMPBOXIP
