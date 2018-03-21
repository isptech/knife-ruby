FROM ruby

# This is initially based off 
# https://github.com/JC1738/knife-ruby

RUN apt-get update; apt-get -y install wget vim 

RUN gem install chef

RUN gem install knife-windows

RUN gem install knife-ec2


ADD files/main.sh /main.sh

# Main entrypoint script
RUN chmod 755 main.sh

# Folder for secure files
RUN mkdir /etc/chef

RUN ln -s /etc/chef ~/.chef

RUN ln -s /etc/chef /.chef

ENV EDITOR vim


WORKDIR /etc/chef
CMD ["/main.sh"]
