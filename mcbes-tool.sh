#作者Stonty
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
            CheckServerIfExist
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

CheckServerIfExist(){
    case $(find $Path -maxdepth 1 -name "bedrock-server-*") in
        "")
            clear
            echo -e ${Red_font_prefix}"您选择的路径下未部署服务器"${Font_color_suffix}
            sleep 2
            SetPath
            ;;
        *)
            cd ${Path}
            CheckServerConfigurationInfoIfExist
            ;;
    esac
}

CheckServerConfigurationInfoIfExist(){
    case $(find . -maxdepth 1 -name ".Server.Configuration.Info") in
        "")
            echo $(echo "Info${PWD##*/}$(date +%Y%m%d%H%M%S%N)"|base64) > ./.Server.Configuration.Info
            CheckServerConfigurationInfoIfExist
            ;;
        *)
            ServerConfigurationInfo=$(echo `cat .Server.Configuration.Info`)
            ServerInfo
            ;;
    esac
}

ServerInfo(){
    clear
    result=$(echo $(screen -list) | grep "${ServerConfigurationInfo}")
    if [[ "$result" != "" ]]
    then
        ServerStatus=on
        Menu
    else
        ServerStatus=off
        Menu
    fi
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
            BeforeCommands
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
    case $ServerStatus in
        on)
            echo "服务器当前已启动 请勿重复启动！"
            sleep 3
            Menu
            ;;
        off)
            screen -dmS ${ServerConfigurationInfo}
            screen -r ${ServerConfigurationInfo} -p 0 -X stuff "LD_LIBRARY_PATH=. ./bedrock_server"
            screen -r ${ServerConfigurationInfo} -p 0 -X stuff $'\n'
            ServerStatus=on
            echo "已启动"
            sleep 3
            Menu
            ;;
    esac
}

StopServer(){
    clear
    case $ServerStatus in
        on)
            screen -r ${ServerConfigurationInfo} -p 0 -X stuff "stop"
            screen -r ${ServerConfigurationInfo} -p 0 -X stuff $'\n'
            sleep 1
            screen -S ${ServerConfigurationInfo} -X quit
            ServerStatus=off
            echo "已停止"
            sleep 3
            Menu
            ;;
        off)
            echo "服务器未启动！"
            sleep 3
            Menu
            ;;
    esac
}

SetServerOptions(){
    clear
    case $ServerStatus in
        on)
            echo "请停止服务器后再修改服务器配置"
            sleep 3
            Menu
            ;;
        off)
            SetServerOptionsPage1
            ;;
    esac
}

SetServerOptionsPage1(){
    clear
    echo -e ${Green_font_prefix}"服务器配置[第1页 共3页]"${Font_color_suffix}
    echo "1.游戏模式"
    echo "2.游戏难度"
    echo "3.新玩家权限"
    echo "4.服务器名称（暂未开放）"
    echo "5.最大玩家数（默认10人）"
    echo "6.IPv4端口（默认19132）"
    echo "7.IPv6端口（默认19133）"
    echo "8.地图名称（暂未开放）"
    echo "9.[下一页]"
    echo "[回车退出]"
    echo -e ${Green_font_prefix}"服务器配置[第1页 共3页]"${Font_color_suffix}
    read -n1
    case $REPLY in
        1)
            Gamemode
            ;;
        2)
            Difficulty
            ;;
        3)
            DefaultPlayerPermissionLevel
            ;;
        4)
            SetServerOptionsPage1NotAllowed
            ;;
        5)
            SetServerOptionsPage1NotAllowed
            ;;
        6)
            SetServerOptionsPage1NotAllowed
            ;;
        7)
            SetServerOptionsPage1NotAllowed
            ;;
        8)
            SetServerOptionsPage1NotAllowed
            ;;
        9)
            SetServerOptionsPage2
            ;;
        "")
            Menu
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            SetServerOptionsPage1
            ;;
    esac
    exit
}

SetServerOptionsPage1NotAllowed(){
            clear
            echo "暂未开放！！！"
            sleep 3
            SetServerOptionsPage1
}

SetServerOptionsPage2(){
    clear
    echo -e ${Green_font_prefix}"服务器配置[第2页 共3页]"${Font_color_suffix}
    echo "1.[上一页]"
    echo "2.地图种子（暂未开放）"
    echo "3.Xbox身份验证"
    echo "4.白名单模式（暂未开放）"
    echo "5.允许作弊"
    echo "6.最大可见距离（暂未开放）"
    echo "7.允许最长挂机时间（暂未开放）"
    echo "8.最大线程（暂未开放）"
    echo "9.[下一页]"
    echo "[回车退出]"
    echo -e ${Green_font_prefix}"服务器配置[第2页 共3页]"${Font_color_suffix}
    read -n1
    case $REPLY in
        1)
            SetServerOptionsPage1
            ;;
        2)
            SetServerOptionsPage2NotAllowed
            ;;
        3)
            OnlineMode
            ;;
        4)
            SetServerOptionsPage2NotAllowed
            ;;
        5)
            AllowCheats
            ;;
        6)
            SetServerOptionsPage2NotAllowed
            ;;
        7)
            SetServerOptionsPage2NotAllowed
            ;;
        8)
            SetServerOptionsPage2NotAllowed
            ;;
        9)
            SetServerOptionsPage3
            ;;
        "")
            Menu
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            SetServerOptionsPage2
            ;;
    esac
    exit
}

SetServerOptionsPage2NotAllowed(){
            clear
            echo "暂未开放！！！"
            sleep 3
            SetServerOptionsPage2
}

SetServerOptionsPage3(){
    clear
    echo -e ${Green_font_prefix}"服务器配置[第3页 共3页]"${Font_color_suffix}
    echo "1.[上一页]"
    echo "2.区块加载距离（暂未开放）"
    echo "3.强制载入资源包（暂未开放）"
    echo "[回车退出]"
    echo -e ${Green_font_prefix}"服务器配置[第3页 共3页]"${Font_color_suffix}
    read -n1
    case $REPLY in
        1)
            SetServerOptionsPage2
            ;;
        2)
            SetServerOptionsPage3NotAllowed
            ;;
        3)
            SetServerOptionsPage3NotAllowed
            ;;
        "")
            Menu
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            SetServerOptionsPage3
            ;;
    esac
    exit
}

SetServerOptionsPage3NotAllowed(){
            clear
            echo "暂未开放！！！"
            sleep 3
            SetServerOptionsPage3
}

BeforeCommands(){
    clear
    case $ServerStatus in
        on)
            Commands
            ;;
        off)
            echo "请启动服务器后再发送指令"
            sleep 3
            Menu
            ;;
    esac
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
    case $(find ~/ -maxdepth 1 -name ".help.list") in
        "")
            wget -O .help.list -P ~  https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/help.list
            sleep 10
            CommandsHelp
            for ((i=1; i<=10; i ++))
            do
                case $(find ~/ -maxdepth 1 -name ".help.list") in
                    "")
            	        sleep 1
                        ;;
                    *)
                        CommandsHelp
                        ;;
                esac
            done
            ;;
        *)
            cat ~/.help.list
            echo "[任意键返回上级菜单]"
            read
            case $REPLY in
                *)
                    Commands
                    ;;
            esac
            ;;
    esac
}

#已通过unit-test 请勿更改
AllowCheats(){
    clear
    echo -e ${Green_font_prefix}"请选择是否开启作弊"${Font_color_suffix}
    echo "1.开启"
    echo "2.关闭"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            grep -n "allow-cheats=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c allow-cheats=true" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage2
            ;;
        2)
            grep -n "allow-cheats=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c allow-cheats=false" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage2
            ;;
        "")
            clear
            SetServerOptionsPage2
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            AllowCheats
            ;;
    esac
}

#已通过unit-test 请勿更改
DefaultPlayerPermissionLevel(){
    clear
    echo -e ${Green_font_prefix}"请选择新玩家权限"${Font_color_suffix}
    echo "1.访客"
    echo "2.成员"
    echo "3.管理员"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            grep -n "default-player-permission-level=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c default-player-permission-level=visitor" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        2)
            grep -n "default-player-permission-level=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c default-player-permission-level=member" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        3)
            grep -n "default-player-permission-level=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c default-player-permission-level=operator" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        "")
            clear
            SetServerOptionsPage1
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            DefaultPlayerPermissionLevel
            ;;
    esac
}

#已通过unit-test 请勿更改
Difficulty(){
    clear
    echo -e ${Green_font_prefix}"请选择游戏难度"${Font_color_suffix}
    echo "1.和平"
    echo "2.简单"
    echo "3.一般"
    echo "4.困难"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            grep -n "difficulty=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c difficulty=peaceful" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        2)
            grep -n "difficulty=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c difficulty=easy" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        3)
            grep -n "difficulty=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c difficulty=normal" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        4)
            grep -n "difficulty=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c difficulty=hard" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        "")
            clear
            SetServerOptionsPage1
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            Difficulty
            ;;
    esac
}

#已通过unit-test 请勿更改
Gamemode(){
    clear
    echo -e ${Green_font_prefix}"请选择游戏模式"${Font_color_suffix}
    echo "1.生存模式"
    echo "2.创造模式"
    echo "3.冒险模式"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            grep -n "gamemode=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c gamemode=survival" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        2)
            grep -n "gamemode=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c gamemode=creative" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        3)
            grep -n "gamemode=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c gamemode=adventure" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage1
            ;;
        "")
            clear
            SetServerOptionsPage1
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            Gamemode
            ;;
    esac
}

#已通过unit-test 请勿更改
OnlineMode(){
    clear
    echo -e ${Green_font_prefix}"请选择Xbox身份验证模式"${Font_color_suffix}
    echo "1.开启"
    echo "2.关闭"
    echo "[回车退出]"
    read -n1
    case $REPLY in
        1)
            grep -n "online-mode=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c online-mode=true" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage2
            ;;
        2)
            grep -n "online-mode=" ./server.properties > ./server.properties.tmp
            sed -i "$(cut -f1 -d":" ./server.properties.tmp)c online-mode=false" ./server.properties
            rm -rf ./server.properties.tmp
            SetServerOptionsPage2
            ;;
        "")
            clear
            SetServerOptionsPage2
            ;;
        *)
            clear
            echo -e ${Red_font_prefix}"选择有误"${Font_color_suffix}
            sleep 2
            OnlineMode
            ;;
    esac
}

SetPath
