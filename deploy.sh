#!/bin/bash

cd $(dirname $0)

export CI=true

public_dir="build" # compiled site directory
ssh_user="ktohg@tritarget.org"
ssh_port="22"
document_root="~/tritarget.org/"
delete="--delete"
exclude="--exclude-from ./rsync-exclude"
notify_url="http://localhost:8888/"

branch=master
deploy=no
notify=no

while test $# -gt 0; do
  case $1 in
    -h | --help)
      echo "Usage: deploy.sh [-hnr] [-b BRANCH]"
      echo "  -h, --help    This cruft"
      echo "  -n, --notify  send notification via curl"
      echo "  -r, --rsync   rsync build to server"
      echo "  -b, --branch  build against BRANCH or SHA"
      exit 0
      ;;
    -d | --deploy)
      deploy=yes
      ;;
    -n | --notify)
      notify=yes
      ;;
    -b | --branch)
      branch=$2
      shift
      ;;
    -*)
      split=$1
      shift
      set -- $(echo "$split" | cut -c 2- | sed 's/./-& /g') "$@"
      continue
      ;;
    *)
      echo "deploy.sh: illegal option -- $1"
      set -- -h
      continue
      ;;
  esac
  shift
done

die() {
  if [[ $notify == yes ]]; then
    curl -X POST -d "success=false" $notify_url
  fi
  exit 1
}

deploy_build() {
  pushd $1
  npm install          || die
  npm run-script bower || die
  npm run-script clean || die
  npm run-script build || die
  popd
}

rsync_build() {
  rsync -avz -e "ssh -p ${ssh_port}" ${exclude} ${delete} ${public_dir}/ ${ssh_user}:${document_root} || die
}

git checkout -f $branch || die
git pull origin $branch || die

git submodule init   || die
git submodule update || die

deploy_build devin-contact-app
deploy_build ./

if [[ $deploy == yes ]]; then
  rsync_build
fi

if [[ $notify == yes ]]; then
  curl -X POST -d "success=true" $notify_url
fi

echo "Build done"
exit 0
