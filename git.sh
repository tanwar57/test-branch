#!/bin/bash

# current Git branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

versionLabel=v$1
releaseBranch=release-$versionLabel

git checkout -b $releaseBranch $devBranch

versionFile="version.txt"

sed -i.backup -E "s/\= v[0-9.]+/\= $versionLabel/" $versionFile $versionFile

rm $versionFile.backup

git commit -am "Incrementing version number to $versionLabel"

git checkout $masterBranch
git merge --no-ff $releaseBranch

git tag $versionLabel

git checkout $devBranch
git merge --no-ff $releaseBranch

git branch -d $releaseBranch
