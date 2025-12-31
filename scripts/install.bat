@echo off
REM 安装 TeamSpeak 3 插件
REM Install TeamSpeak 3 plugin
chcp 65001 >nul 2>&1

echo ========================================
echo TS3 中文翻译插件 - 安装
echo TS3 Chinese Translator - Install
echo ========================================
echo.

cd /d "%~dp0\.."

REM Check if DLL exists
if not exist "dist\ts3_translator_plugin.dll" (
    echo [错误] 未找到插件文件
    echo [Error] Plugin file not found
    echo.
    echo 请先编译：make 或 scripts\build_msys2.sh
    echo Please compile first: make or scripts\build_msys2.sh
    goto :end
)

REM Set TS3 plugin directory
set "TS3_PLUGIN_DIR=%APPDATA%\TS3Client\plugins"

echo [信息] 目标目录: %TS3_PLUGIN_DIR%
echo [Info] Target directory: %TS3_PLUGIN_DIR%
echo.

REM Check if TS3 plugin directory exists
if not exist "%TS3_PLUGIN_DIR%" (
    echo [警告] TeamSpeak 3 插件目录不存在
    echo [Warning] TeamSpeak 3 plugin directory does not exist
    echo.
    echo 创建目录? / Create directory?
    choice /C YN /M "Y=Yes, N=No"
    if errorlevel 2 goto :end
    mkdir "%TS3_PLUGIN_DIR%"
    if errorlevel 1 (
        echo [错误] 无法创建目录
        echo [Error] Failed to create directory
        goto :end
    )
)

REM Backup existing plugin if exists
if exist "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll" (
    echo [信息] 发现已存在的插件，正在备份...
    echo [Info] Found existing plugin, backing up...
    copy "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll" "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll.backup" >nul 2>&1
)

REM Copy DLL to TS3 plugins directory
echo [信息] 正在安装插件...
echo [Info] Installing plugin...
copy "dist\ts3_translator_plugin.dll" "%TS3_PLUGIN_DIR%\" >nul
if errorlevel 1 (
    echo [错误] 安装失败
    echo [Error] Installation failed
    echo.
    echo 可能原因: / Possible reasons:
    echo - TeamSpeak 3 正在运行（请先关闭）
    echo   TeamSpeak 3 is running (please close it)
    echo - 权限不足（以管理员身份运行）
    echo   Insufficient permissions (run as administrator)
    goto :end
)

echo [成功] 插件安装成功！
echo [Success] Plugin installed successfully!
echo.
echo 文件信息: / File info:
dir "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll"
echo.
echo ========================================
echo 下一步 / Next Steps
echo ========================================
echo.
echo 1. 启动 TeamSpeak 3 / Start TeamSpeak 3
echo 2. 打开 设置 ^> 插件 / Open Settings ^> Plugins
echo 3. 勾选 "TS3 Chinese Translator"
echo 4. 测试: /translate status
echo.

:end
pause
