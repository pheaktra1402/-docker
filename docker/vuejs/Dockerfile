FROM node:22-alpine

WORKDIR /app

# ១. ចម្លងឯកសារ package.json ចូលទៅក្នុងកុងតឺន័រ
COPY vuejs-app/package*.json ./

# ២. ដំឡើង node_modules នៅក្នុងកុងតឺន័រ
RUN npm install

# ៣. បញ្ជាឲ្យវា run start server របស់ Vite ពេលកុងតឺន័របើកដំណើរការ
CMD ["npm", "run", "dev"]