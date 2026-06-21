FROM linuxserver/lidarr:latest

USER root
# Install rclone, bash, and ffmpeg for the automation scripts
RUN apk add --no-cache bash rclone ffmpeg curl

# Copy our automation scripts
COPY run.sh /run.sh
COPY auto-artwork.sh /scripts/auto-artwork.sh
RUN chmod +x /run.sh /scripts/auto-artwork.sh

ENTRYPOINT ["/run.sh"]
