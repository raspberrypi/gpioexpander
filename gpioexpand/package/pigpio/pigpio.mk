################################################################################
#
# pigpio
#
################################################################################

# v61
PIGPIO_VERSION = 114653357b8bf8b15213c52fbe5bcb2695d7d90b 
PIGPIO_SITE = $(call github,joan2937,pigpio,$(PIGPIO_VERSION))
PIGPIO_LICENSE = unlicense
PIGPIO_LICENSE_FILES = UNLICENCE
PIGPIO_INSTALL_STAGING = YES

define PIGPIO_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

#
# Custom installation commands to prevent dependency on Python
#
define PIGPIO_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/pigpio.h $(STAGING_DIR)/usr/include/pigpio.h
	$(INSTALL) -D -m 0644 $(@D)/pigpiod_if.h $(STAGING_DIR)/usr/include/pigpio_if.h
	$(INSTALL) -D -m 0644 $(@D)/pigpiod_if2.h $(STAGING_DIR)/usr/include/pigpio_if2.h
	$(INSTALL) -D -m 0755 $(@D)/libpigpio.so* $(STAGING_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libpigpiod_if.so* $(STAGING_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libpigpiod_if2.so* $(STAGING_DIR)/usr/lib
endef

define PIGPIO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libpigpio.so* $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libpigpiod_if.so* $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libpigpiod_if2.so* $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/pigpiod $(TARGET_DIR)/usr/sbin/pigpiod
	$(INSTALL) -D -m 0755 $(@D)/pigs $(TARGET_DIR)/usr/bin/pigs
endef

$(eval $(generic-package))
