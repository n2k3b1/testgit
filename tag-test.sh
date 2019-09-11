#!/bin/bash

tag=$1
if [ -z "$tag" ]
then
    echo "Please enter tag version. Usage ./tag.sh <tag version>"
    exit
fi

BRANCH=master
echo "testgit........................................."

cd ~/tmp/test-git/testgit

git checkout $BRANCH
git pull origin $BRANCH
COMMIT=$(git branch -v | grep "* $BRANCH" | awk '{print $3}')
echo Tag version $tag with commit $COMMIT
if [ ${#COMMIT} -ne 7 ]
then
    echo Maybe commit $COMMIT was wrong. Please check manual!
    exit
fi

git tag -d $tag
git push origin :refs/tags/$tag
git tag $tag $COMMIT
git push origin --tags
echo Finish tag $tag and push to origin!
