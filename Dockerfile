# Gunakan image node sebagai base image untuk build tahap pertama
FROM node:18-alpine AS build

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Copy package.json dan install dependencies
COPY package*.json ./
RUN yarn cache clean
RUN yarn install --no-lockfile --timeout 1000000

# Copy seluruh kode aplikasi ke dalam container
COPY . .

# Build aplikasi menggunakan Vite
RUN yarn build

# Gunakan image nginx sebagai base image untuk tahap kedua
FROM nginx:alpine

# Copy build hasil dari tahap pertama ke direktori default Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copy konfigurasi Nginx custom
COPY nginx.conf /etc/nginx/nginx.conf

# Ekspose port 80 untuk mengakses aplikasi
EXPOSE 80

# Jalankan Nginx
CMD ["nginx", "-g", "daemon off;"]
