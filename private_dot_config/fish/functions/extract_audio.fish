function extract_audio --description "Extract English audio stream from MKV"
    set -l input_file $argv[1]

    if test -z "$input_file"
        echo "Usage: extract_audio <mkv_file>"
        return 1
    end

    if not test -f "$input_file"
        echo "Error: File '$input_file' not found"
        return 1
    end

    # Get audio stream information
    set -l audio_info (mediainfo --Output="Audio;%StreamKindPos%:%Language/String3% " "$input_file")

    if test -z "$audio_info"
        echo "Error: No audio streams found in '$input_file'"
        return 1
    end

    # Find English stream position
    set -l eng_stream (echo "$audio_info" | grep -o '[0-9]*:eng' | cut -d: -f1)

    if test -z "$eng_stream"
        echo "Error: No English audio stream found in '$input_file'"
        echo "Available streams: $audio_info"
        return 1
    end

    # Convert to 0-based indexing for ffmpeg
    set -l ffmpeg_audio_index (math $eng_stream - 1)

    # Generate output filename
    set -l ext (string match -r '\.[^.]+$' "$input_file")
    set -l base (string replace -r '\.[^.]+$' '' "$input_file")
    set -l output_file "$base"_eng"$ext"

    echo "Extracting English audio stream (position $eng_stream) from '$input_file'..."

    # Extract with ffmpeg - copy video and specified audio stream
    if ffmpeg -i "$input_file" -map 0:v -map "0:a:$ffmpeg_audio_index" -c copy "$output_file"
        echo "Successfully created '$output_file' with English audio only"
    else
        echo "Error: Failed to create output file"
        return 1
    end
end
