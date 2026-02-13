FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine
RUN apk add --no-cache dumb-init
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
ENV NODE_ENV=production
EXPOSE 4000
ENTRYPOINT ["dumb-init", "npm"]
CMD ["start"]
