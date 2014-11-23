#!/bin/bash

gnome_terminal_conf_dir=/apps/gnome-terminal/profiles

profiles=($(gconftool-2 -R ${gnome_terminal_conf_dir} | fgrep ${gnome_terminal_conf_dir} | cut -d/ -f5 | sed 's/://g'))

if [ 0 -eq ${#profiles[@]} ];then
    echo 错误：没找到配置文件
    exit
fi

for i in ${!profiles[@]}
do
    printf "\t${i}. ${profiles[i]}\n"
done

echo -n "请选择配置文件："
read number

profile_file=${profiles[number]}

if [ -z  $profile_file ];then
    echo 'Error： 瞎搞'
    exit
fi

profile_path=${gnome_terminal_conf_dir}/${profile_file}

####################

# 不使用系统主题
gconftool-2 -s -t bool ${profile_path}/bold_color_same_as_fg false

# 粗体不和文本相同色
gconftool-2 -s -t bool ${profile_path}/use_theme_colors false

# 修改终端背景色
gconftool-2 -s -t string ${profile_path}/background_color "#3F3F3F3F3F3F"

# 修改前景色
gconftool-2 -s -t string ${profile_path}/foreground_color "#DCDCDCDCCCCC"

# 修改粗体颜色
gconftool-2 -s -t string ${profile_path}/bold_color "#E3E3CECEABAB"

# 修改调色板
gconftool-2 -s -t string ${profile_path}/palette "#000000000000:#BCBC83838383:#4E4E9A9A0606:#E0E0CFCF9F9F:#7C7BB8B8BBBB:#DCDC8C8CC3C3:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#CCCC93939393:#8A8AE2E23434:#F0F0DFDFAFAF:#8C8CD0D0D3D3:#DCDC8C8CC3C3:#3434E2E2E2E2:#EEEEEEEEECEC"

echo 'Done.'
