@echo off
REM TS3 翻译插件安装脚本
REM TS3 Translator Plugin Installer
chcp 65001 >nul 2>&1

echo ========================================
echo TS3 中文翻译插件安装程序
echo TS3 Chinese Translator Plugin Installer
echo ========================================
echo.

REM Check if plugin DLL exists
if not exist "dist\ts3_translator_plugin.dll" (
    echo [错误] 未找到插件文件 dist\ts3_translator_plugin.dll
    echo [Error] Plugin file dist\ts3_translator_plugin.dll not found
    echo.
    echo 请先编译插件：
    echo Please compile the plugin first:
    echo   1. 打开 MSYS2 MinGW64 终端
    echo      Open MSYS2 MinGW64 terminal
    echo   2. 运行: scripts\build_msys2.sh
    echo      Run: scripts\build_msys2.sh
    echo.
    pause
    exit /b 1
)

echo [信息] 找到插件文件
echo [Info] Plugin file found
echo.

REM Get TeamSpeak 3 plugins directory
set "PLUGIN_DIR=%APPDATA%\TS3Client\plugins"

REM Check if directory exists
if not exist "%PLUGIN_DIR%" (
    echo [警告] TeamSpeak 3 插件目录不存在
    echo [Warning] TeamSpeak 3 plugins directory does not exist
    echo.
    echo 尝试创建目录: %PLUGIN_DIR%
    echo Attempting to create directory: %PLUGIN_DIR%
    mkdir "%PLUGIN_DIR%" 2>nul
    if errorlevel 1 (
        echo [错误] 无法创建插件目录
        echo [Error] Cannot create plugins directory
        pause
        exit /b 1
    )
    echo [成功] 目录创建成功
    echo [Success] Directory created successfully
    echo.
)

echo [信息] 插件目录: %PLUGIN_DIR%
echo [Info] Plugin directory: %PLUGIN_DIR%
echo.

REM Check if plugin is already installed
set "INSTALLED=0"
if exist "%PLUGIN_DIR%\ts3_translator_plugin.dll" (
    set "INSTALLED=1"
    echo [信息] 检测到已安装的插件
    echo [Info] Existing plugin installation detected
    echo.
    echo 选项：
    echo Options:
    echo   1. 覆盖安装 (Overwrite)
    echo   2. 备份后安装 (Backup and install)
    echo   3. 取消 (Cancel)
    echo.
    set /p CHOICE="请选择 (1-3) / Please choose (1-3): "
    
    if "%CHOICE%"=="1" (
        echo [信息] 覆盖安装...
        echo [Info] Overwriting...
    ) else if "%CHOICE%"=="2" (
        set "BACKUP_FILE=%PLUGIN_DIR%\ts3_translator_plugin.dll.backup.%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
        set "BACKUP_FILE=%BACKUP_FILE: =0%"
        copy "%PLUGIN_DIR%\ts3_translator_plugin.dll" "%BACKUP_FILE%" >nul 2>&1
        if errorlevel 1 (
            echo [警告] 备份失败，继续安装...
            echo [Warning] Backup failed, continuing installation...
        ) else (
            echo [成功] 已备份到: %BACKUP_FILE%
            echo [Success] Backed up to: %BACKUP_FILE%
        )
    ) else (
        echo [信息] 安装已取消
        echo [Info] Installation cancelled
        pause
        exit /b 0
    )
    echo.
)

REM Copy plugin file
echo [信息] 正在复制插件文件...
echo [Info] Copying plugin file...
copy "dist\ts3_translator_plugin.dll" "%PLUGIN_DIR%\" >nul 2>&1
if errorlevel 1 (
    echo [错误] 复制失败！请检查权限。
    echo [Error] Copy failed! Please check permissions.
    echo.
    echo 提示：尝试以管理员身份运行此脚本
    echo Tip: Try running this script as administrator
    pause
    exit /b 1
)

echo [成功] 插件安装成功！
echo [Success] Plugin installed successfully!
echo.

REM Verify installation
if exist "%PLUGIN_DIR%\ts3_translator_plugin.dll" (
    echo [验证] 插件文件已存在于插件目录
    echo [Verify] Plugin file exists in plugins directory
    echo.
) else (
    echo [警告] 验证失败，但文件可能已复制
    echo [Warning] Verification failed, but file may have been copied
    echo.
)

echo ========================================
echo 安装完成！
echo Installation completed!
echo ========================================
echo.
echo 下一步：
echo Next steps:
echo   1. 启动 TeamSpeak 3 客户端
echo      Start TeamSpeak 3 client
echo   2. 打开设置: 工具 -^> 选项 -^> 插件
echo      Open Settings: Tools -^> Options -^> Plugins
echo   3. 启用 "TS3 中文翻译插件"
echo      Enable "TS3 Chinese Translator Plugin"
echo   4. 重启 TeamSpeak 3（如果需要）
echo      Restart TeamSpeak 3 (if needed)
echo.
echo 使用命令测试：
echo Test with command:
echo   /translate test Hello world
echo.
pause

