#!/bin/sh

oc delete all --all -n ci
oc delete all --all -n stage
oc delete project ci
oc delete project stage
