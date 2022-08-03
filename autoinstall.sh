java_install() {
    sudo apt-get install -y openjdk-8-jdk
    sudo update-java-alternatives -s java-1.8.0-openjdk-amd64
    sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
    sudo update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
    sudo update-alternatives --set javaws /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/javaws
}

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

pm2_install() {
  echo "Installing PM2..."
  sudo npm install -g pm2
  echo "PM2 installed"
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

# check if java is installed
if [ -z "$(dpkg -l | grep openjdk-8-jre-headless)" ]; then
  echo "Java is not installed"
  java_install
fi

# check if nodejs is installed
if [ -z "$(command -v node)" ]; then
   echo "Nodejs is not installed" 1>&2
   nodejs_install
fi

# check if npm is installed
if [ -z "$(command -v npm)" ]; then
   echo "Npm is not installed" 1>&2
    npm_install
fi

# check if pm2 is installed
if [ -z "$(command -v pm2)" ]; then
   echo "PM2 is not installed" 1>&2
   pm2_install
fi

# check if git is installed
if [ -z "$(command -v git)" ]; then
   echo "Git is not installed" 1>&2
    git_install
fi

# check if ufw is installed
if [ -z "$(command -v ufw)" ]; then
   echo "Ufw is not installed" 1>&2
    ufw_install
fi

# check if nginx is installed
if [ -z "$(command -v nginx)" ]; then
   echo "Nginx is not installed" 1>&2
    nginx_install
fi

# check if certbot is installed
if [ -z "$(command -v certbot)" ]; then
   echo "Certbot is not installed" 1>&2
    certbot_install
fi

# setup nginx
echo "Setting up nginx..."
sudo mv ./conf.d/l3mon.conf /etc/nginx/conf.d/l3mon.conf
sudo nginx -t
sudo systemctl reload nginx
echo "Nginx setup done"

# setup ufw firewall
echo "Setting up ufw firewall..."
sudo ufw enable
sudo ufw allow http
sudo ufw allow https
sudo ufw status
echo "Ufw firewall setup done"
