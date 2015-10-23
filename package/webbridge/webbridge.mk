################################################################################
#
# webbridge
#
################################################################################

WEBBRIDGE_VERSION = 6de38aa507dfee5b411a4a525c5c0efcac5f07d8
WEBBRIDGE_SITE_METHOD = git
WEBBRIDGE_SITE = git@github.com:Metrological/webbridge.git
WEBBRIDGE_INSTALL_STAGING = YES
WEBBRIDGE_DEPENDENCIES += cppsdk

ifeq ($(BR2_ENABLE_DEBUG),y)
  WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_DEBUG=ON
else ifeq ($(BR2_PACKAGE_CPPSDK_DEBUG),y)
  WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_DEBUG=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_FANCONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_FANCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TRACECONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_TRACECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DELAYEDRESPONSE),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_DELAYEDRESPONSE=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_PROVISIONING),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_PROVISIONING=ON
	WEBBRIDGE_DEPENDENCIES += dxdrm
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBPROXY),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_REMOTECONTROL=ON
    WEBBRIDGE_DEPENDENCIES += greenpeak
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DEVICEINFO),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BROWSER),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_BROWSER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_I2CCONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_I2CCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_SPICONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_SPICONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TEMPCONTROL),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_TEMPCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_FILESERVER),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_FILESERVER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_SURFACECOMPOSITOR),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_PLUGIN_SURFACECOMPOSITOR=ON
	WEBBRIDGE_DEPENDENCIES += bcm-refsw
endif

ifneq ($(BR2_PACKAGE_PLUGIN_MINIMIZED),y)
    WEBBRIDGE_CONF_OPT += -DWEBBRIDGE_WEB_UI=OFF
endif

define WEBBRIDGE_POST_TARGET_INITD
    $(INSTALL) -D -m 0755 package/webbridge/S80webbridge $(TARGET_DIR)/etc/init.d
endef

WEBBRIDGE_POST_INSTALL_TARGET_HOOKS += WEBBRIDGE_POST_TARGET_INITD
$(eval $(cmake-package))
