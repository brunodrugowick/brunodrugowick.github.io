#!/bin/bash

# Checks for modifications under the ./_posts folder.
if git status | grep -q "_posts"; then
  git config --global user.name 'Bruno Drugowick'
  git config --global user.email 'brunodrugowick@users.noreply.github.com'
  echo "New posts found, let's commit them and push."
  date >last_updated_date
  git add .
  git commit -am "Update articles list"
  git push
else
  echo "No changes detected, nothing will be done."
fi

