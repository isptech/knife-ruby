#!/bin/sh -x

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#

if [ -z "${cmd}" ]; then
    echo "ERROR: Command type not set."
    exit 1
fi


echo "Starting Knife Cmd"


if [ "${cmd}" = "ssh" ]; then

  if [ -z "${search}" ]; then
      echo "ERROR: The knife search is not set."
      exit 1
  fi

  if [ -z "${ssh_cmd}" ]; then
      echo "ERROR: The knife ssh cmd is not set."
      exit 1
  fi

  if [ -z "${pem}" ]; then
      echo "ERROR: Pem type not set."
      exit 1
  fi

  if [ -z "${user}" ]; then
      echo "ERROR: User type not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  knife ssh "${search}" "${ssh_cmd}" -x ${user} -i /etc/chef/${pem} -a 'ipaddress'

fi





#
# Finished operations
#
echo "Finished knife operations"
