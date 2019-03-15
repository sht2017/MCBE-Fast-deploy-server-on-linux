[简体中文](https://github.com/sht2017/MCBE-Fast-deploy-server-on-linux/blob/master/README.md) | English

README
======
该项目使用GPL-3.0开源协议

该项目基于[Mojang官方](https://minecraft.net)给出的[基岩版服务器端软件（早期测试版）](https://minecraft.net/download/server/bedrock/)故仅适用于Ubuntu 18.04+

如果该脚本对您有帮助，希望能够通过Star的方式使该项目获得更多关注

当然 若可以通过捐赠的方式使作者获得支持就更好了

---------------------
#

## 目录
* [如何使用](#如何使用)
* [项目进度](#项目进度)
    * [已完成](#已完成)
    * [未完成](#未完成)
    * [更新日志 (从2019/3/9开始记录)](#更新日志从201939开始记录)
* [问题反馈](#问题反馈)
* [关于作者](#关于作者)
    * [捐献方式](#关于作者)
* [特别鸣谢](#特别鸣谢)

#


## 如何使用
输入以下命令并回车即可
```Shell
wget -O install.sh https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/install.sh && sudo bash install.sh
```
若报错信息中含有wget字样 请输入以下命令并回车后再尝试前一个命令
```Shell
sudo apt-get install wget -y
```
不建议直接 sudo bash install.sh

因为这样将会导致无法获得即时更新和bug修复
#


## 项目进度
#### 已完成
目前该项目提供的解决方案可以做到以下这些
- [x] 部署官方提供的 基岩版服务器端软件（早期测试版）
- [x] 自动获取最新的 基岩版服务器端软件（早期测试版） 版本与地址
- [x] 启动 ~~（需自行进入安装目录并执行LD_LIBRARY_PATH=. ./bedrock_server）~~
- [x] 停止 ~~（需自行stop）~~
- [x] 方便的指令使用功能（部分）
- [x] 自动更新脚本
- [x] 简易地修改配置文件(框架)
- [x] 检查选定目录是否存在服务器
- [x] 同时运行多服务器
- [x] 简易地修改配置文件(部分)
- [x] 手动更新服务端
#### 未完成
目前该项目提供的解决方案暂时无法做到以下这些
- [ ] 暂时不支持英语！！！
- [ ] 简易地修改配置文件(部分)
- [ ] 方便的指令使用功能(部分)
- [ ] 自动更新服务端
- [ ] 获得指令执行反馈
- [ ] ~~自动获取本地安装地址~~ (此部分暂时无解)
- [ ] 自动备份及删除选定的过期备份
- [ ] **远程管理**（可能会新建一个移动管理客户端的项目）
#### 更新日志(从2019/3/9开始记录)  *注：所有带有Update的更新均为功能性更新*
2019/3/14 23:16 **Update**
* 正式加入了手动更新服务端 (mcbes-tool.sh)

2019/3/14 19:24
* Fixed 1 bug (install.sh) (由 @呵呵 反馈)

2019/3/14 19:13
* Fixed 2 bugs (install.sh & mcbes-tool.sh)

2019/3/14 19:02 *非常抱歉 因为我个人的失误导致本次自动更新管理脚本出现严重错误 请使用安装脚本进行覆盖更新以解决*
* Fixed 1 bug (mcbes-tool.sh)

2019/3/14 18:58
* Fixed 1 bug (mcbes-tool.sh)

2019/3/14 18:56
* Fixed 1 bug (mcbes-tool.sh)

2019/3/14 18:53
* 紧急修复由上一次上传导致的bug (mcbes-tool.sh)

2019/3/14 18:46
* Fixed 1 bug (mcbes-tool.sh)
* 预加入了手动更新服务端的部分内容 (mcbes-tool.sh)

2019/3/12 22:36
* Fixed 1 bug (mcbes-tool.sh)

2019/3/12 22:35
* Fixed 1 bug (install.sh)

2019/3/12 23:14 **Update**
* 完成了部分简易地修改配置文件的内容(模式) (mcbes-tool.sh)
* 完成了部分简易地修改配置文件的内容(难度) (mcbes-tool.sh)
* 完成了部分简易地修改配置文件的内容(作弊) (mcbes-tool.sh)
* 完成了部分简易地修改配置文件的内容(权限) (mcbes-tool.sh)
* 完成了部分简易地修改配置文件的内容(验证) (mcbes-tool.sh)

2019/3/12 16:38
* 紧急修复由上一次错误地上传导致的bug (install.sh)

2019/3/12 16:31
* Fixed 1 bug (install.sh)

2019/3/12 16:20 **Update**
* Fixed 6 bugs (install.sh & mcbes-tool.sh)
* 完成了简易地修改配置文件的主体框架 (mcbes-tool.sh)
* 更新了管理脚本会自动检查选定目录是否存在服务器 (mcbes-tool.sh)
* 本次更新允许同时运行多个服务器并管理 (mcbes-tool.sh)
* 更新了查看指令帮助的部分代码 (mcbes-tool.sh)
* 增加了对管理脚本部分限制，避免因用户行为不当导致bug (mcbes-tool.sh)
* 优化部分代码 (install.sh & mcbes-tool.sh)

2019/3/11 22:56
* Fixed 1 bug (install.sh) (由 @ChargeCrystal 反馈)

2019/3/11 20:03 **Update**
* 更新了自动更新脚本的功能 (install.sh)

2019/3/11 20:00
* Fixed 1 bug (mcbes-tool.sh)

2019/3/11 16:22
* 对管理与部署脚本进行了优化 (install.sh & mcbes-tool.sh)
* Fixed 1 bug (install.sh)

2019/3/10 0:14 **Update**
* 完成部分辅助管理系统注入系统（清除生物） (mcbes-tool.sh)
* 完成部分辅助管理系统注入系统（清除掉落物） (mcbes-tool.sh)
* 完成主要管理系统注入系统（自定义指令） (mcbes-tool.sh)

2019/3/9 23:35 **Update**
* 正式加入管理系统的安装和卸载 (install.sh)
* 正式实现通过脚本的启动服务器选项 (mcbes-tool.sh)
* 正式实现通过脚本的停止服务器选项 (mcbes-tool.sh)
* 完成服务器指令的帮助部分 输入（注入）指令将在下个版本完成 (mcbes-tool.sh)

2019/3/9 23:44
* Fixed 2 bugs (install.sh)

2019/3/9 23:30 **Update**
* 完成了管理部分的雏形 (mcbes-tool.sh)

2019/3/9 23:10 **Update**
* 使用case优化了繁琐的if语句 (install.sh)
* 实现自动获取最新版本基岩版服务器端软件(install.sh)
* Fixed 25 bugs (install.sh)
* 调整代码格式，使得易读性大大提升 (install.sh)
* 预加入了下个版本将提供的管理部分 (install.sh)
#


## 问题反馈
可以通过QQ或邮箱联系我，Issues不定期查看
#


## 关于作者
|Author|John Stonty|
|---|---
|E-mail|1844063767@qq.com
|QQ|1844063767
#### 捐献方式
<img src="https://raw.githubusercontent.com/sht2017/MCBE-Fast-deploy-server-on-linux/master/Donation/PayCode.png" width= "450sp" height ="600sp" div align=center>

## 特别鸣谢
