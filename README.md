# TeamSpeak 3 中文翻译插件

这是一个基于 TeamSpeak 3 Client Plugin SDK 开发的翻译插件项目。

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
├── scripts/             # 构建和打包脚本
│   ├── build_msys2.sh   # MSYS2 编译脚本
│   ├── create_package.bat/sh  # 创建安装包
│   └── package.ini      # 插件描述文件
├── dist/                # 编译输出目录（自动生成）
│   ├── ts3_translator_plugin.dll
│   └── ts3_translator_plugin.ts3_plugin
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

**创建安装包：**
```cmd
scripts\create_package.bat
```
然后双击 `dist/ts3_translator_plugin.ts3_plugin` 文件安装。

或手动将 `dist/ts3_translator_plugin.dll` 复制到 TeamSpeak 3 插件目录。


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

### 打包
```bash
# Windows
scripts\create_package.bat

# Linux/MSYS2
scripts/create_package.sh
```

### 清理
```bash
make clean
# 或手动删除 dist/ 目录
```

## 基于

本项目基于 TeamSpeak 3 Client Plugin SDK，遵循相同的许可证条款。

Copyright &copy; TeamSpeak Systems GmbH. All rights reserved.
