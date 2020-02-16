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
curl -fsSL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/lean/default-settings/files/zzz-default-settings >> ./default-settings
sed -n 18,28p ./default-settings > ./default-settings-content
sed -i '/uci commit fstab/r ./default-settings-content' package/default-settings/files/zzz-default-settings
rm -f default-setting*

#
