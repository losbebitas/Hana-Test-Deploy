#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi


echo "additional application server software install started"
az group deployment create \
--name NetWeaver-Deployment \
--resource-group "$rgname" \
   --template-uri "https://raw.githubusercontent.com/AzureCAT-GSI/Hana-Test-Deploy/master/sap-netweaver-server/azuredeploy-nw-sw.json" \
   --parameters \
   vmName="$AASVMNAME" \
   vmUserName="$vmusername" \
   vmPassword="$vmpassword" \
   vnetName="$vnetname" \
   ExistingNetworkResourceGroup="$rgname" \
   vmSize="Standard_DS2_v2" \
   osType="SLES 12 SP3" \
   appAvailSetName="nwavailset" \
   StaticIP="$AASIPADDR"

echo "additional application server software install completed"
