#!/bin/bash
# Execute from parent directory

echo "Syncing local files to remote server..."
rsync -avzh --exclude '.git' --exclude '.gitignore' . osmt1:/opt/osmt-wrapper
