#!/bin/bash

if git diff-index --quiet HEAD; then
  echo "No changes detected, nothing will be done."
else
  git config --global user.name 'Bruno Drugowick'
  git config --global user.email 'brunodrugowick@users.noreply.github.com'
  echo "New posts found, let's commit them and push."
  date >last_updated_date
  git add .
  git commit -am "Update articles list"
  git push
fi

