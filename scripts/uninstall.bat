@echo off
REM TS3 翻译插件卸载脚本
REM TS3 Translator Plugin Uninstaller
REM GitHub: https://github.com/ViVi141/ts3-chinese-translator
REM Author: ViVi141 (747384120@qq.com)
chcp 65001 >nul 2>&1

echo ========================================
echo TS3 中文翻译插件卸载程序
echo TS3 Chinese Translator Plugin Uninstaller
echo GitHub: https://github.com/ViVi141/ts3-chinese-translator
echo Author: ViVi141
echo ========================================
echo.

REM Get TeamSpeak 3 plugins directory
set "PLUGIN_DIR=%APPDATA%\TS3Client\plugins"
set "PLUGIN_FILE=%PLUGIN_DIR%\ts3_translator_plugin.dll"

REM Check if plugin is installed
if not exist "%PLUGIN_FILE%" (
    echo [信息] 未找到已安装的插件
    echo [Info] Installed plugin not found
    echo.
    echo 插件可能未安装或已被删除。
    echo Plugin may not be installed or already removed.
    echo.
    pause
    exit /b 0
)

echo [信息] 找到已安装的插件
echo [Info] Installed plugin found
echo [信息] 位置: %PLUGIN_FILE%
echo [Info] Location: %PLUGIN_FILE%
echo.

REM Confirm uninstall
echo 确定要卸载插件吗？
echo Are you sure you want to uninstall the plugin?
echo.
set /p CONFIRM="输入 Y 确认卸载，其他键取消 / Enter Y to confirm, other keys to cancel: "

if /i not "%CONFIRM%"=="Y" (
    echo [信息] 卸载已取消
    echo [Info] Uninstallation cancelled
    pause
    exit /b 0
)

echo.
echo [信息] 正在卸载插件...
echo [Info] Uninstalling plugin...

REM Delete plugin file
del "%PLUGIN_FILE%" >nul 2>&1
if errorlevel 1 (
    echo [错误] 删除失败！请检查权限或手动删除。
    echo [Error] Delete failed! Please check permissions or delete manually.
    echo.
    echo 文件位置: %PLUGIN_FILE%
    echo File location: %PLUGIN_FILE%
    pause
    exit /b 1
)

REM Verify uninstallation
if not exist "%PLUGIN_FILE%" (
    echo [成功] 插件已成功卸载！
    echo [Success] Plugin uninstalled successfully!
    echo.
    echo 提示：请重启 TeamSpeak 3 客户端以完成卸载。
    echo Tip: Please restart TeamSpeak 3 client to complete uninstallation.
) else (
    echo [警告] 文件可能未被完全删除
    echo [Warning] File may not have been completely removed
    echo.
    echo 请手动删除: %PLUGIN_FILE%
    echo Please manually delete: %PLUGIN_FILE%
)

echo.
pause

