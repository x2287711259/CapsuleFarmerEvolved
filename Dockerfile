FROM python:3.12-slim

# 设置环境变量
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

# 设置工作目录
WORKDIR /app

# 安装编译所需的系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/*

# 直接通过 pip 安装项目运行所需的所有依赖
RUN pip install --no-cache-dir httpx[http2] requests beautifulsoup4 pyyaml rich pyjwt imaplib2

# 复制项目所有源码到容器中
COPY . .

# 容器启动时的默认执行命令
ENTRYPOINT ["python", "src/main.py"]
CMD ["-c", "/config/config.yaml"]
