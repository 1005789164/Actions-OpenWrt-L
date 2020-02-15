#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改默认主题
#DEFAULT_THEME="bootstrap_blue"
#sed -i '/option mediaurlbase \/.*\//s/static.*/static\/'$DEFAULT_THEME'/' feeds/luci/modules/luci-base/root/etc/config/luci
#sed -i '2auci set luci.main.mediaurlbase=/luci-static/'$DEFAULT_THEME'' package/default-settings/files/zzz-default-settings

# 修改默认设置文件(移动菜单里面的项到网络存储)
sed -i '/uci commit fstab/a\nsed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/aria2.lua\n \
sed -i \'s/services/nas/g\' /usr/lib/lua/luci/view/aria2/overview_status.htm \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/hd_idle.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/samba.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/minidlna.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/transmission.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/mjpg-streamer.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/p910nd.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/usb_printer.lua \
sed -i \'s/\"services\"/\"nas\"/g\' /usr/lib/lua/luci/controller/xunlei.lua \
sed -i \'s/services/nas/g\'  /usr/lib/lua/luci/view/minidlna_status.htm' package/default-settings/files/zzz-default-settings

#
