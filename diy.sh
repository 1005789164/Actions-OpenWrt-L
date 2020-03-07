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
DEFAULT_THEME="bootstrap_mod"
#sed -i '/option mediaurlbase \/.*\//s/static.*/static\/'$DEFAULT_THEME'/' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i '/mediaurlbase/d' package/default-settings/files/zzz-default-settings
sed -i '3auci set luci.main.mediaurlbase=/luci-static/'$DEFAULT_THEME package/default-settings/files/zzz-default-settings
grep -rin "url('admin/translations'" feeds/lienol/lienol/ | while read i
do
[ -f "$(echo $i | cut -d: -f1)" ] && sed -i "/url('admin\/translations'/d" "$(echo $i | cut -d: -f1)"
done

# 移动菜单服务里面的项到网络存储
curl -fsSL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/lean/default-settings/files/zzz-default-settings >> ./default-settings
sed -n '/nas/p' ./default-settings > ./default-settings-content
sed -i '/uci commit fstab/r ./default-settings-content' package/default-settings/files/zzz-default-settings
rm -rf default-setting*

# 更新smartdns
rm -rf package/lean/smartdns package/lean/luci-app-smartdns
git clone --depth 1 https://github.com/1005789164/openwrt-smartdns.git MJ-dns
mv MJ-dns/smartdns package/lean/
mv MJ-dns/luci-app-smartdns package/lean/
rm -rf MJ-dns
#sed -i 's/d6c34658af0d4aac94655a139030c5ec12884754/0d2d08586a34d83fee7d9ad6199eade81ffe0f64/' package/lean/smartdns/Makefile
#sed -i 's/2019.12.15/2020.02.20/' package/lean/smartdns/Makefile
#sed -i 's/PKG_RELEASE:=2/PKG_RELEASE:=3/' package/lean/smartdns/Makefile

# 修改默认设置
sed -i 's/SNAPSHOT/SNAPSHOT-'$(TZ=UTC-8 date +"%Y.%m.%d")'/' package/default-settings/files/zzz-default-settings


#
