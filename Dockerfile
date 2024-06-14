# Gunakan image node sebagai base image untuk build tahap pertama
FROM node:18-alpine AS build

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Copy package.json dan install dependencies
COPY package*.json ./
RUN npm install

# Copy seluruh kode aplikasi ke dalam container
COPY . .

# Build aplikasi menggunakan Vite
RUN npm run build

# Ekspose port 80 untuk mengakses aplikasi
EXPOSE 80

CMD [ "npm", "run", "dev" ]
