#!/bin/bash

# Ensure config and our target music directory exist
mkdir -p ~/.config/rclone/
mkdir -p /config/music

# Write out our S3 connection profile
cat <<EOF > ~/.config/rclone/rclone.conf
[supabase]
type = s3
provider = Other
access_key_id = ${SUPABASE_PROJECT_ID}
secret_access_key = ${SUPABASE_SECRET_KEY}
endpoint = https://${SUPABASE_PROJECT_ID}.supabase.co/storage/v1/s3
region = us-east-1
EOF

# Mount the Supabase bucket directly into our writable config folder
echo "--> Mounting Supabase cloud storage to local directory..."
rclone mount supabase:music /config/music --vfs-cache-mode full --allow-other &

# Give it a few seconds to initialize the cloud handshake
sleep 5

echo "--> Launching Lidarr automation suite..."
# Run the original container entrypoint to start Lidarr
exec /init
