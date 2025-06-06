#!/usr/bin/env bash
set -e

# ensure cron can find git
export PATH=/usr/local/bin:/usr/bin:/bin

# config
REPO_URL="https://github.com/opencivicdata/scrapers-ca.git"
BRANCH="main"
BASE="/home/ec2-user/scrapers_ca_app"
LAST_FILE="$BASE/.last_commit"
LOG_FILE="$BASE/poll-deploy.log"

# get the latest remote commit SHA
REMOTE_SHA=$(git ls-remote "$REPO_URL" "$BRANCH" | awk '{print $1}')

# read what we saw last time (empty string if first run)
LAST_SHA=$(cat "$LAST_FILE" 2>/dev/null || echo "")

# timestamp helper
now() { date '+%Y-%m-%d %H:%M:%S'; }

if [ "$REMOTE_SHA" != "$LAST_SHA" ]; then
  echo "$(now) ▶ New commit detected: $REMOTE_SHA" >> "$LOG_FILE"
  echo "$REMOTE_SHA" > "$LAST_FILE"
  # call your deploy
  "$BASE/docker/deploy.sh" >> "$LOG_FILE" 2>&1
else
  echo "$(now) — No changes detected" >> "$LOG_FILE"
fi

