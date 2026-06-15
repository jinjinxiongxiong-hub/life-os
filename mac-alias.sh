# ── 把下面这段加到你 Mac 的 ~/.zshrc 或 ~/.bash_profile ──
# 改成你的 Tailscale IP 和用户名
LIFEOS_SERVER="你的用户名@你的Tailscale地址"
LIFEOS_PATH="~/life-os/index.html"

lifeos() {
  case "$1" in
    update)
      if [ -z "$2" ]; then echo "用法: lifeos update <文件路径>"; return 1; fi
      scp "$2" "$LIFEOS_SERVER:$LIFEOS_PATH" && echo "✓ Life OS 更新成功！"
      ;;
    open)
      open "http://$(echo $LIFEOS_SERVER | cut -d@ -f2):8080"
      ;;
    *)
      echo "lifeos update <文件>  — 上传新版本"
      echo "lifeos open           — 在浏览器打开"
      ;;
  esac
}
