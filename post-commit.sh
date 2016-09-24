# !/bin/bash
#
# Copyright Jacob Young - 2016
# License MIT

set -o nounset
set -o errexit

# Data store directory
DATA_STORE_DIR=".commit-geolocate"

result=$( curl -s -X GET "http://ip-api.com/json" )

if [ $? -eq 1 ]; then
  echo "Commit Geolocate: FAILED - Geolocation failed. Could not save geolocation. Either ip-api.com/json is down, or your internet connection is faulty."
  exit 0
fi

# Record the timestamp of the git commit
timestamp=$( date +"%s" )

# Repostory name:
# ref: http://stackoverflow.com/questions/15715825/how-do-you-get-git-repos-name-in-some-git-repository
#   The git rev-parse --show-toplevel part gives you the path to that directory
#   and the basename strips the first part of the path.
repo_path=$( git rev-parse --show-toplevel )
repo_base=$( basename $repo_path )

cd $repo_path

# Commit sha
commit_sha=$( git rev-parse --verify HEAD )

# Commit message
commit_msg=$( git show -s --format=%s $commit_sha )

# Parse the result for latitude and longitude
lat=$( echo "$result" | awk -v RS=',"' -F: '/lat/ {print $2}' )
lon=$( echo "$result" | awk -v RS=',"' -F: '/lat/ {print $2}' )

# Save data
cd ~
mkdir -p $DATA_STORE_DIR
cd $DATA_STORE_DIR

# Check if the CSV data store exists
if [ ! -f $DATA_STORE_DIR/locations.csv ]; then
  echo "Commit Geolocate: Could not file file locations.csv. Making a new file"
  echo "time, repo, sha, msg, lat, lon" >> locations.csv
fi

# Write to CSV
echo "$timestamp, $repo_base, $commit_sha, $commit_msg, $lat, $lon" >> locations.csv
echo "Commit Geolocate: Location recorded!"

