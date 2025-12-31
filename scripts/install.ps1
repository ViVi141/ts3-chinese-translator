# TS3 翻译插件安装脚本 (PowerShell)
# TS3 Translator Plugin Installer (PowerShell)
# GitHub: https://github.com/ViVi141/ts3-chinese-translator
# Author: ViVi141 (747384120@qq.com)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TS3 中文翻译插件安装程序" -ForegroundColor Cyan
Write-Host "TS3 Chinese Translator Plugin Installer" -ForegroundColor Cyan
Write-Host "GitHub: https://github.com/ViVi141/ts3-chinese-translator" -ForegroundColor Cyan
Write-Host "Author: ViVi141" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if plugin DLL exists
if (-not (Test-Path "dist\ts3_translator_plugin.dll")) {
    Write-Host "[错误] 未找到插件文件 dist\ts3_translator_plugin.dll" -ForegroundColor Red
    Write-Host "[Error] Plugin file dist\ts3_translator_plugin.dll not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先编译插件：" -ForegroundColor Yellow
    Write-Host "Please compile the plugin first:" -ForegroundColor Yellow
    Write-Host "  1. 打开 MSYS2 MinGW64 终端" -ForegroundColor Yellow
    Write-Host "     Open MSYS2 MinGW64 terminal" -ForegroundColor Yellow
    Write-Host "  2. 运行: scripts\build_msys2.sh" -ForegroundColor Yellow
    Write-Host "     Run: scripts\build_msys2.sh" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按 Enter 键退出 / Press Enter to exit"
    exit 1
}

Write-Host "[信息] 找到插件文件" -ForegroundColor Green
Write-Host "[Info] Plugin file found" -ForegroundColor Green
Write-Host ""

# Get TeamSpeak 3 plugins directory
$pluginDir = Join-Path $env:APPDATA "TS3Client\plugins"

# Check if directory exists
if (-not (Test-Path $pluginDir)) {
    Write-Host "[警告] TeamSpeak 3 插件目录不存在" -ForegroundColor Yellow
    Write-Host "[Warning] TeamSpeak 3 plugins directory does not exist" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "尝试创建目录: $pluginDir" -ForegroundColor Yellow
    Write-Host "Attempting to create directory: $pluginDir" -ForegroundColor Yellow
    
    try {
        New-Item -ItemType Directory -Path $pluginDir -Force | Out-Null
        Write-Host "[成功] 目录创建成功" -ForegroundColor Green
        Write-Host "[Success] Directory created successfully" -ForegroundColor Green
        Write-Host ""
    } catch {
        Write-Host "[错误] 无法创建插件目录" -ForegroundColor Red
        Write-Host "[Error] Cannot create plugins directory" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        Read-Host "按 Enter 键退出 / Press Enter to exit"
        exit 1
    }
}

Write-Host "[信息] 插件目录: $pluginDir" -ForegroundColor Cyan
Write-Host "[Info] Plugin directory: $pluginDir" -ForegroundColor Cyan
Write-Host ""

# Check if plugin is already installed
$pluginPath = Join-Path $pluginDir "ts3_translator_plugin.dll"
if (Test-Path $pluginPath) {
    Write-Host "[信息] 检测到已安装的插件" -ForegroundColor Yellow
    Write-Host "[Info] Existing plugin installation detected" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "选项：" -ForegroundColor Cyan
    Write-Host "Options:" -ForegroundColor Cyan
    Write-Host "  1. 覆盖安装 (Overwrite)" -ForegroundColor White
    Write-Host "  2. 备份后安装 (Backup and install)" -ForegroundColor White
    Write-Host "  3. 取消 (Cancel)" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "请选择 (1-3) / Please choose (1-3)"
    
    if ($choice -eq "1") {
        Write-Host "[信息] 覆盖安装..." -ForegroundColor Yellow
        Write-Host "[Info] Overwriting..." -ForegroundColor Yellow
    } elseif ($choice -eq "2") {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupFile = "$pluginPath.backup.$timestamp"
        try {
            Copy-Item $pluginPath $backupFile -Force
            Write-Host "[成功] 已备份到: $backupFile" -ForegroundColor Green
            Write-Host "[Success] Backed up to: $backupFile" -ForegroundColor Green
        } catch {
            Write-Host "[警告] 备份失败，继续安装..." -ForegroundColor Yellow
            Write-Host "[Warning] Backup failed, continuing installation..." -ForegroundColor Yellow
        }
    } else {
        Write-Host "[信息] 安装已取消" -ForegroundColor Yellow
        Write-Host "[Info] Installation cancelled" -ForegroundColor Yellow
        Read-Host "按 Enter 键退出 / Press Enter to exit"
        exit 0
    }
    Write-Host ""
}

# Copy plugin file
Write-Host "[信息] 正在复制插件文件..." -ForegroundColor Cyan
Write-Host "[Info] Copying plugin file..." -ForegroundColor Cyan

try {
    Copy-Item "dist\ts3_translator_plugin.dll" $pluginPath -Force
    Write-Host "[成功] 插件安装成功！" -ForegroundColor Green
    Write-Host "[Success] Plugin installed successfully!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "[错误] 复制失败！" -ForegroundColor Red
    Write-Host "[Error] Copy failed!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "提示：尝试以管理员身份运行此脚本" -ForegroundColor Yellow
    Write-Host "Tip: Try running this script as administrator" -ForegroundColor Yellow
    Read-Host "按 Enter 键退出 / Press Enter to exit"
    exit 1
}

# Verify installation
if (Test-Path $pluginPath) {
    $fileInfo = Get-Item $pluginPath
    Write-Host "[验证] 插件文件已存在于插件目录" -ForegroundColor Green
    Write-Host "[Verify] Plugin file exists in plugins directory" -ForegroundColor Green
    Write-Host "  文件大小: $($fileInfo.Length) 字节" -ForegroundColor Cyan
    Write-Host "  File size: $($fileInfo.Length) bytes" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "[警告] 验证失败，但文件可能已复制" -ForegroundColor Yellow
    Write-Host "[Warning] Verification failed, but file may have been copied" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "安装完成！" -ForegroundColor Green
Write-Host "Installation completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "下一步：" -ForegroundColor Cyan
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. 启动 TeamSpeak 3 客户端" -ForegroundColor White
Write-Host "     Start TeamSpeak 3 client" -ForegroundColor White
Write-Host "  2. 打开设置: 工具 -> 选项 -> 插件" -ForegroundColor White
Write-Host "     Open Settings: Tools -> Options -> Plugins" -ForegroundColor White
Write-Host "  3. 启用 'TS3 中文翻译插件'" -ForegroundColor White
Write-Host "     Enable 'TS3 Chinese Translator Plugin'" -ForegroundColor White
Write-Host "  4. 重启 TeamSpeak 3（如果需要）" -ForegroundColor White
Write-Host "     Restart TeamSpeak 3 (if needed)" -ForegroundColor White
Write-Host ""
Write-Host "使用命令测试：" -ForegroundColor Cyan
Write-Host "Test with command:" -ForegroundColor Cyan
Write-Host "  /translate test Hello world" -ForegroundColor Yellow
Write-Host ""
Read-Host "按 Enter 键退出 / Press Enter to exit"

