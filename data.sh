#!/bin/bash
yum update -y
yum install -y git httpd docker
systemctl enable httpd
systemctl start httpd
systemctl enable docker
systemctl start docker
usermod -a -G docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cat <<EOF > docker-compose.yml
services:
  db:
    image: mysql:8.0.15
    container_name: wordpress_db
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: saikrishna
      MYSQL_USER: saikrishna
      MYSQL_PASSWORD: krishna123

  wordpress:
    image: wordpress:latest
    container_name: wordpress_app
    depends_on:
      - db
    ports:
      - "9000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: saikrishna
      WORDPRESS_DB_PASSWORD: krishna123
      WORDPRESS_DB_NAME: saikrishna
    volumes:
      - wordpress_data:/var/www/html

volumes:
  db_data:
  wordpress_data:
EOF

sudo docker-compose -p my_project up
