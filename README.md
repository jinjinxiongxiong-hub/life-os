# Life OS PWA

## 部署到手机桌面

### 方法一：在家庭服务器上运行（推荐，你有 Tailscale）

1. 将整个 `life-os` 文件夹复制到家庭服务器
2. 在服务器上运行：
   ```bash
   cd life-os
   python3 -m http.server 8080
   ```
3. 用手机通过 Tailscale 访问：`http://[你的Tailscale IP]:8080`
4. 添加到桌面：
   - **iOS Safari**：点分享按钮 → 添加到主屏幕
   - **Android Chrome**：菜单 → 添加到主屏幕 / 安装应用

### 方法二：Netlify 免费托管（一分钟完成，支持 HTTPS）

1. 访问 https://app.netlify.com/drop
2. 将 `life-os` 文件夹**拖拽**到页面
3. 得到一个 https:// 链接
4. 手机访问链接 → 添加到主屏幕

### 方法三：GitHub Pages

1. 将文件夹上传到 GitHub 仓库
2. Settings → Pages → Deploy from branch (main)
3. 访问生成的 URL → 添加到主屏幕

## 注意
- iOS 需要用 **Safari** 才能添加到主屏幕
- Android 用 **Chrome** 会自动弹出安装提示
- 数据保存在手机本地浏览器，不同设备不会同步
