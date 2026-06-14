# AgentBridge 命令速查

## 基础启动

```bash
abg-open
```

启动默认 cowork 双 Agent：Claude + Codex。

```bash
abg-open --resume --logs
```

恢复上次 Claude / Codex 会话，并打开日志窗口。

```bash
abg-open --doctor
```

启动前先检查 AgentBridge 状态。

## 刷新本地插件缓存

从本地 fork 同步最新代码到 Claude 插件缓存：

```bash
cd /Users/ywbw/Documents/Codex/2026-06-13/files-mentioned-by-the-user-codex/work/agent-bridge-ton618
bun run build:plugin
bun src/cli.ts dev
```

然后在 Claude Code 里执行：

```text
/reload-plugins
```

如果当前 bridge 会话仍在用旧 daemon，重启当前 pair：

```bash
cd /Users/ywbw/cowork
abg --pair main kill
abg-open --resume --logs
```

更彻底的本地全局安装刷新：

```bash
cd /Users/ywbw/Documents/Codex/2026-06-13/files-mentioned-by-the-user-codex/work/agent-bridge-ton618
bun run install:global:local -- --force
```

注意：全局安装会在安装成功后停止正在运行的 AgentBridge daemon，需要重开会话。

## Codex 权限快捷命令

```bash
abg-open --codex-read-only
```

Codex 只读，不能写文件。

```bash
abg-open --codex-workspace-write
```

Codex 可写当前 workspace。日常推荐用这个。

```bash
abg-open --codex-full-access
```

Codex 使用 full-access sandbox。

## Claude 权限模式

```bash
abg-open --claude-permission-mode plan
```

Claude 进入 plan 模式。

```bash
abg-open --claude-permission-mode bypassPermissions
```

Claude 跳过权限确认。

## 高权限组合

```bash
abg-open --codex-full-access --codex-approval never --claude-permission-mode bypassPermissions
```

高权限启动。Codex full access，且不再询问 approval；Claude 也跳过权限确认。

```bash
abg-open --resume --codex-full-access --codex-approval never --claude-permission-mode bypassPermissions
```

高权限恢复上次会话。

## Codex 进阶权限参数

```bash
abg-open --codex-sandbox read-only
abg-open --codex-sandbox workspace-write
abg-open --codex-sandbox danger-full-access
```

手动指定 Codex sandbox。

```bash
abg-open --codex-approval on-request
abg-open --codex-approval never
```

手动指定 Codex approval 策略。

## 模型选择

```bash
abg-open --pro
```

Claude 使用 `deepseek-v4-pro`。

```bash
abg-open --flash
```

Claude 使用 `deepseek-v4-flash`。

```bash
abg-open --model deepseek-v4-pro
```

手动指定 Claude 模型。

## 多 pair

```bash
abg-open --pair review --logs
```

启动一个名为 `review` 的独立 pair，并打开日志。

## 指定项目

```bash
abg-open /path/to/project
```

在指定项目目录启动。

```bash
abg-open /path/to/project/file.gd
```

传入文件路径时，会在该文件的父目录启动。

## 常用推荐

日常写代码：

```bash
abg-open --codex-workspace-write
```

继续上次会话：

```bash
abg-open --resume --codex-workspace-write --logs
```

需要最大权限：

```bash
abg-open --codex-full-access --codex-approval never --claude-permission-mode bypassPermissions
```
