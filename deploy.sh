# #!/usr/bin/env bash

# Break build on error, prevents websites going offline in case of pelican errors
set -e

echo "Starting Pelican build of $WEBSITE"
cd $WEBSITE

# Build pelican website
pelican content -s publishconf.py 


echo "after publishconf.py"

# Copy files for github
cp README.md output/README.md
cp .nojekyll output/.nojekyll

# Remove individual calendar events
# These pages are generated by Pelican but we want them displayed on the website
# as individual files. Only the calendar overview has to be shown.
if [[ -d output/calendar ]]; then
  (cd output/calendar && ls | grep -v index.html | xargs rm -rf)
fi

# Go back to root directory
cd ..
