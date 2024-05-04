#!usr/bin/env bash
# Install Nginxif does not exist
if ! which nginx >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y nginx
fi
sudo ufw allow 'Nginx HTTP'
# Create directories
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html

#creating fake index.html
sudo echo "<html>
  <head>
  </head>
  <body>
    <h1>Holberton School</h1>
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create and update symbolic link
sudo ln -s  /data/web_static/releases/test/ /data/web_static/current

# Set ownership recursively
sudo chown -R ubuntu: /data/

#update nginx configuration
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

#restart nginx
sudo service nginx restart

echo "Web server setup complete!"
