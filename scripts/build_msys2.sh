#!/bin/bash
# Build script for TS3 Translator Plugin using MSYS2
# Run this script in MSYS2 MinGW64 terminal

echo "========================================"
echo "TS3 Translator Plugin Builder (MSYS2)"
echo "========================================"
echo ""

# Check if we're in MSYS2 environment
if [ -z "$MSYSTEM" ]; then
    echo "[错误] 请在 MSYS2 MinGW64 终端中运行此脚本！"
    echo "[Error] Please run this script in MSYS2 MinGW64 terminal!"
    echo ""
    echo "启动 MSYS2 MinGW64 终端，然后运行："
    echo "Start MSYS2 MinGW64 terminal, then run:"
    echo "  cd /path/to/ts3-chinese-translator"
    echo "  scripts/build_msys2.sh"
    echo ""
    exit 1
fi

# Check if GCC is available
if ! command -v gcc &> /dev/null; then
    echo "[错误] 未找到 GCC 编译器！"
    echo "[Error] GCC compiler not found!"
    echo ""
    echo "请安装 GCC："
    echo "Please install GCC:"
    echo "  pacman -S mingw-w64-x86_64-gcc"
    echo ""
    exit 1
fi

echo "[信息] 找到 GCC 编译器"
gcc --version
echo ""

echo "[信息] 开始编译..."
echo "[Info] Starting compilation..."
echo ""

# Compile
gcc -c -O2 -Wall -Iinclude src/plugin.c -o plugin.o
if [ $? -ne 0 ]; then
    echo "[错误] 编译失败！"
    echo "[Error] Compilation failed!"
    exit 1
fi

echo "[信息] 编译成功，正在链接..."
echo "[Info] Compilation successful, linking..."
echo ""

# Create dist directory if it doesn't exist
mkdir -p dist

# Link
gcc -shared -o dist/ts3_translator_plugin.dll plugin.o -lwinhttp
if [ $? -ne 0 ]; then
    echo "[错误] 链接失败！"
    echo "[Error] Linking failed!"
    echo ""
    echo "请确保已安装 WinHTTP 库："
    echo "Please make sure WinHTTP library is installed:"
    echo "  pacman -S mingw-w64-x86_64-winhttp"
    echo ""
    exit 1
fi

# Clean up object file
rm -f plugin.o

echo ""
echo "========================================"
echo "[成功] 编译完成！"
echo "[Success] Build completed!"
echo "========================================"
echo ""
echo "输出文件: dist/ts3_translator_plugin.dll"
echo "Output file: dist/ts3_translator_plugin.dll"
echo ""
echo "安装步骤："
echo "Installation steps:"
echo "1. 运行安装脚本: install.bat 或 install.ps1"
echo "   Run installer: install.bat or install.ps1"
echo ""
echo "   或手动复制 ts3_translator_plugin.dll 到插件目录："
echo "   Or manually copy ts3_translator_plugin.dll to plugins directory:"
echo "   Windows: %APPDATA%\\TS3Client\\plugins\\"
echo ""
echo "2. 重启 TeamSpeak 3 客户端"
echo "   Restart TeamSpeak 3 client"
echo ""
echo "3. 在设置中启用插件：设置 -> 插件"
echo "   Enable plugin in Settings -> Plugins"
echo ""

