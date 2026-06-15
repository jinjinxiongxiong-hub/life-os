#!/bin/bash
# Life OS 服务器一次性安装脚本
# 在你的 Debian 家庭服务器上运行

set -e
echo "── Life OS 服务器安装 ──"

# 安装 nginx
sudo apt-get update -q && sudo apt-get install -y nginx

# 部署目录
DEPLOY_DIR="$HOME/life-os"
mkdir -p "$DEPLOY_DIR"
echo "✓ 部署目录：$DEPLOY_DIR"

# Nginx 配置
sudo tee /etc/nginx/sites-available/life-os > /dev/null << NGINX
server {
    listen 8080;
    root $DEPLOY_DIR;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
        add_header Cache-Control "no-cache";
    }

    location ~* \.(png|json|js)$ {
        expires 7d;
        add_header Cache-Control "public, max-age=604800";
    }
}
NGINX

sudo ln -sf /etc/nginx/sites-available/life-os /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
echo "✓ Nginx 已配置，端口 8080"

# 生成快捷更新脚本（在服务器上执行）
cat > "$DEPLOY_DIR/update.sh" << 'UPDATE'
#!/bin/bash
# 用法: ./update.sh /path/to/new/index.html
if [ -z "$1" ]; then echo "用法: ./update.sh <新的 index.html 路径>"; exit 1; fi
cp "$1" "$HOME/life-os/index.html"
echo "✓ Life OS 已更新 $(date '+%Y-%m-%d %H:%M')"
UPDATE
chmod +x "$DEPLOY_DIR/update.sh"

echo ""
echo "══════════════════════════════════"
echo "安装完成！"
echo ""
echo "访问地址（Tailscale）："
echo "  http://$(tailscale ip --4 2>/dev/null || echo '[你的Tailscale IP]'):8080"
echo ""
echo "以后更新只需在你的 Mac 上运行："
echo "  scp 新的index.html 用户名@tailscale地址:~/life-os/index.html"
echo "══════════════════════════════════"
