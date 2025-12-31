@echo off
REM 卸载 TeamSpeak 3 插件
REM Uninstall TeamSpeak 3 plugin
chcp 65001 >nul 2>&1

echo ========================================
echo TS3 中文翻译插件 - 卸载
echo TS3 Chinese Translator - Uninstall
echo ========================================
echo.

set "TS3_PLUGIN_DIR=%APPDATA%\TS3Client\plugins"

echo [信息] 插件目录：%TS3_PLUGIN_DIR%
echo [Info] Plugin directory: %TS3_PLUGIN_DIR%
echo.

if not exist "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll" (
    echo [信息] 插件未安装
    echo [Info] Plugin is not installed
    goto :end
)

echo [警告] 确认卸载插件？
echo [Warning] Confirm uninstall?
choice /C YN /M "Y=是/Yes, N=否/No"
if errorlevel 2 goto :end

del "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll"
if errorlevel 1 (
    echo [错误] 卸载失败
    echo [Error] Uninstall failed
    echo.
    echo 可能的原因：
    echo - TeamSpeak 3 正在运行（请先关闭）
    echo   TeamSpeak 3 is running (please close it first)
    goto :end
)

echo [成功] 插件已卸载
echo [Success] Plugin uninstalled
echo.

REM Remove backup if exists
if exist "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll.backup" (
    echo [信息] 发现备份文件，是否删除？
    echo [Info] Backup file found, delete it?
    choice /C YN /M "Y=是/Yes, N=否/No"
    if not errorlevel 2 (
        del "%TS3_PLUGIN_DIR%\ts3_translator_plugin.dll.backup"
        echo [成功] 备份文件已删除
        echo [Success] Backup file deleted
    )
)
echo.

:end
pause
