#作者John Stonty
#禁止将该项目用于商业用途！！！
#该项目使用GPL-3.0开源协议

Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"

SetPath(){
    clear
    echo "请输入已安装的服务器路径（如 /root/server）"
    read
    clear
    Path="$REPLY"
    
    echo "您输入的路径是"${Path}
    echo "是否无误？"
    echo "1.是"
    echo "2.否"
    read -n1
    case $REPLY in
        1)
            cd ${Path}
            Menu
            ;;
        2)
            SetPath
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            SetPath
            ;;
    esac
}

Menu(){
    clear
    echo -e ${Green_font_prefix}"请选择要进行的操作"${Font_color_suffix}
    echo "1.启动服务器"
    echo "2.停止服务器"
    echo "3.服务器配置"
    echo "4.服务器指令"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            StartServer
            ;;
        2)
            StopServer
            ;;
        3)
            SetServerOptions
            ;;
        4)
            Commands
            ;;
        "")
            clear
            exit
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            Menu
            ;;
    esac
}


StartServer(){
    clear
    result=$(echo $(screen -list) | grep "Be-server")
    if [[ "$result" != "" ]]
    then
        echo "服务器当前已启动 请勿重复启动！"
        sleep 3
        Menu
    else
        screen -dmS Be-server
        screen -r Be-server -p 0 -X stuff "LD_LIBRARY_PATH=. ./bedrock_server"
        screen -r Be-server -p 0 -X stuff $'\n'
        echo "已启动"
        sleep 3
        Menu
    fi
}

StopServer(){
    clear
    screen -r Be-server -p 0 -X stuff "stop"
    screen -r Be-server -p 0 -X stuff $'\n'
    sleep 1
    screen -S Be-server -X quit
    echo "已停止"
    sleep 3
    Menu
}

SetServerOptions(){
    clear
    exit
}

Commands(){
    clear
    echo -e ${Green_font_prefix}"请选择要进行的操作"${Font_color_suffix}
    echo "1.输（注）入指令"
    echo "2.帮助"
    echo "[回车返回上级菜单]"
    read -n1
    case $REPLY in
        1)
            CommandsInput
            ;;
        2)
            CommandsHelp
            ;;
        "")
            Menu
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            Commands
            ;;
    esac
}

CommandsInput(){
    clear
    echo -e ${Green_font_prefix}"请选择注入的指令"${Font_color_suffix}
    echo "1.清空生物"
    echo "2.清空掉落物"
    echo "3.自定义指令"
    echo "[回车返回上级菜单]"
    read -n1
    case $REPLY in
        1)
            echo "清空生物成功"
            screen -r Be-server -p 0 -X stuff "kill @e[type=!player,type=!item]" >/dev/null 2>&1
            screen -r Be-server -p 0 -X stuff $'\n' >/dev/null 2>&1
            sleep 1
            CommandsInput
            ;;
        2)
            echo "清空掉落物成功"
            screen -r Be-server -p 0 -X stuff "kill @e[type=item,type=xb_orb]" >/dev/null 2>&1
            screen -r Be-server -p 0 -X stuff $'\n' >/dev/null 2>&1
            sleep 1
            CommandsInput
            ;;
        3)
            CommandsCustomInput
            ;;
        "")
            Commands
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            CommandsInput
            ;;
    esac
}

CommandsCustomInput(){
    clear
    echo "请输入要注入的指令（如 kill @e）（如果无效则为无法执行，请检查拼写和作用目标）（fill类指令可能会出现在世界外的bug从而导致无解，请作用在可用区块内）"
    read
    clear
    CommandInputFinished="$REPLY"
    echo "您输入的指令是"${CommandInputFinished}
    echo "是否无误？"
    echo "1.是"
    echo "2.否"
    read -n1
    case $REPLY in
        1)
            screen -r Be-server -p 0 -X stuff "${CommandInputFinished}" >/dev/null 2>&1
            screen -r Be-server -p 0 -X stuff $'\n' >/dev/null 2>&1
            AfterCommandsCustomInputed
            ;;
        2)
            CommandsCustomInput
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            CommandsCustomInput
            ;;
    esac  
}

AfterCommandsCustomInputed(){
    clear
    echo "指令"${CommandInputFinished}"已注入完成"
    echo "是否继续注入指令？"
    echo "Y.继续"
    echo "[回车返回上级菜单]"
    read -n1
    case $REPLY in
        y)
            CommandsCustomInput
            ;;
        Y)
            CommandsCustomInput
            ;;
        "")
            CommandsInput
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            AfterCommandsCustomInputed
            ;;
    esac
}

CommandsHelp(){
    clear
    wget -O .help.list -P ~  https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/help.list >/dev/null 2>&1
    cat ~/.help.list
    echo "[任意键返回上级菜单]"
    read
    case $REPLY in
        *)
            Commands
            ;;
    esac
}

SetPath

