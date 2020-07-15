#!/bin/sh


info() {
    echo ----------------------------------------------------------------------------------------------
    echo
    echo How to use:
    echo
    echo configtools.sh credentialfile projectid clusterid regionid zoneid
    echo
    echo Where:
    echo
    echo "* credentialfile: Is the GCE service acount's credential JSON file."
    echo "* projectid: Is the GCE proyect where you are working"
    echo "* clusterid: Is the GKE cluster ID"
    echo "* regionid: The default region where your cluster is. Example: europe-west1"
    echo "* zoneid: The default zone where your cluster is. Example: europe-west1-b"
    echo
    echo ----------------------------------------------------------------------------------------------
    echo
}

if ([ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] || [ "$4" == "" ]) then
    info
    exit;
fi;

credentialfile=$1
projectid=$2
clusterid=$3
regionid=$4
zoneid=$5

gcloud auth activate-service-account --key-file=/$credentialfile
gcloud config set project $projectid
gcloud config set container/cluster $clusterid
gcloud config set compute/region $regionid
gcloud config set compute/zone $zoneid

gcloud container clusters get-credentials $clusterid
gcloud auth configure-docker --quiet