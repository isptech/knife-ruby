FROM phusion/passenger-ruby21

# Update Ubuntu and install common packages
RUN apt-get update -y

RUN apt-get install wget -y

RUN gem install chef

RUN gem install knife-windows

RUN gem install knife-ec2

ADD files/main.sh /main.sh

# Main entrypoint script
RUN chmod 777 main.sh

# Folder for secure files
RUN mkdir /etc/chef

RUN ln -s /etc/chef ~/.chef

RUN ln -s /etc/chef /.chef

WORKDIR /
CMD ["/main.sh"]
