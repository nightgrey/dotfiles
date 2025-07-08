function discord -d "Converts a video to discord-compatible mp4"
    set input $argv[1]
    ffmpeg -i $input -c:v libx264 -c:a aac -movflags +faststart $input.mp4
end
