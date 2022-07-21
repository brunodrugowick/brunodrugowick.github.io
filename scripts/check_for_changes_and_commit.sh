#!/bin/bash

git config --global user.name 'Bruno Drugowick'
git config --global user.email 'brunodrugowick@users.noreply.github.com'

if git diff-index --quiet HEAD; then
	echo "No changes detected, nothing will be done."
	exit 0
else
	echo "New posts found, let's commit them and push."
	git add .
	git commit -am "Update articles list"
	git push
fi

