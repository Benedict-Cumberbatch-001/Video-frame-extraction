@echo off
setlocal enabledelayedexpansion

echo ==================================================
echo   欢迎使用视频帧抽取工具！有任何问题请咨询咸鱼客服~
echo ==================================================

REM 1. 获取抽帧频率
set /p "frames=请输入每秒抽取的帧数 (例如 1 或 0.5): "

REM 2. 获取文件路径
set "video_input="
set /p "video_input=请将视频文件拖入此窗口并按回车: "

REM 如果用户没有输入，直接退出
if "!video_input!"=="" (
    echo [错误] 未检测到文件路径！
    pause
    exit
)

REM 清理路径中的双引号
set "video_file=!video_input:"=!"

REM 3. 提取文件名作为文件夹名
for %%A in ("!video_file!") do (
    set "file_name=%%~nA"
)
set "output_folder=!file_name!_frames"

REM 4. 准备存放目录
if exist "!output_folder!" (
    rmdir /s /q "!output_folder!"
)
mkdir "!output_folder!"

REM 5. 调用 FFmpeg
echo.
echo 正在抽取 [!file_name!] 的帧，请稍候...
ffmpeg -i "!video_file!" -vf "fps=!frames!" "!output_folder!\frame%%03d.png"

echo.
echo ==================================================
echo   处理完成！图像存放在: !output_folder!
echo ==================================================
pause