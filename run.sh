#!/bin/bash

# Ensure config directories exist
mkdir -p ~/.config/rclone/

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

# Use WebDAV server proxy instead of mount to bypass user permissions completely
echo "--> Starting internal WebDAV server for Lidarr..."
rclone serve webdav supabase:music --addr 127.0.0.1:8081 --vfs-cache-mode full &

# Give it a few seconds to initialize
sleep 5

echo "--> Launching Lidarr automation suite..."
# Run the original container entrypoint to start Lidarr
exec /init
