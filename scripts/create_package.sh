#!/bin/bash
# 创建 TeamSpeak 3 插件安装包 (.ts3_plugin)
# Create TeamSpeak 3 Plugin Package (.ts3_plugin)
# GitHub: https://github.com/ViVi141/ts3-chinese-translator
# Author: ViVi141 (747384120@qq.com)

echo "========================================"
echo "创建 TS3 插件安装包"
echo "Create TS3 Plugin Package"
echo "GitHub: https://github.com/ViVi141/ts3-chinese-translator"
echo "Author: ViVi141"
echo "========================================"
echo ""

# Check if plugin DLL exists
if [ ! -f "dist/ts3_translator_plugin.dll" ]; then
    echo "[错误] 未找到插件文件 dist/ts3_translator_plugin.dll"
    echo "[Error] Plugin file dist/ts3_translator_plugin.dll not found"
    echo ""
    echo "请先编译插件："
    echo "Please compile the plugin first:"
    echo "  scripts/build_msys2.sh"
    echo ""
    exit 1
fi

# Check if package.ini exists
if [ ! -f "scripts/package.ini" ]; then
    echo "[错误] 未找到 package.ini 文件"
    echo "[Error] package.ini file not found"
    exit 1
fi

# Create temporary directory
TEMP_DIR="ts3_translator_plugin_temp"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

echo "[信息] 正在打包插件文件..."
echo "[Info] Packaging plugin files..."

# Copy plugin DLL
cp "dist/ts3_translator_plugin.dll" "$TEMP_DIR/" || {
    echo "[错误] 复制插件文件失败"
    echo "[Error] Failed to copy plugin file"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Copy package.ini
cp "scripts/package.ini" "$TEMP_DIR/" || {
    echo "[错误] 复制 package.ini 失败"
    echo "[Error] Failed to copy package.ini"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Create ZIP file
echo "[信息] 正在创建 ZIP 压缩包..."
echo "[Info] Creating ZIP archive..."

mkdir -p dist
cd "$TEMP_DIR"
zip -r "../dist/ts3_translator_plugin.zip" . > /dev/null 2>&1
cd ..

if [ $? -ne 0 ]; then
    echo "[错误] 创建 ZIP 文件失败"
    echo "[Error] Failed to create ZIP file"
    echo ""
    echo "提示：请确保已安装 zip 工具"
    echo "Tip: Please ensure zip tool is installed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Rename ZIP to .ts3_plugin
if [ -f "dist/ts3_translator_plugin.ts3_plugin" ]; then
    rm -f "dist/ts3_translator_plugin.ts3_plugin"
fi

mv "dist/ts3_translator_plugin.zip" "dist/ts3_translator_plugin.ts3_plugin" || {
    echo "[错误] 重命名文件失败"
    echo "[Error] Failed to rename file"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Clean up
rm -rf "$TEMP_DIR"

echo ""
echo "========================================"
echo "[成功] 插件安装包创建完成！"
echo "[Success] Plugin package created!"
echo "========================================"
echo ""
echo "输出文件: dist/ts3_translator_plugin.ts3_plugin"
echo "Output file: dist/ts3_translator_plugin.ts3_plugin"
echo ""
echo "使用方法："
echo "Usage:"
echo "  1. 双击 dist/ts3_translator_plugin.ts3_plugin 文件"
echo "     Double-click dist/ts3_translator_plugin.ts3_plugin file"
echo "  2. TeamSpeak 3 会自动启动安装向导"
echo "     TeamSpeak 3 will automatically start installation wizard"
echo "  3. 按照向导提示完成安装"
echo "     Follow the wizard to complete installation"
echo ""

