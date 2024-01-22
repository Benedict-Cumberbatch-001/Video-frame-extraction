@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

REM 提示用户输入每秒抽取的帧数
set /p "frames=please input number of frames of onsecond: "

REM 提示用户拖入视频文件
set /p "video_file=请将视频文件拖入这个窗口: "

REM 创建存放帧的文件夹
set "output_folder=%~n1_frames"

REM 删除已有的文件夹
rmdir /s /q "!output_folder!" 2>nul

REM 创建新的文件夹
mkdir "!output_folder!"

REM 使用ffmpeg抽取帧
ffmpeg -i "!video_file!" -vf fps=!frames! "!output_folder!\frame%%03d.png"

echo 抽帧完成，帧图像存放在: !output_folder!
pause
