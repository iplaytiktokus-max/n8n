FROM node:20-alpine

# 安装 Python 3 和必要工具
RUN apk add --no-cache \
  python3 \
  py3-pip \
  py3-venv \
  build-base \
  gcc \
  g++ \
  make \
  libffi-dev \
  openssl-dev

WORKDIR /home/node

# 创建 Python 虚拟环境
RUN python3 -m venv /home/node/.venv
ENV PATH="/home/node/.venv/bin:$PATH"

# 升级 pip
RUN pip install --upgrade pip

# 安装 n8n
RUN npm install -g n8n

# 创建数据目录
RUN mkdir -p /home/node/.n8n && \
  chown -R node:node /home/node

USER node

EXPOSE 5678

CMD ["n8n", "start"]
