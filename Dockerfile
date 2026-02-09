# 1️⃣ Use official Node.js image
FROM node:20-alpine

# 2️⃣ Set working directory
WORKDIR /app

# 3️⃣ Copy package files first (to leverage cache)
COPY package.json package-lock.json ./

# 4️⃣ Install dependencies with proper cache
# ✅ id=npm-cache fixes the "Cache mount ID" error
RUN --mount=type=cache,id=npm-cache,target=/root/.npm \
    npm ci

# 5️⃣ Copy the rest of the application code
COPY . .

# 6️⃣ Build the project (if you have a build step)
RUN npm run build

# 7️⃣ Expose port (Railway injects PORT env)
ENV PORT=3000
EXPOSE 3000

# 8️⃣ Start the application
CMD ["npm", "start"]
