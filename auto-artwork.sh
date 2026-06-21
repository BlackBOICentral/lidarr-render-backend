#!/bin/bash
TARGET_DIR="${Lidarr_Artist_Path}"
if [ -z "$TARGET_DIR" ]; then exit 0; fi
find "$TARGET_DIR" -type d | while read -r ALBUM_FOLDER; do
    if [ ! -f "${ALBUM_FOLDER}/animated-artwork.mp4" ]; then
        SRC_VIDEO=$(find "$ALBUM_FOLDER" -type f \( -name "*.mp4" -o -name "*.mkv" -o -name "*.mov" \) ! -name "animated-artwork.mp4" | head -n 1)
        if [ ! -z "$SRC_VIDEO" ]; then
            ffmpeg -i "$SRC_VIDEO" -vf "crop=ih*3/4:ih" -an -y "${ALBUM_FOLDER}/animated-artwork.mp4"
        else
            SRC_IMG=$(find "$ALBUM_FOLDER" -type f \( -name "folder.jpg" -o -name "cover.jpg" -o -name "*.png" \) | head -n 1)
            if [ ! -z "$SRC_IMG" ]; then
                ffmpeg -loop 1 -i "$SRC_IMG" -t 5 -vf "scale=720:960:force_original_aspect_ratio=decrease,pad=720:960:(ow-iw)/2:(oh-ih)/2,format=yuv420p" -an -y "${ALBUM_FOLDER}/animated-artwork.mp4"
            fi
        fi
    fi
done
exit 0
