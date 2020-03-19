#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset

# set -o xtrace
# Set magic variables for current file & dir

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" 

__jenkins_dir="/lib/jenkins/" # this is where jenkins lives

echo 'Script started at' $(date +"%D at %r") '\n'

echo 'Stopping Jenkins...\n'
service jenkins stop

echo 'Deleting old backed up jenkins file...\n'
rm -f ${__jenkins_dir}jenkins.war.old

echo 'Backing up current Jenkins file...\n'
mv ${__jenkins_dir}jenkins.war ${__jenkins_dir}jenkins.war.old

echo 'Deleting current Jenkins file...\n'
rm -rf ${__jenkins_dir}jenkins.war

echo 'Getting latest Jenkins file from http://mirrors.jenkins-ci.org/war/latest/jenkins.war...\n'
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war -P ${__jenkins_dir}

echo 'Starting Jenkins...\n'
service jenkins start


echo 'Script ended at' $(date +"%D at %r") '\n'
