#!/bin/sh

SCRIPT_DIR="$(cd $(dirname ${0}) && pwd)"
ROOT_DIR="$(cd ${SCRIPT_DIR}/.. && pwd)"
SCRIPT_NAME=`basename $0`
DISABLE_FILE="$ROOT_DIR/disable"
DIR_NAME=$(basename $SCRIPT_DIR)
DATE=$(date +'%d/%m/%Y - %H:%M:%S')

log(){
	TAG=${2:-"INFO"}
	echo "$TAG: ts=\"$(date +'%d/%m/%Y - %H:%M:%S')\" pid=\"$$\" root=\"$DIR_NAME\" id=\"$SCRIPT_NAME\" msg=\"$1\""
}

check_env(){
	if [ "$ENV" != "p" ] && [ "$ENV" != "l" ]; then
		log "Environment undefined!"
		exit 1
	fi
}

# verify if the script who's call
# match with the disable list inside
# the "disable.txt" file
is_disable(){
	while IFS= read LINE
	do
		if [ "$LINE" = "$SCRIPT_NAME" ]; then
			log "Script disabled, skipping..."
			exit 0
		fi
	done < $DISABLE_FILE
}

__msg_error(){
  printf "\033[31mERROR:\033[m %s\n" "$*"
}

__msg_info(){
  printf "\n\033[96mINFO:%s\033[m\n" "$*"
}

__msg_warn(){
  printf "\033[93m::: %s\033[m\n" "$*"
}

__msg_final(){
  printf "\033[97m>>> %s <<<\033[m\n" "$*"
  exit 1
}
