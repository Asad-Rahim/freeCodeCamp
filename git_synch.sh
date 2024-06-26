#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SOURCE_REPO=freeCodeCamp
DST_REPO=FreeCodeCampCopy
SOURCE_REPO_DIR=/home/runner/work/freeCodeCamp/${SOURCE_REPO}
DST_REPO_DIR=/home/runner/work/freeCodeCamp/${DST_REPO}
TMP_REPO_DIR=/tmp/temp_repo

rm -rf "${TMP_REPO_DIR}" 

# Cloning source repo with depth 3 so that git-filter-repo doesn't take too long
# git clone "${SOURCE_REPO_DIR}" "${TMP_REPO_DIR}" --no-local --depth 3


cd "${SOURCE_REPO_DIR}"


echo "${SCRIPT_DIR}"
python3 "${SCRIPT_DIR}/git-filter-repo" --path README.md --path curriculum/ --path shared --path .github --force --source "${SOURCE_REPO_DIR}" --target "${DST_REPO_DIR}"
echo "done filtering"

cd "${DST_REPO_DIR}"
git pull

#Normally we'd have to run differnet commands but the source branch of SOURCE_REPO_DIR is the sample branch, not main(I messed up :P)
git checkout main #This branch get's the changes from git-filter-repo

git rebase sample -X theirs

git push --set-upstream origin main --force