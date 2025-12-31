# TeamSpeak 3 中文翻译插件

TeamSpeak 3 客户端插件，自动将接收到的文本消息翻译为中文。

TS3 Chinese Translator Plugin - Automatically translates received text messages to Chinese.

## 功能特性 / Features

- ✅ 自动翻译文本消息为中文
- ✅ 支持多种源语言（自动检测）
- ✅ 可配置的翻译设置
- ✅ 简单的命令控制界面
- ✅ 实时翻译显示

- ✅ Automatically translate text messages to Chinese
- ✅ Support multiple source languages (auto-detect)
- ✅ Configurable translation settings
- ✅ Simple command control interface
- ✅ Real-time translation display

## 编译 / Building

### MSYS2 (推荐 / Recommended)

在 MSYS2 MinGW64 终端中：

```bash
scripts/build_msys2.sh
```

### 使用 Makefile

```bash
make
```

编译产物会输出到 `dist/` 目录。

### 手动编译

```bash
mkdir -p dist
gcc -c -O2 -Wall -Iinclude src/plugin.c -o plugin.o
gcc -shared -o dist/ts3_translator_plugin.dll plugin.o -lwinhttp
rm plugin.o
```

## 安装 / Installation

### 方法一：使用 .ts3_plugin 安装包（推荐）

这是 TeamSpeak 3 官方支持的插件安装格式。

**创建安装包：**

Windows:
```cmd
scripts\create_package.bat
```

Linux/MSYS2:
```bash
chmod +x scripts/create_package.sh
scripts/create_package.sh
```

**安装：**
1. 双击生成的 `dist/ts3_translator_plugin.ts3_plugin` 文件
2. TeamSpeak 3 会自动启动安装向导
3. 按照向导提示完成安装

### 方法二：手动安装

1. 将编译生成的 `ts3_translator_plugin.dll` (Windows) 或 `ts3_translator_plugin.so` (Linux) 复制到 TeamSpeak 3 插件目录：
   - Windows: `%APPDATA%\TS3Client\plugins\`
   - Linux: `~/.ts3client/plugins/`

2. 重启 TeamSpeak 3 客户端

3. 在设置中启用插件：`设置` → `插件` → 启用 "TS3 中文翻译插件"

## 卸载 / Uninstallation

手动删除插件文件：
- Windows: `%APPDATA%\TS3Client\plugins\ts3_translator_plugin.dll`
- Linux: `~/.ts3client/plugins/ts3_translator_plugin.so`

删除后重启 TeamSpeak 3 客户端。

## 使用方法 / Usage

### 基本命令

- `/translate enable` - 启用翻译功能
- `/translate disable` - 禁用翻译功能
- `/translate status` - 查看当前翻译状态
- `/translate setlang <源语言> <目标语言>` - 设置翻译语言
- `/translate test <文本>` - **测试翻译功能**（将指定文本翻译成中文）

### 示例 / Examples

```
/translate enable          # 启用翻译
/translate disable         # 禁用翻译
/translate status          # 查看状态
/translate setlang auto zh # 设置从自动检测到中文
/translate setlang en zh   # 设置从英语到中文
/translate test Hello world # 测试翻译 "Hello world" 为中文
```

### 菜单项 / Menu Items

插件在 TeamSpeak 3 的 `插件` → `翻译插件` 菜单中提供以下选项：

- **翻译状态** - 查看当前翻译状态和语言设置
- **启用翻译** - 启用自动翻译功能
- **禁用翻译** - 禁用自动翻译功能

## 测试插件 / Testing

编译并安装插件后，请按照以下步骤测试：

1. **启动 TeamSpeak 3** 并连接到服务器

2. **检查插件状态：**
   ```
   /translate status
   ```

3. **测试翻译功能：**
   - 让其他用户发送消息（英文或其他语言）
   - 观察是否自动显示翻译结果

4. **测试命令控制：**
   ```
   /translate disable    # 禁用翻译
   /translate enable     # 启用翻译
   /translate setlang en zh  # 设置语言
   ```

**详细测试指南：** 请查看 `测试指南.md` 文件

### 语言代码 / Language Codes

常用语言代码：
- `auto` - 自动检测
- `en` - 英语
- `zh` - 中文
- `ja` - 日语
- `ko` - 韩语
- `de` - 德语
- `fr` - 法语
- `es` - 西班牙语
- `ru` - 俄语

## 工作原理 / How It Works

插件会拦截所有接收到的文本消息（不包括自己发送的消息），然后：
1. 调用 Google Translate API 进行翻译
2. 将翻译结果显示在当前聊天标签页
3. 原始消息仍然正常显示

## 注意事项 / Notes

- 需要网络连接才能使用翻译功能
- 翻译服务使用 Google Translate 免费 API
- 翻译结果会显示在聊天窗口中，格式为：`[翻译] 用户名: 翻译后的文本`
- 插件不会修改原始消息，只是添加翻译结果

## 故障排除 / Troubleshooting

如果翻译不工作：
1. 检查网络连接
2. 确认插件已启用：`/translate status`
3. 查看 TeamSpeak 日志文件中的错误信息

## 许可证 / License

基于 TeamSpeak 3 Client Plugin SDK，遵循相同的许可证条款。

Based on TeamSpeak 3 Client Plugin SDK, following the same license terms.

## 贡献 / Contributing

欢迎提交问题和改进建议！

Issues and pull requests are welcome!

