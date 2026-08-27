FROM node:20-alpine

# 安装 Python 3 和其他必要的工具
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    gcc \
    g++ \
    make

# 设置 n8n 工作目录
WORKDIR /home/node

# 安装 n8n
RUN npm install -g n8n

# 创建数据目录
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node

# 切换到 node 用户
USER node

# 暴露端口
EXPOSE 5678

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz || exit 1

# 启动 n8n
CMD ["n8n", "start"]
