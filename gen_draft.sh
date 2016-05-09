#!/bin/bash

# This script generates a new jekyll draft, with unique UUID
# usage:  ./gen_draft.sh [output file name]

touch ./_drafts/$1.md
echo "---" >> ./_drafts/$1.md
echo "layout: post" >> ./_drafts/$1.md
echo "title:" >> ./_drafts/$1.md
echo "comments: true" >> ./_drafts/$1.md
echo "disqus_id: eb0a2795-cee3-4ee7-97b1-8dcf5436acc0" >> ./_drafts/$1.md
echo "tags:" >> ./_drafts/$1.md
echo "- blog" >> ./_drafts/$1.md
echo "---" >> ./_drafts/$1.md
echo "" >> ./_drafts/$1.md
