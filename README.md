# knife-ruby
Docker container to run knife all types of CHEF commands.  This docker container was built for two purporses.  

1) Don't need to worry about development environment having the necessary ruby gems, pem files, aws credentials, etc... 

2) Can wire into things like teamcity / jenkins where your build agents can execute docker runs (currently all my team's chef orchestration is fronted by Teamcity through these docker images)

docker run --env cmd="winrm" --env search="os:windows" --env user="WINRRM-USER" --env winrm_cmd="hostname" --env password="WINRM-PASSWORD" -v ~/chef:/etc/chef jcastillo/knife-ruby:v3

docker run --env cmd="ssh" --env search="os:linux" --env user="SSH-USER" --env ssh_cmd="hostname" --env pem="ssh-file.pem" -v ~/chef:/etc/chef jcastillo/knife-ruby:v3


Where your chef files (knife.rb, pem, etc...) are located ~/chef, -v is used to mount that folder to the necessary folder in the docker container.

Supported cmd are "winrm", "ssh", "exec", "ec2", "bootstrap"

winrm_cmd is the command to run on windows

ssh_cmd is the command to run on linux

exec is the command to run knife commands (example: add a role to a node)

ec2 is the command to create a server in aws

bootstrap is the command to attach a windows machine to chef (ec2 windows usually times out and you need to run bootstrap after ec2 command)


