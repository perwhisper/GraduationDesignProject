# 毕业设计协同指导平台部署文档

## 1. 准备工作

### 1.1 域名解析
请登录您的域名服务商控制台（如阿里云/腾讯云），添加 **A记录**：
- 主机记录: `@`
- 记录值: `114.132.125.221`

(可选) 添加 www 记录:
- 主机记录: `www`
- 记录值: `114.132.125.221`

### 1.2 服务器连接
使用 SSH 连接到您的服务器：
```bash
ssh root@114.132.125.221
# 输入密码登录
```

## 2. 代码部署 (服务器端)

在服务器上执行以下命令：

```bash
# 1. 安装 Git 和 Docker (如果尚未安装)
# (CentOS 示例)
yum install -y git
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl start docker

# 2. 克隆代码
git clone git@github.com:perwhisper/GraduationDesignProject.git
cd GraduationDesignProject

# 3. 启动服务
docker compose up --build -d
```

## 3. 访问验证

部署成功后，通过浏览器访问：
- **正式域名**: [http://wangfuguo.xyz](http://wangfuguo.xyz)
- **IP访问**: [http://114.132.125.221](http://114.132.125.221)

### 默认账号
- 管理员: `admin` / `admin123`
- 教师: `teacher1` / `123456`
- 学生: `student1` / `123456`

## 4. 常见运维命令

```bash
# 查看日志
docker compose logs -f

# 重启服务
docker compose restart

# 更新代码并重新部署
git pull
docker compose up --build -d
```
