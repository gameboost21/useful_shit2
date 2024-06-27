# This will be the beginning of a script to automatically install docker on a new Linux-System
#!/bin/bash

# Reading the current user for automation purposes
echo "Please enter the user with which you initially logged on"
read getusername
echo "Read Successfull"

# List of Packages
packagelist=(libffi-dev libssl-dev python3 python3-pip)

# Updating packages
sudo apt update -y
echo "Updates have been successfully downloaded"
sleep 5
sudo apt install -y "${packagelist}"
echo "All dependencies have been installed successfully"

# Checking if the Docker script exists and if no, downloads it
if [ ! -f /home/$getusername/get-docker.sh ]; then
    curl -fsSL https://get.docker.com -o /home/$getusername/get-docker.sh
fi
echo "Getting the get-docker.sh-File has been successfully processed"

# Adding the current User to the Docker group
sudo usermod -aG docker $getusername

# Unmasking the Docker service
sudo systemctl unmask docker

# Setting perimission for docker.sock
sudo chmod 666 /var/run/docker.sock

# Starting and enabling the docker service, so it gets started as soon as the machine gets started
sudo systemctl start docker
sudo systemctl enable docker