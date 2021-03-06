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

if [ "${cmd}" = "winrm" ]; then

  if [ -z "${search}" ]; then
      echo "ERROR: The knife search is not set."
      exit 1
  fi

  if [ -z "${winrm_cmd}" ]; then
      echo "ERROR: The knife winrm cmd is not set."
      exit 1
  fi

  if [ -z "${user}" ]; then
      echo "ERROR: User not set."
      exit 1
  fi

  if [ -z "${password}" ]; then
      echo "ERROR: Password not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  knife winrm "${search}" "${winrm_cmd}" -x ${user} -P "${password}" -a 'ipaddress'

fi


if [ "${cmd}" = "exec" ]; then

  if [ -z "${exec_cmd}" ]; then
      echo "ERROR: The knife exec cmd is not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  knife exec -E "${exec_cmd}"

fi

if [ "${cmd}" = "ec2" ]; then

  if [ -z "${image}" ]; then
      echo "ERROR: The ami image not set"
      exit 1
  fi

  if [ -z "${security_group}" ]; then
      echo "ERROR: The security group is not set."
      exit 1
  fi

  if [ -z "${node_name}" ]; then
      echo "ERROR: The node name is not set."
      exit 1
  fi

  if [ -z "${user}" ]; then
      echo "ERROR: User type not set."
      exit 1
  fi

  if [ -z "${environment}" ]; then
      echo "ERROR: Chef environment is not set."
      exit 1
  fi

  if [ -z "${subnet}" ]; then
      echo "ERROR: Subnet is not set."
      exit 1
  fi

  #linux needs pem file, windows needs password
  if [ -z "${pem}" ]; then
    if [ -z "${password}" ]; then
      echo "ERROR: Either PEM or Password not set."
      exit 1
    fi
  fi

  if [ -z "${aws_tags}" ]; then
      echo "ERROR: Tags not set."
      exit 1
  fi

  if [ -z "${chef_secret_file}" ]; then
      echo "ERROR: Chef secret file not set."
      exit 1
  fi

  if [ -z "${instance_size}" ]; then
      echo "ERROR: Instance size not set."
      exit 1
  fi

  if [ -z "${region}" ]; then
      echo "ERROR: Region not set."
      exit 1
  fi

  if [ -z "${zone}" ]; then
      echo "ERROR: Availability zone not set."
      exit 1
  fi

  if [ -z "${access_key}" ]; then
      echo "ERROR: AWS access key not set."
      exit 1
  fi

  if [ -z "${secret_key}" ]; then
      echo "ERROR: AWS secret key not set."
      exit 1
  fi

  if [ -z "${chef_version}" ]; then
      echo "ERROR: Chef version not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  if [ -z "${pem}" ]; then

    knife ec2 server create \
    --image "${image}" \
    -g ${security_group} \
    --node-name "${node_name}" \
    --environment "${environment}" \
    -s ${subnet} \
    --secret-file /etc/chef/${chef_secret_file} \
    -f ${instance_size} \
    --region ${region} \
    -Z ${zone} \
    --aws-access-key-id ${access_key} \
    --ssh-key ${secret_key} \
    --bootstrap-version ${chef_version} \
    -x "${user}" \
    -P "${password}" \
    -T "${aws_tags}"

  fi

  if [ -z "${password}" ]; then

    knife ec2 server create \
    --image "${image}" \
    -g ${security_group} \
    --node-name "${node_name}" \
    --environment "${environment}" \
    -s ${subnet} \
    --secret-file /etc/chef/${chef_secret_file} \
    -f ${instance_size} \
    --region ${region} \
    -Z ${zone} \
    --aws-access-key-id ${access_key} \
    --ssh-key ${secret_key} \
    --bootstrap-version ${chef_version} \
    -x "${user}" \
    -i /etc/chef/${pem} \
    -T "${aws_tags}"

  fi

fi


if [ "${cmd}" = "bootstrap" ]; then

  if [ -z "${ipaddress}" ]; then
      echo "ERROR: The ip address is not set."
      exit 1
  fi

  if [ -z "${node_name}" ]; then
      echo "ERROR: The node name is not set."
      exit 1
  fi

  if [ -z "${user}" ]; then
      echo "ERROR: User type not set."
      exit 1
  fi

  if [ -z "${environment}" ]; then
      echo "ERROR: Chef environment is not set."
      exit 1
  fi

  if [ -z "${password}" ]; then
    echo "ERROR: Either PEM or Password not set."
    exit 1
  fi

  if [ -z "${chef_secret_file}" ]; then
      echo "ERROR: Chef secret file not set."
      exit 1
  fi

  if [ -z "${chef_version}" ]; then
      echo "ERROR: Chef version not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  knife bootstrap windows winrm ${ipaddress} \
  -N "${node_name}" \
  --winrm-user "${user}" \
  --winrm-password "${password}" \
  --environment "${environment}" \
  --secret-file /etc/chef/${chef_secret_file} \
  --bootstrap-version ${chef_version}

fi


if [ "${cmd}" = "run_list" ]; then

  if [ -z "${node_name}" ]; then
      echo "ERROR: The node name is not set."
      exit 1
  fi

  if [ -z "${run_list}" ]; then
      echo "ERROR: run_list not set."
      exit 1
  fi

  echo "All parameters have been provided..."

  knife node run_list set ${node_name} "${run_list}"

fi


#
# Finished operations
#
echo "Finished knife operations"
