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
local DEFAULT_THEME="netgear"
sed '/option mediaurlbase \/.*\//s/static.*/static\/'$DEFAULT_THEME'/' feeds/luci/modules/luci-base/root/etc/config/luci

#