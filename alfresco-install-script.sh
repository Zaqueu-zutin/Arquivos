
#!/bin/bash

# Atualizar pacotes e instalar dependências
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-11-jdk wget unzip postgresql libfontconfig1

# Baixar o instalador do Alfresco
wget https://download.alfresco.com/release/community/7.4/alfresco-content-services-community-7.4-installer-linux-x64.bin
chmod +x alfresco-content-services-community-7.4-installer-linux-x64.bin

# Configurar o banco de dados PostgreSQL
sudo -u postgres psql <<EOF
CREATE DATABASE alfresco;
CREATE USER alfresco WITH PASSWORD 'alfresco';
GRANT ALL PRIVILEGES ON DATABASE alfresco TO alfresco;
EOF

# Executar o instalador do Alfresco
sudo ./alfresco-content-services-community-7.4-installer-linux-x64.bin --mode unattended --prefix /opt/alfresco

# Ajustar permissões e iniciar o serviço
sudo chown -R alfresco:alfresco /opt/alfresco
cd /opt/alfresco
sudo -u alfresco ./alfresco.sh start

# Configurar firewall para permitir acesso ao Alfresco
sudo ufw allow 8080
sudo ufw enable
