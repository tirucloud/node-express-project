# --------------------------
# Stage 1: Build Application
# --------------------------
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm ci

# Copy source and compile TypeScript
COPY . .
RUN npm run build

# -----------------------------
# Stage 2: Distroless Runtime
# -----------------------------
FROM gcr.io/distroless/nodejs20

WORKDIR /app

# Copy compiled JS and node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Non-root user for security
USER nonroot

# Expose the port (optional)
EXPOSE 3000

# Run app
CMD ["dist/index.js"]

