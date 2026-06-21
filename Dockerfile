FROM linuxserver/lidarr:latest

# Expose Lidarr's standard operating port
EXPOSE 8686

# Volumes will be handled via Render's mount points or ephemeral syncs
