#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

pacs()
{
  local CL='\\e['
  local RS='\\e[0;0m'

  echo -e "$(pacman -Ss "$@" | sed "
    /^core/     s,.*,${CL}1;31m&${RS},
    /^extra/    s,.*,${CL}0;32m&${RS},
    /^community/    s,.*,${CL}1;35m&${RS},
    /^[^[:space:]]/ s,.*,${CL}0;36m&${RS},
  ")"
}

# Move dir Orig to Dest
mvdir()
{
  ( tar -c $1 ) | ( cd $2 && tar -x -p ) \
    && rm -rf $1
}

# Repeat n times command
repeat_cmd()
{
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
  done
}

# See 'killps' for example of use.
ask()
{
  echo -n "$@" '[y/n] ' ; read ans
  case "$ans" in
    y*|Y*)
      return 0 ;;
    *)
      return 1 ;;
  esac
}

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

# Show my process
my_ps()
{
  ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ;
}

# Id of my process
pp()
{
  my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ;
}

# Kill by process name
killps()
{
  local pid pname sig="-TERM"   # Default signal.
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: killps [-SIGNAL] pattern"
    return;
  fi

  if [ $# = 2 ]; then
    sig=$1;
  fi

  for pid in $(my_ps| awk '!/awk/ && $0~pat { print ( }' pat=${!#} ); do
    pname=$(my_ps | awk '(~var { print $5 }' var=$pid )
    if ask "Kill process $pid <$pname> with signal $sig?"
    then kill $sig $pid
    fi
  done
}

#-------------------------------------------------------------
# File & string-related functions:
#-------------------------------------------------------------

# Find a file with a pattern in name
ff()
{
  find . -type f -iname '*'$*'*' -ls ;
}

# Find a file with pattern ( in name and Execute [ on it)
fe()
{
  find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ;
}

# Find a pattern in a set of files and highlight them
# (needs a recent version of egrep)
fstr()
{
  OPTIND=1
  local case=""
  local usage="fstr: find string in files.
  Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "

  while getopts :it opt
  do
    case "$opt" in
      i)
        case="-i " ;;
      *)
        echo "$usage"; return;;
    esac
  done

  shift $(( $OPTIND - 1 ))

  if [ "$#" -lt 1 ]; then
    echo "$usage"
    return;
  fi

  find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "(" 2>&- | more

}

# cut last n lines in file, 10 by default
cuttail()
{
  nlines=${2:-10}
  sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

# move filenames to lowercase
lowercase()
{
  for file ; do
    filename=${file##*/}
    case "$filename" in
      */*)
        dirname==${file%/*} ;;
      *)
        dirname=.;;
    esac

    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [ "$nf" != "$filename" ]; then
      mv "$file" "$newname"
      echo "lowercase: $file --> $newname"
    else
      echo "lowercase: $file not changed."
    fi
  done
}

# Create a new directory and enter it
md()
{
  mkdir -p "$@" && cd "$@"
}
