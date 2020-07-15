gcloud-suite
------------

A simple docker image for CI/CD to GCE/GKE.


Description
-----------

In this image we gather 3 basic tools (the 3 friends or "3 amigos") for CI/CD pipelines in gcloud:

* GCloud SDK
* Helm
* Docker client

This image, not only joins this 3 utils in one place but also has a script for setting up them working together.

Why do I need this image ?
--------------------------

There are other Docker images mixing helm, kubernetes, gcloud but has'nt docker client.
In CI/CD pipelines, you usually need to build docker images and publish them to GCE Docker registry, before the deployment in the cluster managed by a helm's chart.

Therefore, those other images are incomplete for this purpouse, and also haven't an easy builtin method for configuring GCE authentication.

Also we need this image to be as small as possible, so it's alpine based.


What do you need to start ?
---------------------------

1) A GCE / GKE Cluster.

2) A GCLOUD service acount' credential JSON file.

How to get it ? https://cloud.google.com/iam/docs/creating-managing-service-accounts

Important !!! Be aware the roles you assign it. Lower roles could disallow you to access resources, and high roles could do a lot of damage when doing wrong things.

3) A Docker server.


How to use it ?
---------------
1) Configure the docker client comunication with server.
   How to do it is not the purpose of this doc.
   There are several ways to do Docker in Docker (search in google "docker in docker" or "docker dind").
   Depending how you do it, you need to configure it in one way or another.

2) Copy the service acount json file to the container. For example: running in Jenkins Pipeline, you can use a Secret Credential File, and use it in groovy with (withCredentials(....) { })

3) Get a shell on the container and run "configtools.sh". See the parameters you need.
Example: configtools.sh /tmp/mycredentialfile.json myproject mycluster europe-west1 europe-west1-b


Now you can access to your GKE cluster with "kubectl" or "helm". You can also admin your GCE resources with "gcloud", and push Docker images to Google Registry.
