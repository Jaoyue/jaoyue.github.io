## Linux中安装ffmpeg

1. 安装ffmpeg: sudo yum install ffmpeg
2. 如果报错没有可用软件包 ffmpeg,按下面方式解决
3. 在CentOS或RHEL系统上使用`yum`安装`ffmpeg`时，如果遇到“没有可用软件包 ffmpeg”的错误，通常是因为默认的YUM存储库中不包含`ffmpeg`。这是因为`ffmpeg`包含一些专利受限的技术，默认的存储库可能不提供这些软件包。

要解决这个问题，你可以通过以下步骤安装`ffmpeg`：

1. **启用EPEL和RPM Fusion存储库**：  
- EPEL（Extra Packages for Enterprise Linux）和RPM Fusion是两个常用的第三方存储库，提供了许多额外的软件包。

首先，安装EPEL存储库：  
  
sudo yum install epel-release  
  
  

然后，安装RPM Fusion存储库：  
  
sudo yum install [https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm](https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm)  
sudo yum install [https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm](https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm)  
  
  

注意：根据你的CentOS/RHEL版本，下载的RPM Fusion存储库URL可能需要调整。例如，对于CentOS 8，你需要使用`el/8`而不是`el/7`。

2. **安装ffmpeg**：  
- 启用上述存储库后，你可以尝试再次安装`ffmpeg`：  
  
sudo yum install ffmpeg ffmpeg-deve  
  
  

3. **验证安装**：  
- 安装完成后，你可以通过以下命令验证`ffmpeg`是否安装成功：  
  
ffmpeg -version  
  
  

如果你仍然遇到问题，请确保你的网络连接正常，并且你的系统可以访问这些存储库的URL。另外，确保你的系统时间和日期是正确的，因为这可能会影响到TLS/SSL连接的建立。

  
  

## shell脚本

|   |
|---|
|#!/bin/bash<br><br># 定义文件路径和临时文件<br><br>BASE_DIR="/data/dbu"<br><br>TEMP_FILE="/data/temp_file.txt"<br><br>LOG_FILE="/data/task_log.txt" # 日志文件路径<br><br>LOCK_FILE="/data/lock.txt" # 锁文件路径<br><br># 读取锁文件内容<br><br>LOCK_STATUS=$(cat "$LOCK_FILE")<br><br># 检查锁状态<br><br>if [ "$LOCK_STATUS" = "true" ]; then<br><br># 如果锁状态为 true，将其改为 false，表示获取锁<br><br>echo "false" > "$LOCK_FILE"<br><br>else<br><br># 如果锁状态为 false，打印提示信息并退出<br><br>echo "获取锁失败, 任务正在执行中"<br><br>exit 1<br><br>fi<br><br># 读取临时文件中的日期<br><br>TARGET_DATE=$(cat "$TEMP_FILE")<br><br># 获取当前日期并计算差异天数<br><br>CURRENT_DATE=$(date +%Y-%m-%d)<br><br>DIFF_DAYS=$(( ($(date -d "$CURRENT_DATE" +%s) - $(date -d "$TARGET_DATE" +%s)) / 86400 ))<br><br># 检查是否超过90天<br><br>if [ "$DIFF_DAYS" -le 90 ]; then<br><br>echo "日期差小于或等于90天，不需要压缩"<br><br># 释放锁<br><br>echo "true" > "$LOCK_FILE"<br><br>exit 0<br><br>fi<br><br># 记录任务开始时间<br><br>START_TIME=$(date '+%Y-%m-%d %H:%M:%S')<br><br># 遍历css, asm, store等文件夹<br><br>for DIR in "$BASE_DIR"/*; do<br><br># 检查是否为目录<br><br>if [ -d "$DIR/$TARGET_DATE" ]; then<br><br># 压缩视频文件<br><br>find "$DIR/$TARGET_DATE" -type f \( -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mov" \) -exec bash -c '<br><br>input_file="$1"<br><br>temp_file="${input_file%.*}_temp.mp4"<br><br>ffmpeg -y -i "$input_file" -vf "scale=trunc(oh*a/2)*2:min(720\,ih)" -vcodec libx264 -crf 28 "$temp_file" && mv "$temp_file" "$input_file"<br><br>' _ {} \;<br><br># 压缩图片文件<br><br>find "$DIR/$TARGET_DATE" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec bash -c '<br><br>input_file="$1"<br><br>temp_file="${input_file%.*}_temp.jpg"<br><br>ffmpeg -y -i "$input_file" -vf "scale=iw/2:ih/2" -q:v 2 "$temp_file" && mv "$temp_file" "$input_file"<br><br>' _ {} \;<br><br>fi<br><br>done<br><br># 更新临时文件中的日期<br><br>NEW_DATE=$(date -d "$TARGET_DATE + 1 day" +%Y-%m-%d)<br><br>echo "$NEW_DATE" > "$TEMP_FILE"<br><br># 记录任务结束时间<br><br>END_TIME=$(date '+%Y-%m-%d %H:%M:%S')<br><br># 将任务执行信息追加到日志文件<br><br>echo "任务执行日期: $TARGET_DATE, 开始时间: $START_TIME, 结束时间: $END_TIME" >> "$LOG_FILE"<br><br># 释放锁<br><br>echo "true" > "$LOCK_FILE"<br><br>echo "压缩任务完成，临时文件日期已更新为: $NEW_DATE"|

|       |              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ----- | ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **AI提问话术参考** | **现在Linux文件服务器中的空间不足, 需要使用ffmpeg对文件中的视频文件和图片文件进行压缩,文件存放路径/data/dbu/下有css,asm,store等多个文件夹,每个文件夹下有日期格式的文件夹,日期格式为2024-12-26,日期文件夹下存放具体的文件,例如m.jpg,s.mp4  <br>****请你安装需要的工具,并编写一个shell脚本, 这个脚本要读取一个临时文本文件,文件中记载了需要压缩的文件的时间, 例如:2024-12-25, 判断时间距离当前日期大于90天, 就将css,asm,store等几个文件夹下2024-12-25的文件夹中的视频和图片进行压缩并置换,视频格式有mp4,avi,mov,图片格式有jpg,png,jpeg,压缩后文件的格式不要改变,压缩任务完成后将临时文件的时间改为2024-12-26**<br><br>**修改一下这个脚本, 在脚本开始执行时读取lock.txt文件,内容是true或者false, 如果是true就将内容改为false, 然后继续执行下面的代码, 并在执行完毕后将内容改为true, 如果读取到的是false, 就打印"获取锁失败, 任务正在执行中", 然后结束** |
| 2     | Linux环境示例    | ![](https://cdn.nlark.com/yuque/0/2025/png/29172728/1740117232447-5918359f-4ba1-4c2f-a090-d5a57855f672.png)<br><br>compress_files.sh 执行脚本<br><br>temp_file.txt 日期文件<br><br>task_log.txt 日志文件<br><br>lock.txt 锁文件<br><br>![](https://cdn.nlark.com/yuque/0/2025/png/29172728/1739167526736-39cd6d1c-00fe-4a6e-9c17-0e6bb02350c5.png)<br><br>文件夹路径示例, 根据实际情况修改具体文件路径                                                                                                                                                                            |

## 赋予shell脚本执行权限: chmod +x compress_files.sh

去除脚本中的换行符: sed -i 's/\r$//' compress_files.sh

单次执行脚本: sh compress_files.sh

## 定时任务执行

要将上述脚本 `compress_files.sh` 设置为每 6 小时执行一次的定时任务，可以使用 `cron`，这是一个基于时间的任务调度程序。以下是如何设置的步骤：

### 1. 确保脚本可执行

首先，确保你的脚本 `compress_files.sh` 是可执行的。你可以通过以下命令赋予执行权限：

  
chmod +x /path/to/compress_files.sh (替换实际路径)  
  
  

将 `/path/to/compress_files.sh` 替换为脚本的实际路径。

### 2. 编辑 Crontab

使用 `crontab` 命令来编辑当前用户的定时任务：

  
crontab -e  
  
  

这将打开一个文本编辑器，通常是 `vi` 或 `nano`，用于编辑 `crontab` 文件。

### 3. 添加定时任务

在 `crontab` 文件中输入 i 添加以下行，以便每 6 小时运行一次脚本(cron规则根据实际需求设置)：

  
0 */6 * * * /path/to/compress_files.sh  
  
  

### 解释：

- `0` 表示在每个小时的第 0 分钟执行任务。  
- `*/6` 表示每 6 小时执行一次任务。  
- `* * *` 分别表示每天、每月和每周的所有天。  
- `/path/to/compress_files.sh` 是你的脚本的完整路径。

### 4. 保存并退出

在编辑器中保存更改并退出。对于 `vi`，你可以按 `Esc` 键，然后输入 `:wq` 并按回车。对于 `nano`，按 `Ctrl + O` 保存，然后 `Ctrl + X` 退出。

### 5. 验证 Crontab

可以通过以下命令查看当前用户的 `crontab` 任务，确保任务已正确添加：

  
crontab -l  
  
  

这将列出所有当前用户的定时任务，包括你刚刚添加的任务。

### 注意事项

- 确保脚本路径正确，并且脚本内的路径也正确。  
- 确保脚本中所有需要的命令（如 `ffmpeg`）在环境变量 `PATH` 中可用，或者在脚本中使用完整路径。  
- 如果脚本需要访问特定权限的文件或目录，请确保定时任务以适当的用户身份运行。