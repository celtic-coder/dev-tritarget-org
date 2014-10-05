#!/bin/bash

public_dir="build" # compiled site directory
ssh_user="ktohg@tritarget.org"
ssh_port="22"
document_root="~/tritarget.org/"
delete="--delete"
exclude="--exclude-from ./rsync-exclude"

pushd devin-contact-app
npm install || exit 1
npm run bower || exit 1
npm run build || exit 1
popd

npm install || exit 1
npm run bower || exit 1
npm run build || exit 1

rsync -avze "ssh -p ${ssh_port} ${exclude} ${delete} ${public_dir}/ ${ssh_user}:${document_root}"
