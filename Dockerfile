# Step 1: Use official Node.js image
FROM node:20-alpine

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package files for caching
COPY package.json package-lock.json ./

# Step 4: Install dependencies with proper cache
# id=npm-cache fixes the "Cache mount ID" error
RUN --mount=type=cache,id=npm-cache,target=/root/.npm \
    npm ci

# Step 5: Copy all source code
COPY . .

# Step 6: Build the project if needed
RUN npm run build

# Step 7: Set port and expose
ENV PORT=3000
EXPOSE 3000

# Step 8: Start the app
CMD ["npm", "start"]
