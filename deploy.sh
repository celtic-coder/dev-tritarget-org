#!/bin/bash

public_dir="build" # compiled site directory
ssh_user="ktohg@tritarget.org"
ssh_port="22"
document_root="~/tritarget.org/"
delete="--delete"
exclude="--exclude-from ./rsync-exclude"

deploy_build() {
  pushd $1
  npm install          || exit 1
  npm run-script bower || exit 1
  npm run-script clean || exit 1
  npm run-script build || exit 1
  popd
}

deploy_build devin-contact-app
deploy_build ./

echo rsync -avz -e "ssh -p ${ssh_port}" ${exclude} ${delete} ${public_dir}/ ${ssh_user}:${document_root}
