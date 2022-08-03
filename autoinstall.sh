nodejs_install() {
  echo "Installing NodeJS..."
  curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
  sudo apt-get install -y nodejs
  echo "NodeJS installed"
}

npm_install() {
  echo "Installing NPM..."
  sudo npm install -g pm2
  echo "NPM installed"
}

git_install() {
  echo "Installing Git..."
  sudo apt-get install -y git
  echo "Git installed"
}

ufw_install() {
  echo "Installing UFW..."
  sudo apt-get install -y ufw
  echo "UFW installed"
}

nginx_install() {
  echo "Installing NGINX..."
  sudo apt-get install -y nginx
  echo "NGINX installed"
}

certbot_install() {
  echo "Installing Certbot..."
  sudo apt-get install -y certbot
  echo "Certbot installed"
}

# check if user is root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# update and upgrade
echo "Updating and upgrading..."
sudo apt-get update && sudo apt-get upgrade -y
echo "Update and upgrade done"

# check if nodejs is installed
if [ -z "$(command -v node)" ]; then
   echo "Nodejs is not installed" 1>&2
    nodejs_install
   exit 1
fi

# check if npm is installed
if [ -z "$(command -v npm)" ]; then
   echo "Npm is not installed" 1>&2
   exit 1
fi

# check if git is installed
if [ -z "$(command -v git)" ]; then
   echo "Git is not installed" 1>&2
   exit 1
fi

# check if ufw is installed
if [ -z "$(command -v ufw)" ]; then
   echo "Ufw is not installed" 1>&2
   exit 1
fi

# check if nginx is installed
if [ -z "$(command -v nginx)" ]; then
   echo "Nginx is not installed" 1>&2
   exit 1
fi

# check if certbot is installed
if [ -z "$(command -v certbot)" ]; then
   echo "Certbot is not installed" 1>&2
   exit 1
fi
