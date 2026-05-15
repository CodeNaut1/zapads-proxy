FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Download zapads-proxy linux binary
RUN curl -o /tmp/zapads-proxy.tar.gz "https://trab0l1kyfmadpgy.public.blob.vercel-storage.com/releases/zapads-proxy/v0.1.0/zapads-proxy_0.1.0_linux_amd64.tar.gz" \
    && tar -xzf /tmp/zapads-proxy.tar.gz -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/zapads-proxy \
    && rm /tmp/zapads-proxy.tar.gz

# Create config directory
RUN mkdir -p /root/.zapads-proxy

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
