# ------------------------
# Aliases
# ------------------------

# Connect/Disconnect my BT headphone.
alias btc='blueutil --connect e4-41-22-8c-57-fc'
alias btd='blueutil --disconnect e4-41-22-8c-57-fc'

# standard enhancements
# ------------------------
alias ping='ping -c 5'
alias grep="grep --color"
alias grepp="grep -P --color"
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias .....="cd ../../../../.."
alias ls='ls -al'
alias mountall="sudo automount -cv"

# And some non-standard
# ------------------------
alias hgrep="history|grep "
alias sdev2="ssh --redacted--@$DEVIP2"
alias sdev="ssh --redacted--@$DEVIP"
# source the conf.
alias sbp="source /Users/--redacted--/.zshrc"

# git related
# ------------------
alias gs="git status"
alias gsn="git status -uno"
alias gl="git log"
alias gdt="git difftool"
alias gcm="git checkout master"
alias gb="git branch"


# Run a temp http server to serve files.
alias www2='python -m SimpleHTTPServer 8000'
alias www3='python3 -m http.server 8000'

# ------------------------
# Functions
# ------------------------

# create directory, cd into it.
mkcd()
{
 mkdir -p $1 && cd $1
}

# Make a tar archive with given folder.
function mktar()
{
  echo "Inside mktar()"
  tar cf "${1}.tar" ${1}
}

# Makeshift filecopy, use DBC (a VM) as a temp location,
# to copy files between systems.
# If it is a folder, tar it to make the copy faster.
function scpc()
{
  tarfile=`echo ${@%/}`
  if [ -d "$1" ]; then
    echo 'Directory, creating tarball...'
    mktar $tarfile
    tarfile_name=`basename $tarfile`
    tarfile_name="${tarfile}.tar"
    echo "TAR file: ${tarfile_name}"
  fi
  scp  $tarfile_name --redacted--@$DBC:$DBCHOME
}

function scpp() {
  scp --redacted--@$DBC:$DBCHOME/$1 ./
  ssh --redacted--@$DBC "rm -f $DBCHOME/$1"
}

function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""z
    echo "WAN IP: $extIp"

}

# Laziness max.
function sshv() {
  echo "SSH ing: ${1}"
  ssh "root@${1}"
}

# Describe a certificate file in readable format.
function descc () {
  openssl x509 -in $1 -text -noout
}

# Activate Python3 virtual env. automatically if exists
# on cd to the directory containing the .venv folder.
# de-activate on subsequent cd
function cd() {
  builtin cd $1
  
  if [[ -d ./venv ]] ; then
    source ./venv/bin/activate
    export DEACTIVATE_ON_CD="set"
  elif [[ $DEACTIVATE_ON_CD ]] ; then
    deactivate
    unset DEACTIVATE_ON_CD
  fi
}

# Get latest REST Doc link
function rest() {
  export CURL_OUTPUT=`curl -X GET "http://buildapi.--redacted--.com/ob/build/?product=--redacted--&branch=main&_order_by=-id&_limit=1"`
  export LATEST_BUILD_DELIVERABLE=`echo $CURL_OUTPUT | python -c "import sys, json; print (json.load(sys.stdin)['_list'][0]['_buildtree_url'])"`
  export LATEST_DOC_LINK="${LATEST_BUILD_DELIVERABLE}publish/public/apidocs/restdoc/"
  echo $LATEST_DOC_LINK
}

# Copy logs from a given VC.
function copylogs {
  if [ -z "$vc" ]; then
    if [ -z "$1" ]; then
        echo "Both the variables: \$vc and \$1 are empty"
        return -1
    fi
    export vc=$1
  fi
  folder=$2
  if [ -z "$folder" ]; then
    folder='--redacted--'
  fi
  mkdir -p ~/Desktop/--redacted--/$vc/$folder
  scp -r root@$vc:/var/log/--redacted--/$folder ~/Desktop/--redacted--/$vc/
}

# Load asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash