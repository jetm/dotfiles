function debug --description "Debug a bash script with set -x"
    set -l script $argv[1]
    set -e argv[1]
    bash -x (command -v $script) $argv
end
