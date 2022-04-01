#!/bin/bash

DATA_FOLDER=./_data
POSTS_FOLDER=./_posts
POSTS_FILE=$DATA_FOLDER/devPosts.json
POST_HEADER=$(cat <<- 'EOF'
---
layout: post
title:  "{{TITLE}}"
date:   {{DATE}}
categories: {{CATEGORIES}}
---

EOF
)

echo -n "" >$POSTS_FILE # Clear the posts file
rm -r $POSTS_FOLDER/* || mkdir $POSTS_FOLDER
POSTS_JSON=$(curl -s https://dev.to/api/articles?username=brunodrugowick&per_page=1000) # GET posts from user
echo "$POSTS_JSON" | jq >>$POSTS_FILE # Create data file for posts

POST_IDS=$(cat "$POSTS_FILE" | jq -r '.[].id') # Extract post ids
for POST in $POST_IDS # Loop through posts
do
    ARTICLE_JSON=$(curl -s https://dev.to/api/articles/"$POST") # GET full article
    POST_NAME=$(echo $ARTICLE_JSON | jq -r '"\(.published_at | split("T")[0])-\(.slug).markdown"')
    POST_URL=$(echo $ARTICLE_JSON | jq -r '.url')
    # Using HTML instead of Markdown because posts from DEV can use tags like 'post' that I cannot use here :(
    POST_BODY_HTML=$(echo $ARTICLE_JSON | jq -r '.body_html')
    POST_FILENAME=$POSTS_FOLDER/$POST_NAME
    POST_TITLE=$(echo $ARTICLE_JSON | jq -r '.title')
    POST_DATE=$(echo $ARTICLE_JSON | jq -r '.published_timestamp')
    POST_CATEGORIES=$(echo $ARTICLE_JSON | jq -r '.tag_list')

    touch "$POST_FILENAME"
    (
        printf '%s' "$POST_HEADER";
        echo "";
        echo "";
	printf '%s' "> <div class="card"><div class="container"><h4><b><a href=\""$POST_URL"\">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href=\""$POST_URL"\">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>" >>"$POST_FILENAME";
        echo "";
	printf '%s' "$POST_BODY_HTML..."
    )>>"$POST_FILENAME"

    sed -i 's/{{TITLE}}/'"$POST_TITLE"'/1' "$POST_FILENAME"
    sed -i 's/{{DATE}}/'"$POST_DATE"'/1' "$POST_FILENAME"
    sed -i 's/{{CATEGORIES}}/'"$CATEGORIES"'/1' "$POST_FILENAME"

done

date >last_updated_date
