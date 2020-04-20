#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 修改默认主题
DEFAULT_THEME="bootstrap_mod"
#sed -i "s/luci-theme-bootstrap/luci-theme-$DEFAULT_THEME/g" feeds/luci/collections/luci/Makefile
sed -i '/mediaurlbase/d' package/default-settings/files/zzz-default-settings
sed -i '3auci set luci.main.mediaurlbase=/luci-static/'$DEFAULT_THEME package/default-settings/files/zzz-default-settings
grep -rin "url('admin/translations'" feeds/lienol/lienol/ | while read i
do
[ -f "$(echo $i | cut -d: -f1)" ] && sed -i "/url('admin\/translations'/d" "$(echo $i | cut -d: -f1)"
done

# 删除automount依赖ntfs-3g，会导致与antfs冲突
sed -i 's/+ntfs-3g//g' package/lean/automount/Makefile

# 移动菜单服务里面的项到网络存储
curl -fsSL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/lean/default-settings/files/zzz-default-settings > ./default-settings
sed -n '/nas/p' ./default-settings > ./default-settings-content
sed -i '/uci commit fstab/r ./default-settings-content' package/default-settings/files/zzz-default-settings
rm -rf default-setting*

# 更新smartdns
rm -rf package/lean/smartdns feeds/luci/applications/luci-app-smartdns
git clone --depth 1 https://github.com/1005789164/openwrt-smartdns.git MJ-dns
mv MJ-dns/smartdns package/lean/
mv MJ-dns/luci-app-smartdns feeds/luci/applications/
mkdir -p feeds/luci/applications/luci-app-smartdns/root/etc/config
mv MJ-dns/smartdns.txt feeds/luci/applications/luci-app-smartdns/root/etc/config/smartdns
sed -i '/\/package\/openwrt\/files\/etc\/config\/smartdns/d' package/lean/smartdns/Makefile
rm -rf MJ-dns

# 修改默认设置
sed -i 's/SNAPSHOT/SNAPSHOT-'$(TZ=UTC-8 date +"%Y.%m.%d")'/' package/default-settings/files/zzz-default-settings
sed -i 's/enabled.*/enabled\t\t1/; s/enable_natpmp.*/enable_natpmp\t1/; s/enable_upnp.*/enable_upnp\t1/' feeds/packages/net/miniupnpd/files/upnpd.config
sed -i 's/network.globals.ula_prefix.*/network.globals.ula_prefix='"''"/ package/base-files/files/bin/config_generate
sed -i '/filter_aaaa/d' package/network/services/dnsmasq/files/dhcp.conf

# 替换minidlna为大雕的minidlna
rm -rf feeds/packages/multimedia/minidlna
git clone --depth 1 https://github.com/coolsnowwolf/packages lede_packages
mv lede_packages/multimedia/minidlna feeds/packages/multimedia/
rm -rf lede_packages
