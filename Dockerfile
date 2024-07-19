# Use the official PHP 7.2 FPM image based on Alpine Linux
FROM php:7.2-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apk add --no-cache \
    bash \
    git \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents
COPY . /var/www/html

# Change ownership of application
RUN chown -R www-data:www-data /var/www/html

# Install npm dependencies
RUN npm install

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
