################################################################################
#
# postgis
#
################################################################################

POSTGIS_VERSION = 3.1.1
POSTGIS_SITE = https://download.osgeo.org/postgis/source
# parallel build issues
POSTGIS_MAKE = $(MAKE1)
POSTGIS_LICENSE = GPL-2.0+ (PostGIS), BSD-2-Clause, MIT, Apache-2.0, ISC, BSL-1.0, CC-BY-SA-3.0
POSTGIS_LICENSE_FILES = LICENSE.TXT
# configure.ac is patched so need to run autoreconf
POSTGIS_AUTORECONF = YES

POSTGIS_DEPENDENCIES = postgresql libgeos proj libxml2

POSTGIS_CONF_OPTS += \
	--with-pgconfig=$(STAGING_DIR)/usr/bin/pg_config \
	--with-geosconfig=$(STAGING_DIR)/usr/bin/geos-config \
	--with-xml2config=$(STAGING_DIR)/usr/bin/xml2-config \
	--without-protobuf

ifeq ($(BR2_PACKAGE_LIBGDAL),y)
POSTGIS_DEPENDENCIES += libgdal
POSTGIS_CONF_OPTS += --with-raster
else
POSTGIS_CONF_OPTS += --without-raster
endif

$(eval $(autotools-package))