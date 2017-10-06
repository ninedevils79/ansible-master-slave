#!/usr/bin/env bash

#Copyright 2016 Kumar Jadav
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


FILES=( cleanup.yml copy.yml file-status.yml getip.yml launch.yml ping.yml )

usage(){

cat << EOF
$0 <hostname>

Usage:
  <hostname> is the hostname for any server running Libvirt
EOF
}

if [[ -z $1 ]]; then
  usage
  exit 1
fi

echo -e "The hostname is: " $1
read -r -p "Do you want to continue? [y/n] " response
response=${response,}

if [[ $response =~ ^(yes|y) ]]; then
  for files in ${FILES[*]}; do
	sed -i "s,hosts.*,hosts: ${1}," $files
  done
else
  echo -e "You have decided not to continue"
  echo -e "Exiting."
  exit 1
fi
