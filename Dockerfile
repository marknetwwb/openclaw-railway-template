FROM node:20-bookworm
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   ca-certificates curl git gosu procps python3 build-essential zip \
&& rm -rf /var/lib/apt/lists/*
RUN npm install -g openclaw@2026.3.2
WORKDIR /app
COPY --chmod=755 entrypoint.sh ./entrypoint.sh
RUN useradd -m -s /bin/bash openclaw \
&& mkdir -p /data \
&& chown -R openclaw:openclaw /app /data
ENV PORT=8080
ENV OPENCLAW_ENTRY=/usr/local/lib/node_modules/openclaw/dist/entry.js
EXPOSE 8080
USER openclaw
ENTRYPOINT ["./entrypoint.sh"]
