#!/bin/bash
REPO01_SVN_USERNAME='<USERNAME01>'
REPO01_SVN_PASSWORD='<PASSWORD01>'

REPO02_SVN_USERNAME='<USERNAME02>'
REPO02_SVN_PASSWORD='<PASSWORD02>'

WORK_DIR=/opt
DATE=`date "+%Y%m%d-%H%M"`

echo -e "\n#######################${DATE} Starting Repo02 & Repo01 SVN Sync.#######################\n"

ARG="$#"
if [[ $ARG -eq 0 ]]; then
  echo -e "Provide a branch name. Usage: ./<script> branch"
  exit
fi

SVN_BRANCH=$1

cd ${WORK_DIR}
svn co --non-interactive --no-auth-cache --username ${REPO01_SVN_USERNAME} --password ${REPO01_SVN_PASSWORD} https://<SVN_REPO_URL01>/svn/<REPONAME>/branches/${SVN_BRANCH} repo01_${SVN_BRANCH}
svn co --non-interactive --no-auth-cache --username ${REPO02_SVN_USERNAME} --password ${REPO02_SVN_PASSWORD} http://<SVN_REPO_URL02>/svn/<REPONAME>/branches/${SVN_BRANCH}

rsync -avz --exclude "Jenkinsfile" --exclude ".../<some_other_file>" --exclude "../<filename>" --exclude ".svn" repo01_${SVN_BRANCH}/ ${SVN_BRANCH}/
cd ${WORK_DIR}/${SVN_BRANCH}
svn add * --force
svn status
svn commit -m "${DATE} synced with repo01 svn" --non-interactive --no-auth-cache --username ${REPO02_SVN_USERNAME} --password ${REPO02_SVN_PASSWORD}

echo -e "Removing local Directories."

rm -rf ${WORK_DIR}/repo01_${SVN_BRANCH} ${WORK_DIR}/${SVN_BRANCH}

echo -e "\n\n##############################Sync Done.####################################\n\n"
