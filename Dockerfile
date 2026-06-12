##dockerfile index.php
# Utiliza a imagem oficial do PHP com Apache de forma leve (Alpine ou Debian Buster/Bullseye)
FROM php:8.2-apache

# Instala as extensões necessárias para o MySQL (utilizadas no seu conexao.php)
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Habilita o módulo de reescrita do Apache (útil para URLs amigáveis, se necessário)
RUN a2enmod rewrite

# Define o diretório de trabalho dentro do container
WORKDIR /var/www/html

# Copia todos os arquivos do seu projeto local para dentro do container
COPY . /var/www/html/

# Ajusta as permissões para que o Apache consiga ler os arquivos e escrever na pasta de uploads
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expõe a porta padrão do servidor web
EXPOSE 80

# O comando padrão da imagem base já inicia o Apache automaticamente, 
# então não é estritamente necessário definir o CMD.
