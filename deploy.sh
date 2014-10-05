#!/bin/bash

public_dir="build" # compiled site directory
ssh_user="ktohg@tritarget.org"
ssh_port="22"
document_root="~/tritarget.org/"
delete="--delete"
exclude="--exclude-from ./rsync-exclude"

deploy_build() {
  pushd $1
  npm install
  npm run-script bower
  npm run-script clean
  npm run-script build
  popd
}

deploy_build devin-contact-app
deploy_build ./

rsync -avze "ssh -p ${ssh_port} ${exclude} ${delete} ${public_dir}/ ${ssh_user}:${document_root}"
