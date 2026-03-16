FROM node:20-bookworm
# ---- system dependencies ----
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   ca-certificates \
   curl \
   git \
   gosu \
   procps \
   python3 \
   build-essential \
   zip \
&& rm -rf /var/lib/apt/lists/*
# ---- install openclaw globally ----
RUN npm install -g openclaw@2026.3.2
# ---- app directory ----
WORKDIR /app
# ---- entrypoint ----
COPY --chmod=755 entrypoint.sh ./entrypoint.sh
# ---- create runtime user & data dir ----
RUN useradd -m -s /bin/bash openclaw \
&& mkdir -p /data \
&& chown -R openclaw:openclaw /app /data
# ---- runtime env ----
ENV PORT=8080
ENV OPENCLAW_ENTRY=/usr/local/lib/node_modules/openclaw/dist/entry.js
EXPOSE 8080
# ---- healthcheck ----
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
 CMD curl -f http://localhost:8080/setup/healthz || exit 1
# ---- drop to non-root ----
USER openclaw
ENTRYPOINT ["./entrypoint.sh"]
