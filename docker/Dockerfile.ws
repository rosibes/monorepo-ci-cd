FROM oven/bun:1

WORKDIR /app

# Install OpenSSL for Prisma
RUN apt-get update -y && apt-get install -y openssl

COPY ./packages ./packages
COPY ./bun.lock ./bun.lock

COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json

COPY ./apps/websocket ./apps/websocket

RUN bun install 

COPY . .

RUN bun run db:generate


EXPOSE 8081

CMD ["bun", "run", "start:ws"]