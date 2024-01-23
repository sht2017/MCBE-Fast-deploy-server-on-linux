#作者Stonty
#禁止将该项目用于商业用途！！！
#该项目使用GPL-3.0开源协议

Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"
OS=`uname -s`
VER=1804

Start(){
    clear
    if [ `whoami` = "root" ]
    then
        if [ ${OS} == "Linux"  ]
        then
            source /etc/os-release
            VERSION_NUMBER=$(echo "$VERSION_ID" | sed 's/\.//g')
            case $ID in
                ubuntu)
                    case $VERSION_NUMBER in
                        $VER)
                            sleep 3
                            ChooseLanguage
                            ;;
                        *)
                            echo -e ${Red_font_prefix}"Only can use on Ubuntu 18.04 or higher!!!"${Font_color_suffix}
                            echo -e ${Red_font_prefix}"只能在Ubuntu18.04及以上版本使用！！！"${Font_color_suffix}
                            exit
                            ;;
                    esac
                    ;;
                *)
                    echo -e ${Red_font_prefix}"Only can use on Ubuntu 18.04 or higher!!!"${Font_color_suffix}
                    echo -e ${Red_font_prefix}"只能在Ubuntu18.04及以上版本使用！！！"${Font_color_suffix}
                    exit
                    ;;
            esac
        fi
    else
        echo -e ${Red_font_prefix}"Please run the script as root or use command sudo!!!"${Font_color_suffix}
        echo -e ${Red_font_prefix}"请使用root用户或以sudo命令执行此脚本！！！"${Font_color_suffix}
        exit
    fi
}

ChooseLanguage(){
    clear
    echo -e ${Green_font_prefix}"Choose your common language"${Font_color_suffix}
    echo "1.English"
    echo "2.中文"
    echo "3.Exit/退出"
    read -n1
    case $REPLY in
        1)
            clear
            echo not support
            ;;
        2)
            ChineseInformation
            ;;
        3)
            clear
            exit
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"Error Input/选择错误"${Font_color_suffix}
            sleep 2
            ChooseLanguage
        ;;
    esac
}

ChineseSetPath(){
    clear
    echo "请输入想要安装的/已安装的服务器路径（如 /root/server）"
    read ServerPath
    clear
    
    echo "您输入的路径是"${ServerPath}
    echo "是否无误？"
    echo "1.是"
    echo "2.否"
    read -n1
    case $REPLY in
        1)
            ChineseAutomatedReadyForDeploymentServer
            ;;
        2)
            ChineseSetPath
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            ChineseSetPath
            ;;
    esac
}

ChineseInformation(){
    clear
    echo "欢迎使用本脚本"
    sleep 2
    
    ChineseUI
}

ChineseUI(){
    clear
    echo -e ${Green_font_prefix}"请选择要进行的操作"${Font_color_suffix}
    echo "1.快速部署开服包"
    echo "2.安装/更新管理组件"
    echo "3.启用/停止管理组件自动更新"
    echo "4.卸载管理组件"
    echo "5.Exit"
    read -n1
    case $REPLY in
        1)
            ChineseSetPath
            ;;
        2)
            ChineseInstallManagementTools
            ;;
        3)
            ChineseSetManagementToolsAutoUpdate
            ;;
        4)
            ChineseUninstallManagementTools
            ;;
        5)
            clear
            exit
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            ChineseUI
            ;;
    esac
}

ChineseAutomatedGetLinkAndVision(){
    clear
    echo -e ${Green_font_prefix}"正在从服务器上获取源地址及版本..."${Font_color_suffix}
    wget -O Info.tmp https://www.minecraft.net/en-us/download/server/bedrock/ >/dev/null 2>&1
    
    echo -e ${Green_font_prefix}"获取基础类信息完毕！开始解析..."${Font_color_suffix}
    grep -n "serverBedrockLinux" ./Info.tmp > ./Info.tmp1
    echo $(sed -n "$(cut -f1 -d":" ./Info.tmp1)p" ./Info.tmp) > ./Info.tmp
    Link=$(cut -f2 -d"\"" ./Info.tmp)
    echo ${Link} > ./Info.tmp
    echo $(cut -f4 -d"-" ./Info.tmp) > ./Info.tmp
    Version=$(sed 's/.zip//g' ./Info.tmp)
    echo ${Version} > ./Info.tmp
    sleep 5
    
    echo -e ${Green_font_prefix}"解析成功,准备部署..."${Font_color_suffix}
    echo "源地址："${Link}
    echo "版本："${Version}
    rm -rf ./Info.tmp*
    sleep 3
    
    ChineseAutomatedStartDeploymentServer
}

ChineseAutomatedReadyForDeploymentServer(){
    clear
    echo -e ${Green_font_prefix}"更新中..."${Font_color_suffix}
    sleep 1
    apt-get update -y
    echo -e ${Green_font_prefix}"更新完毕"${Font_color_suffix}
    sleep 2
    clear
    
    echo -e ${Green_font_prefix}"升级中(如果在提示升级完毕出现任何界面回车即可)..."${Font_color_suffix}
    sleep 3
    apt-get upgrade -y
    echo -e ${Green_font_prefix}"升级完毕"${Font_color_suffix}
    sleep 2
    clear
    
    echo -e ${Green_font_prefix}"正在安装一些必要的包"${Font_color_suffix}
    sleep 1
    apt-get install curl screen zip unzip openssl -y
    echo -e ${Green_font_prefix}"安装完毕"${Font_color_suffix}
    sleep 2
    
    ChineseAutomatedGetLinkAndVision
}

ChineseAutomatedStartDeploymentServer(){
    clear
    echo -e ${Green_font_prefix}"开始部署"${Font_color_suffix}
    echo -e ${Green_font_prefix}"Version："${Version}${Font_color_suffix}
    sleep 1
    mkdir ${ServerPath}
    cd ${ServerPath}
    wget -O bedrock-server-${Version}.zip ${Link}
    unzip -o bedrock-server-${Version}.zip
    clear
    echo -e ${Green_font_prefix}"部署完毕"${Font_color_suffix}
    sleep 5
    
    ChineseUI
}

ChineseInstallManagementTools(){
    clear
    echo "开始安装/更新..."
    cd ~
    wget -O mcbes-tool.sh -P ~/ https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/mcbes-tool.sh >/dev/null 2>&1
    chmod 777 ~/mcbes-tool.sh
    rm -rf /usr/local/bin/mcbes-tool*
    mv -f ~/mcbes-tool.sh /usr/local/bin/mcbes-tool.sh
    ln -s /usr/local/bin/mcbes-tool.sh /usr/local/bin/mcbes-tool
    echo "安装完成，以后键入mcbes-tool即可使用哦~"
    sleep 3
    mcbes-tool
}

ChineseSetManagementToolsAutoUpdate(){
    clear
    CrontabInfo=$(cat /etc/crontab)
    SerachInfo='mcbes-tool'
    CrontabCommand='0 * * * * root cd ~ && wget -O mcbes-tool.sh -P ~/ https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/mcbes-tool.sh && chmod 777 ~/mcbes-tool.sh && mv -f ~/mcbes-tool.sh /usr/local/bin/mcbes-tool.sh'
    ExistTest=$(echo "${CrontabInfo}" | grep "${SerachInfo}")
    case $ExistTest in
        "")
            echo "正在启用自动更新"
            echo "${CrontabCommand}" >> /etc/crontab
            sleep 2
            echo "已启用"
            sleep 3
            ChineseUI
            ;;
        *)
            echo "正在停止自动更新"
            sed -i "/${SerachInfo}/d" /etc/crontab
            sleep 2
            echo "已停止"
            sleep 3
            ChineseUI
            ;;
    esac
}

ChineseUninstallManagementTools(){
    clear
    echo "开始卸载.."
    rm -rf /usr/local/bin/mcbes-tool*
    sleep 3
    echo "卸载完成"
    ChineseUI
}

Start
