# Gunakan image node sebagai base image untuk build tahap pertama
FROM node:18-alpine AS build

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Copy package.json dan install dependencies
COPY package*.json ./
RUN yarn install --frozen-lockfile --network-timeout 1000000

# Copy seluruh kode aplikasi ke dalam container
COPY . .

# Build aplikasi menggunakan Vite
RUN yarn build

# Install serve untuk menyajikan aplikasi
RUN yarn global add serve

# Tahap akhir: gunakan image node untuk menjalankan aplikasi
FROM node:18-alpine

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Copy build output dari tahap pertama ke direktori kerja
COPY --from=build /app .

# Ekspose port 3000 untuk mengakses aplikasi
EXPOSE 3000

# Jalankan serve untuk menyajikan aplikasi build
CMD ["serve", "-s", "dist", "-l", "3000"]
