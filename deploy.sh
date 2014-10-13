#!/usr/bin/env bash

cd $(dirname $0)

export CI=true

public_dir="build" # compiled site directory
ssh_user="ktohg@tritarget.org"
ssh_port="22"
document_root="~/tritarget.org/"
delete="--delete"
exclude="--exclude-from ./rsync-exclude"
notify_url="http://river-song.herokuapp.com/deploy/dev-tritarget-org"

branch=master
daemonize=no
deploy=no
notify=no

while test $# -gt 0; do
  case $1 in
    -h | --help)
      echo "Usage: deploy.sh [-dhnr] [-b BRANCH]"
      echo "  -d, --detach  daemonize"
      echo "  -h, --help    this cruft"
      echo "  -n, --notify  send notification via curl"
      echo "  -r, --rsync   rsync build to server"
      echo "  -b, --branch  build against BRANCH or SHA"
      exit 0
      ;;
    -d | --detach)
      daemonize=yes
      ;;
    -r | --rsync)
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
    curl "${notify_url}?success=false"
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

run_build() {
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
    curl "${notify_url}?success=true"
  fi

  echo "Build done"
  exit 0
}

if [[ $daemonize == yes ]]; then
  run_build </dev/null >./deploy.log 2>&1 &
  disown
else
  run_build
fi
