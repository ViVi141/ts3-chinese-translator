# TeamSpeak 3 中文翻译插件

这是一个基于 TeamSpeak 3 Client Plugin SDK 开发的翻译插件项目。

**GitHub:** https://github.com/ViVi141/ts3-chinese-translator  
**作者:** ViVi141 (747384120@qq.com)

## 项目结构

```
ts3-chinese-translator/
├── include/              # SDK 头文件
│   ├── plugin_definitions.h
│   ├── ts3_functions.h
│   └── teamspeak/       # TeamSpeak 核心定义
├── src/                 # 源代码
│   ├── plugin.c         # 主插件代码
│   ├── plugin.h         # 插件头文件
│   └── icons/           # 图标资源（可选）
├── scripts/             # 构建和安装脚本
│   ├── build_msys2.sh   # MSYS2 编译脚本
│   ├── install.bat / install.ps1 # Windows 安装脚本
│   └── package.ini      # 插件描述文件
├── dist/                # 编译输出目录（自动生成）
│   ├── ts3_translator_plugin.dll
├── Makefile             # Make 构建文件
├── README.md            # 本文件
├── README_TRANSLATOR.md # 插件使用说明
└── 测试指南.md          # 测试指南
```

## 快速开始

### 1. 编译插件

**使用 MSYS2（推荐）：**
```bash
scripts/build_msys2.sh
```

**使用 Makefile：**
```bash
make
```

编译产物会输出到 `dist/` 目录。

### 2. 安装插件

推荐：使用安装脚本（自动复制到 TS3 插件目录）
```cmd
scripts\install.bat
```

或手动复制 DLL：
将 `dist/ts3_translator_plugin.dll` 复制到 `%APPDATA%\TS3Client\plugins\`

### 3. 使用插件

详细说明请查看 `README_TRANSLATOR.md`

## 目录说明

- **include/** - TeamSpeak 3 SDK 头文件（不要修改）
- **src/** - 插件源代码
- **scripts/** - 构建、安装、打包脚本
- **dist/** - 编译输出目录（自动生成，已加入 .gitignore）

## 文档

- **插件使用说明：** `README_TRANSLATOR.md`
- **测试指南：** `测试指南.md`

## 开发

### 编译
```bash
# MSYS2
scripts/build_msys2.sh

# 或使用 Make
make
```

### 清理
```bash
make clean
# 或手动删除 dist/ 目录
```

## 项目信息

- **GitHub 仓库:** https://github.com/ViVi141/ts3-chinese-translator
- **作者:** ViVi141
- **邮箱:** 747384120@qq.com

## 基于

本项目基于 TeamSpeak 3 Client Plugin SDK，遵循相同的许可证条款。

Copyright &copy; TeamSpeak Systems GmbH. All rights reserved.
