# 毕业设计协同指导平台部署文档

## 1. 环境要求
- **Docker**: 需安装 Docker Desktop (Windows/Mac) 或 Docker Engine (Linux)。
- **端口占用检查**: 请确保本地以下端口未被占用：
  - `80`: 前端访问端口
  - `8080`: 后端 API 端口
  - `3306`: MySQL 数据库端口
  - `6379`: Redis 缓存端口

## 2. 快速部署 (Docker Compose)

在项目根目录下（即包含 `docker-compose.yml` 的目录），打开终端执行以下命令：

```bash
# 1. 构建镜像并启动服务 (首次部署或代码修改后使用)
docker-compose up --build -d

# 2. 查看容器运行状态
docker-compose ps

# 3. 查看日志 (可选)
docker-compose logs -f
```

## 3. 访问地址
- **前端页面**: [http://localhost](http://localhost)
  - 默认管理员账号: `admin` / `admin123`
  - 默认教师账号: `teacher1` / `123456`
  - 默认学生账号: `student1` / `123456`
- **后端接口**: [http://localhost:8080/api](http://localhost:8080/api)
- **数据库**: `localhost:3306` (用户: `root`, 密码: `password`, 库名: `grad_platform`)

## 4. 停止服务

```bash
# 停止并删除容器
docker-compose down
```

## 5. 常见问题
1. **MySQL 连接失败**: 首次启动时 MySQL 初始化可能需要几十秒，后端服务可能会重试连接，请耐心等待或重启后端容器 (`docker-compose restart backend`)。
2. **前端 404**: 请确保 `nginx.conf` 配置正确，并且 Vue 项目构建成功。
3. **验证码过期**: Redis 未启动或连接失败，请检查 Redis 容器状态。
