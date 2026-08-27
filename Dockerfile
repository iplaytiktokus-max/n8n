FROM node:20-alpine
# 安装 Python 3 和必要工具
RUN apk add --no-cache \
 python3 \
 py3-pip \
 build-base \
 gcc \
 g++ \
 make \
 libffi-dev \
 openssl-dev
WORKDIR /home/node
# 创建虚拟环境目录
RUN mkdir -p /home/node/.venv && \
 python3 -m venv /home/node/.venv
ENV PATH="/home/node/.venv/bin:$PATH"
# 升级 pip
RUN /home/node/.venv/bin/pip install --upgrade pip
# 安装 n8n
RUN npm install -g n8n
# 创建数据目录
RUN mkdir -p /home/node/.n8n && \
 chown -R node:node /home/node
USER node
EXPOSE 5678
CMD ["n8n", "start"]
