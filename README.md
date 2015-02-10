# knife-ruby
Docker container to run knife winrm and ssh commands

docker run --env cmd="winrm" --env search="os:windows" --env user="WINRRM-USER" --env winrm_cmd="hostname" --env password="WINRM-PASSWORD" -v ~/chef:/etc/chef jcastillo/knife-ruby:v3

docker run --env cmd="ssh" --env search="os:linux" --env user="SSH-USER" --env ssh_cmd="hostname" --env pem="ssh-file.pem" -v ~/chef:/etc/chef jcastillo/knife-ruby:v3


Where your chef files (knife.rb, pem, etc...) are located ~/chef, -v is used to mount that folder to the necessary folder in the docker container.

Supported cmd are "winrm" or "ssh"

winrm_cmd is the command to run on windows
ssh_cmd is the command to run on linux

