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

# Ekspose port 5173 untuk mengakses aplikasi
EXPOSE 5173

# Jalankan 
CMD ["yarn", "start", "--hostname", "0.0.0.0"]
