function extract_srt --description "Extract subtitle track from MKV"
    set -l srt_id (math $argv[2] - 1)
    mkvextract tracks $argv[1] $srt_id:(string replace -r '\.mkv$' '.srt' (basename $argv[1]))
end
