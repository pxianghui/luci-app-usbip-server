include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-usbip-server
PKG_VERSION:=1.1.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=天正 <your_email@example.com>

LUCI_TITLE:=LuCI support for USBIP Server
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-base +lua +usbip +usbip-server +usbip-client \
              +kmod-usbip +kmod-usbip-client +kmod-usbip-server +luci-compat

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/description
LuCI interface for USBIP Server - Share USB devices over TCP/IP network.
Supports local fallback usage when devices are not attached by remote clients.
endef

define Package/$(PKG_NAME)/install
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./files/etc/config/usbip_server $(1)/etc/config/

    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./files/etc/init.d/usbip_monitor $(1)/etc/init.d/

    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) ./files/usr/bin/usbip_monitor.sh $(1)/usr/bin/

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    $(INSTALL_BIN) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
    $(INSTALL_BIN) ./files/usr/lib/lua/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/

    $(INSTALL_DIR) $(1)/www/luci-static/resources/view/usbip_server
    $(INSTALL_DATA) ./files/www/luci-static/resources/view/usbip_server/* $(1)/www/luci-static/resources/view/usbip_server/

    # i18n 编译结果安装
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
    $(PO2LMO) ./po/zh_Hans/usbip_server.po \
        $(1)/usr/lib/lua/luci/i18n/usbip_server.zh-cn.lmo
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
