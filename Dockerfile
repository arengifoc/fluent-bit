# Stage 1: build/install cjson en imagen debug
FROM cr.fluentbit.io/fluent/fluent-bit:4.0.3-debug AS builder

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  build-essential \
  lua5.1 \
  liblua5.1-0-dev \
  luarocks \
  && luarocks install lua-cjson \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Stage 2: imagen runtime liviana
FROM cr.fluentbit.io/fluent/fluent-bit:4.0.3

# Copiar el módulo cjson compilado del builder
COPY --from=builder /usr/local/lib/lua/5.1/cjson.so /usr/local/lib/lua/5.1/cjson.so
