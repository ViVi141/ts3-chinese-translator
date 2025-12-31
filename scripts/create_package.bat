@echo off
REM 创建 TeamSpeak 3 插件安装包 (.ts3_plugin)
REM Create TeamSpeak 3 Plugin Package (.ts3_plugin)
REM GitHub: https://github.com/ViVi141/ts3-chinese-translator
REM Author: ViVi141 (747384120@qq.com)
chcp 65001 >nul 2>&1

echo ========================================
echo 创建 TS3 插件安装包
echo Create TS3 Plugin Package
echo GitHub: https://github.com/ViVi141/ts3-chinese-translator
echo Author: ViVi141
echo ========================================
echo.

REM Check if plugin DLL exists
if not exist "dist\ts3_translator_plugin.dll" (
    echo [错误] 未找到插件文件 dist\ts3_translator_plugin.dll
    echo [Error] Plugin file dist\ts3_translator_plugin.dll not found
    echo.
    echo 请先编译插件：
    echo Please compile the plugin first:
    echo   scripts\build_msys2.sh
    echo.
    pause
    exit /b 1
)

REM Check if package.ini exists
if not exist "package.ini" (
    echo [错误] 未找到 package.ini 文件
    echo [Error] package.ini file not found
    pause
    exit /b 1
)

REM Create temporary directory
set "TEMP_DIR=ts3_translator_plugin_temp"
if exist "%TEMP_DIR%" (
    rmdir /s /q "%TEMP_DIR%"
)
mkdir "%TEMP_DIR%"

echo [信息] 正在打包插件文件...
echo [Info] Packaging plugin files...

REM Copy plugin DLL
copy "dist\ts3_translator_plugin.dll" "%TEMP_DIR%\" >nul
if errorlevel 1 (
    echo [错误] 复制插件文件失败
    echo [Error] Failed to copy plugin file
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)

REM Copy package.ini
copy "scripts\package.ini" "%TEMP_DIR%\" >nul
if errorlevel 1 (
    echo [错误] 复制 package.ini 失败
    echo [Error] Failed to copy package.ini
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)

REM Create ZIP file (using PowerShell)
echo [信息] 正在创建 ZIP 压缩包...
echo [Info] Creating ZIP archive...

powershell -Command "Compress-Archive -Path '%TEMP_DIR%\*' -DestinationPath 'dist\ts3_translator_plugin.zip' -Force" >nul 2>&1
if errorlevel 1 (
    echo [错误] 创建 ZIP 文件失败
    echo [Error] Failed to create ZIP file
    echo.
    echo 提示：请确保已安装 PowerShell 或使用其他压缩工具手动创建 ZIP
    echo Tip: Please ensure PowerShell is installed or use another tool to create ZIP manually
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)

REM Rename ZIP to .ts3_plugin
if exist "dist\ts3_translator_plugin.ts3_plugin" (
    del "dist\ts3_translator_plugin.ts3_plugin"
)

ren "dist\ts3_translator_plugin.zip" "ts3_translator_plugin.ts3_plugin" >nul 2>&1
move "dist\ts3_translator_plugin.ts3_plugin" "dist\" >nul 2>&1
if errorlevel 1 (
    echo [错误] 重命名文件失败
    echo [Error] Failed to rename file
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b 1
)

REM Clean up
rmdir /s /q "%TEMP_DIR%"

echo.
echo ========================================
echo [成功] 插件安装包创建完成！
echo [Success] Plugin package created!
echo ========================================
echo.
echo 输出文件: dist\ts3_translator_plugin.ts3_plugin
echo Output file: dist\ts3_translator_plugin.ts3_plugin
echo.
echo 使用方法：
echo Usage:
echo   1. 双击 dist\ts3_translator_plugin.ts3_plugin 文件
echo      Double-click dist\ts3_translator_plugin.ts3_plugin file
echo   2. TeamSpeak 3 会自动启动安装向导
echo      TeamSpeak 3 will automatically start installation wizard
echo   3. 按照向导提示完成安装
echo      Follow the wizard to complete installation
echo.
pause

