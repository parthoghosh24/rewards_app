FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3001
ENV VITE_HOST=0.0.0.0
CMD ["npm", "run", "dev"]