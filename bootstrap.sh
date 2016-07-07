#!/bin/sh

#oc new-project stage
oc new-project ci
#oc create serviceaccount jenkins -n ci
#oadm policy add-scc-to-user privileged system:serviceaccount:ci:jenkins
oc policy add-role-to-user edit system:serviceaccount:ci:default -n ci
#oc policy add-role-to-user edit system:serviceaccount:stage:default -n ci
#oc policy add-role-to-user edit system:serviceaccount:ci:default -n stage
oc create -n ci -f examples/master/jenkins-master-template.json
oc create -n ci -f examples/slave/jenkins-slave-template.json
#oc new-app -n ci -f sample-app/sample-app-template.json
#oc new-app -n stage -f sample-app/sample-app-stage.json
