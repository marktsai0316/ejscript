#
#   ejs-vxworks-default.mk -- Makefile to build Embethis Ejscript for vxworks
#

PRODUCT            := ejs
VERSION            := 2.3.4
PROFILE            := default
ARCH               := $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                := $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                 := vxworks
CC                 := cc$(subst x86,pentium,$(ARCH))
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin

BIT_PACK_EST       := 1
BIT_PACK_MATRIXSSL := 0
BIT_PACK_OPENSSL   := 0
BIT_PACK_PCRE      := 1
BIT_PACK_SQLITE    := 1
BIT_PACK_SSL       := 1
BIT_PACK_ZLIB      := 1

ifeq ($(BIT_PACK_EST),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    BIT_PACK_SSL := 1
endif

BIT_PACK_COMPILER_PATH    := cc$(subst x86,pentium,$(ARCH))
BIT_PACK_DOXYGEN_PATH     := doxygen
BIT_PACK_DSI_PATH         := dsi
BIT_PACK_EJSCRIPT_PATH    := ejscript
BIT_PACK_EST_PATH         := est
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link
BIT_PACK_MAN_PATH         := man
BIT_PACK_MAN2HTML_PATH    := man2html
BIT_PACK_MATRIXSSL_PATH   := /usr/src/matrixssl
BIT_PACK_NANOSSL_PATH     := /usr/src/nanossl
BIT_PACK_OPENSSL_PATH     := /usr/src/openssl
BIT_PACK_PCRE_PATH        := pcre
BIT_PACK_PMAKER_PATH      := pmaker
BIT_PACK_SQLITE_PATH      := sqlite
BIT_PACK_SSL_PATH         := ssl
BIT_PACK_VXWORKS_PATH     := $(WIND_BASE)
BIT_PACK_ZIP_PATH         := zip
BIT_PACK_ZLIB_PATH        := zlib

export WIND_HOME          := $(WIND_BASE)/..
export PATH               := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS             += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS             += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) -DBIT_PACK_EST=$(BIT_PACK_EST) -DBIT_PACK_MATRIXSSL=$(BIT_PACK_MATRIXSSL) -DBIT_PACK_OPENSSL=$(BIT_PACK_OPENSSL) -DBIT_PACK_PCRE=$(BIT_PACK_PCRE) -DBIT_PACK_SQLITE=$(BIT_PACK_SQLITE) -DBIT_PACK_SSL=$(BIT_PACK_SSL) -DBIT_PACK_ZLIB=$(BIT_PACK_ZLIB) 
IFLAGS             += "-I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS            += '-Wl,-r'
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -lgcc

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := deploy
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)
BIT_DATA_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_STATE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_BIN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_INC_PREFIX     := $(BIT_VAPP_PREFIX)/inc
BIT_LIB_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_MAN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SBIN_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_ETC_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_WEB_PREFIX     := $(BIT_VAPP_PREFIX)/web
BIT_LOG_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SPOOL_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_CACHE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/src/$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libmpr.out
TARGETS            += $(CONFIG)/bin/libmprssl.out
TARGETS            += $(CONFIG)/bin/ejsman.out
TARGETS            += $(CONFIG)/bin/makerom.out
TARGETS            += $(CONFIG)/bin/ca.crt
ifeq ($(BIT_PACK_PCRE),1)
TARGETS            += $(CONFIG)/bin/libpcre.out
endif
TARGETS            += $(CONFIG)/bin/libhttp.out
TARGETS            += $(CONFIG)/bin/http.out
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/libsql.out
endif
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/sqlite.out
endif
ifeq ($(BIT_PACK_ZLIB),1)
TARGETS            += $(CONFIG)/bin/libzlib.out
endif
TARGETS            += $(CONFIG)/bin/libejs.out
TARGETS            += $(CONFIG)/bin/ejs.out
TARGETS            += $(CONFIG)/bin/ejsc.out
TARGETS            += $(CONFIG)/bin/ejsmod.out
TARGETS            += $(CONFIG)/bin/ejsrun.out
TARGETS            += $(CONFIG)/bin/ejs.mod
TARGETS            += $(CONFIG)/bin/ejs.unix.mod
TARGETS            += $(CONFIG)/bin/ejs.db.mod
TARGETS            += $(CONFIG)/bin/ejs.db.mapper.mod
TARGETS            += $(CONFIG)/bin/ejs.db.sqlite.mod
TARGETS            += $(CONFIG)/bin/libejs.db.sqlite.out
TARGETS            += $(CONFIG)/bin/ejs.mail.mod
TARGETS            += $(CONFIG)/bin/ejs.web.mod
TARGETS            += $(CONFIG)/bin/libejs.web.out
TARGETS            += $(CONFIG)/bin/www
TARGETS            += $(CONFIG)/bin/ejs.template.mod
TARGETS            += $(CONFIG)/bin/ejs.zlib.mod
TARGETS            += $(CONFIG)/bin/libejs.zlib.out
TARGETS            += $(CONFIG)/bin/ejs.tar.mod
TARGETS            += $(CONFIG)/bin/mvc.es
TARGETS            += $(CONFIG)/bin/mvc.out
TARGETS            += $(CONFIG)/bin/ejs.mvc.mod
TARGETS            += $(CONFIG)/bin/utest.es
TARGETS            += $(CONFIG)/bin/utest.worker
TARGETS            += $(CONFIG)/bin/utest.out
TARGETS            += bower.json

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@if [ "$(WIND_BASE)" = "" ] ; then echo WARNING: WIND_BASE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_HOST_TYPE)" = "" ] ; then echo WARNING: WIND_HOST_TYPE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_GNU_PATH)" = "" ] ; then echo WARNING: WIND_GNU_PATH not set. Run wrenv.sh. ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bitos.h src/bitos.h >/dev/null ; then\
		cp src/bitos.h $(CONFIG)/inc/bitos.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/ejs-vxworks-default-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/ejs-vxworks-default-bit.h >/dev/null ; then\
		cp projects/ejs-vxworks-default-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libmpr.out"
	rm -f "$(CONFIG)/bin/libmprssl.out"
	rm -f "$(CONFIG)/bin/ejsman.out"
	rm -f "$(CONFIG)/bin/makerom.out"
	rm -f "$(CONFIG)/bin/libest.out"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/libpcre.out"
	rm -f "$(CONFIG)/bin/libhttp.out"
	rm -f "$(CONFIG)/bin/http.out"
	rm -f "$(CONFIG)/bin/libsql.out"
	rm -f "$(CONFIG)/bin/sqlite.out"
	rm -f "$(CONFIG)/bin/libzlib.out"
	rm -f "$(CONFIG)/bin/libejs.out"
	rm -f "$(CONFIG)/bin/ejs.out"
	rm -f "$(CONFIG)/bin/ejsc.out"
	rm -f "$(CONFIG)/bin/ejsmod.out"
	rm -f "$(CONFIG)/bin/ejsrun.out"
	rm -f "$(CONFIG)/bin/libejs.db.sqlite.out"
	rm -f "$(CONFIG)/bin/libejs.web.out"
	rm -f "$(CONFIG)/bin/libejs.zlib.out"
	rm -f "$(CONFIG)/bin/utest.out"
	rm -f "bower.json"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/sqlite3.o"
	rm -f "$(CONFIG)/obj/sqlite.o"
	rm -f "$(CONFIG)/obj/zlib.o"
	rm -f "$(CONFIG)/obj/ecAst.o"
	rm -f "$(CONFIG)/obj/ecCodeGen.o"
	rm -f "$(CONFIG)/obj/ecCompiler.o"
	rm -f "$(CONFIG)/obj/ecLex.o"
	rm -f "$(CONFIG)/obj/ecModuleWrite.o"
	rm -f "$(CONFIG)/obj/ecParser.o"
	rm -f "$(CONFIG)/obj/ecState.o"
	rm -f "$(CONFIG)/obj/dtoa.o"
	rm -f "$(CONFIG)/obj/ejsApp.o"
	rm -f "$(CONFIG)/obj/ejsArray.o"
	rm -f "$(CONFIG)/obj/ejsBlock.o"
	rm -f "$(CONFIG)/obj/ejsBoolean.o"
	rm -f "$(CONFIG)/obj/ejsByteArray.o"
	rm -f "$(CONFIG)/obj/ejsCache.o"
	rm -f "$(CONFIG)/obj/ejsCmd.o"
	rm -f "$(CONFIG)/obj/ejsConfig.o"
	rm -f "$(CONFIG)/obj/ejsDate.o"
	rm -f "$(CONFIG)/obj/ejsDebug.o"
	rm -f "$(CONFIG)/obj/ejsError.o"
	rm -f "$(CONFIG)/obj/ejsFile.o"
	rm -f "$(CONFIG)/obj/ejsFileSystem.o"
	rm -f "$(CONFIG)/obj/ejsFrame.o"
	rm -f "$(CONFIG)/obj/ejsFunction.o"
	rm -f "$(CONFIG)/obj/ejsGC.o"
	rm -f "$(CONFIG)/obj/ejsGlobal.o"
	rm -f "$(CONFIG)/obj/ejsHttp.o"
	rm -f "$(CONFIG)/obj/ejsIterator.o"
	rm -f "$(CONFIG)/obj/ejsJSON.o"
	rm -f "$(CONFIG)/obj/ejsLocalCache.o"
	rm -f "$(CONFIG)/obj/ejsMath.o"
	rm -f "$(CONFIG)/obj/ejsMemory.o"
	rm -f "$(CONFIG)/obj/ejsMprLog.o"
	rm -f "$(CONFIG)/obj/ejsNamespace.o"
	rm -f "$(CONFIG)/obj/ejsNull.o"
	rm -f "$(CONFIG)/obj/ejsNumber.o"
	rm -f "$(CONFIG)/obj/ejsObject.o"
	rm -f "$(CONFIG)/obj/ejsPath.o"
	rm -f "$(CONFIG)/obj/ejsPot.o"
	rm -f "$(CONFIG)/obj/ejsRegExp.o"
	rm -f "$(CONFIG)/obj/ejsSocket.o"
	rm -f "$(CONFIG)/obj/ejsString.o"
	rm -f "$(CONFIG)/obj/ejsSystem.o"
	rm -f "$(CONFIG)/obj/ejsTimer.o"
	rm -f "$(CONFIG)/obj/ejsType.o"
	rm -f "$(CONFIG)/obj/ejsUri.o"
	rm -f "$(CONFIG)/obj/ejsVoid.o"
	rm -f "$(CONFIG)/obj/ejsWebSocket.o"
	rm -f "$(CONFIG)/obj/ejsWorker.o"
	rm -f "$(CONFIG)/obj/ejsXML.o"
	rm -f "$(CONFIG)/obj/ejsXMLList.o"
	rm -f "$(CONFIG)/obj/ejsXMLLoader.o"
	rm -f "$(CONFIG)/obj/ejsByteCode.o"
	rm -f "$(CONFIG)/obj/ejsException.o"
	rm -f "$(CONFIG)/obj/ejsHelper.o"
	rm -f "$(CONFIG)/obj/ejsInterp.o"
	rm -f "$(CONFIG)/obj/ejsLoader.o"
	rm -f "$(CONFIG)/obj/ejsModule.o"
	rm -f "$(CONFIG)/obj/ejsScope.o"
	rm -f "$(CONFIG)/obj/ejsService.o"
	rm -f "$(CONFIG)/obj/ejs.o"
	rm -f "$(CONFIG)/obj/ejsc.o"
	rm -f "$(CONFIG)/obj/ejsmod.o"
	rm -f "$(CONFIG)/obj/doc.o"
	rm -f "$(CONFIG)/obj/docFiles.o"
	rm -f "$(CONFIG)/obj/listing.o"
	rm -f "$(CONFIG)/obj/slotGen.o"
	rm -f "$(CONFIG)/obj/ejsrun.o"
	rm -f "$(CONFIG)/obj/ejsSqlite.o"
	rm -f "$(CONFIG)/obj/ejsHttpServer.o"
	rm -f "$(CONFIG)/obj/ejsRequest.o"
	rm -f "$(CONFIG)/obj/ejsSession.o"
	rm -f "$(CONFIG)/obj/ejsWeb.o"
	rm -f "$(CONFIG)/obj/ejsZlib.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	echo 2.3.4

#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   bitos.h
#
$(CONFIG)/inc/bitos.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/bitos.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bitos.h $(CONFIG)/inc/bitos.h

#
#   mprLib.o
#
DEPS_5 += $(CONFIG)/inc/bit.h
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/mprLib.o: \
    src/paks/mpr/mprLib.c $(DEPS_5)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	$(CC) -c -o $(CONFIG)/obj/mprLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/mprLib.c

#
#   libmpr
#
DEPS_6 += $(CONFIG)/inc/mpr.h
DEPS_6 += $(CONFIG)/inc/bit.h
DEPS_6 += $(CONFIG)/inc/bitos.h
DEPS_6 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.out: $(DEPS_6)
	@echo '      [Link] $(CONFIG)/bin/libmpr.out'
	$(CC) -r -o $(CONFIG)/bin/libmpr.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/mprLib.o" $(LIBS) 

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_8 += $(CONFIG)/inc/bit.h
DEPS_8 += $(CONFIG)/inc/est.h
DEPS_8 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/estLib.o: \
    src/paks/est/estLib.c $(DEPS_8)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	$(CC) -c -o $(CONFIG)/obj/estLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/est/estLib.c

ifeq ($(BIT_PACK_EST),1)
#
#   libest
#
DEPS_9 += $(CONFIG)/inc/est.h
DEPS_9 += $(CONFIG)/inc/bit.h
DEPS_9 += $(CONFIG)/inc/bitos.h
DEPS_9 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.out: $(DEPS_9)
	@echo '      [Link] $(CONFIG)/bin/libest.out'
	$(CC) -r -o $(CONFIG)/bin/libest.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/estLib.o" $(LIBS) 
endif

#
#   mprSsl.o
#
DEPS_10 += $(CONFIG)/inc/bit.h
DEPS_10 += $(CONFIG)/inc/mpr.h
DEPS_10 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/paks/mpr/mprSsl.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	$(CC) -c -o $(CONFIG)/obj/mprSsl.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/paks/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_11 += $(CONFIG)/inc/mpr.h
DEPS_11 += $(CONFIG)/inc/bit.h
DEPS_11 += $(CONFIG)/inc/bitos.h
DEPS_11 += $(CONFIG)/obj/mprLib.o
DEPS_11 += $(CONFIG)/bin/libmpr.out
DEPS_11 += $(CONFIG)/inc/est.h
DEPS_11 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_11 += $(CONFIG)/bin/libest.out
endif
DEPS_11 += $(CONFIG)/obj/mprSsl.o

ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_11 += -lmatrixssl
    LIBPATHS_11 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_11 += -lssls
    LIBPATHS_11 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_11 += -lssl
    LIBPATHS_11 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_11 += -lcrypto
    LIBPATHS_11 += -L$(BIT_PACK_OPENSSL_PATH)
endif

$(CONFIG)/bin/libmprssl.out: $(DEPS_11)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.out'
	$(CC) -r -o $(CONFIG)/bin/libmprssl.out $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/mprSsl.o" $(LIBPATHS_11) $(LIBS_11) $(LIBS_11) $(LIBS) 

#
#   manager.o
#
DEPS_12 += $(CONFIG)/inc/bit.h
DEPS_12 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/paks/mpr/manager.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	$(CC) -c -o $(CONFIG)/obj/manager.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/manager.c

#
#   manager
#
DEPS_13 += $(CONFIG)/inc/mpr.h
DEPS_13 += $(CONFIG)/inc/bit.h
DEPS_13 += $(CONFIG)/inc/bitos.h
DEPS_13 += $(CONFIG)/obj/mprLib.o
DEPS_13 += $(CONFIG)/bin/libmpr.out
DEPS_13 += $(CONFIG)/obj/manager.o

$(CONFIG)/bin/ejsman.out: $(DEPS_13)
	@echo '      [Link] $(CONFIG)/bin/ejsman.out'
	$(CC) -o $(CONFIG)/bin/ejsman.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBS) -Wl,-r 

#
#   makerom.o
#
DEPS_14 += $(CONFIG)/inc/bit.h
DEPS_14 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/makerom.o: \
    src/paks/mpr/makerom.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/makerom.o'
	$(CC) -c -o $(CONFIG)/obj/makerom.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/makerom.c

#
#   makerom
#
DEPS_15 += $(CONFIG)/inc/mpr.h
DEPS_15 += $(CONFIG)/inc/bit.h
DEPS_15 += $(CONFIG)/inc/bitos.h
DEPS_15 += $(CONFIG)/obj/mprLib.o
DEPS_15 += $(CONFIG)/bin/libmpr.out
DEPS_15 += $(CONFIG)/obj/makerom.o

$(CONFIG)/bin/makerom.out: $(DEPS_15)
	@echo '      [Link] $(CONFIG)/bin/makerom.out'
	$(CC) -o $(CONFIG)/bin/makerom.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/makerom.o" $(LIBS) -Wl,-r 

#
#   ca-crt
#
DEPS_16 += src/paks/est/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_16)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/est/ca.crt $(CONFIG)/bin/ca.crt

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_17)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_18 += $(CONFIG)/inc/bit.h
DEPS_18 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/paks/pcre/pcre.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	$(CC) -c -o $(CONFIG)/obj/pcre.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/pcre/pcre.c

ifeq ($(BIT_PACK_PCRE),1)
#
#   libpcre
#
DEPS_19 += $(CONFIG)/inc/pcre.h
DEPS_19 += $(CONFIG)/inc/bit.h
DEPS_19 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.out: $(DEPS_19)
	@echo '      [Link] $(CONFIG)/bin/libpcre.out'
	$(CC) -r -o $(CONFIG)/bin/libpcre.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/pcre.o" $(LIBS) 
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_20)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_21 += $(CONFIG)/inc/bit.h
DEPS_21 += $(CONFIG)/inc/http.h
DEPS_21 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/paks/http/httpLib.c $(DEPS_21)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	$(CC) -c -o $(CONFIG)/obj/httpLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/httpLib.c

#
#   libhttp
#
DEPS_22 += $(CONFIG)/inc/mpr.h
DEPS_22 += $(CONFIG)/inc/bit.h
DEPS_22 += $(CONFIG)/inc/bitos.h
DEPS_22 += $(CONFIG)/obj/mprLib.o
DEPS_22 += $(CONFIG)/bin/libmpr.out
DEPS_22 += $(CONFIG)/inc/pcre.h
DEPS_22 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_22 += $(CONFIG)/bin/libpcre.out
endif
DEPS_22 += $(CONFIG)/inc/http.h
DEPS_22 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.out: $(DEPS_22)
	@echo '      [Link] $(CONFIG)/bin/libhttp.out'
	$(CC) -r -o $(CONFIG)/bin/libhttp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/httpLib.o" $(LIBS) 

#
#   http.o
#
DEPS_23 += $(CONFIG)/inc/bit.h
DEPS_23 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/paks/http/http.c $(DEPS_23)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	$(CC) -c -o $(CONFIG)/obj/http.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/http.c

#
#   http
#
DEPS_24 += $(CONFIG)/inc/mpr.h
DEPS_24 += $(CONFIG)/inc/bit.h
DEPS_24 += $(CONFIG)/inc/bitos.h
DEPS_24 += $(CONFIG)/obj/mprLib.o
DEPS_24 += $(CONFIG)/bin/libmpr.out
DEPS_24 += $(CONFIG)/inc/pcre.h
DEPS_24 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_24 += $(CONFIG)/bin/libpcre.out
endif
DEPS_24 += $(CONFIG)/inc/http.h
DEPS_24 += $(CONFIG)/obj/httpLib.o
DEPS_24 += $(CONFIG)/bin/libhttp.out
DEPS_24 += $(CONFIG)/obj/http.o

$(CONFIG)/bin/http.out: $(DEPS_24)
	@echo '      [Link] $(CONFIG)/bin/http.out'
	$(CC) -o $(CONFIG)/bin/http.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/http.o" $(LIBS) -Wl,-r 

#
#   sqlite3.h
#
$(CONFIG)/inc/sqlite3.h: $(DEPS_25)
	@echo '      [Copy] $(CONFIG)/inc/sqlite3.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/sqlite/sqlite3.h $(CONFIG)/inc/sqlite3.h

#
#   sqlite3.o
#
DEPS_26 += $(CONFIG)/inc/bit.h
DEPS_26 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite3.o: \
    src/paks/sqlite/sqlite3.c $(DEPS_26)
	@echo '   [Compile] $(CONFIG)/obj/sqlite3.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite3.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite3.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   libsql
#
DEPS_27 += $(CONFIG)/inc/sqlite3.h
DEPS_27 += $(CONFIG)/inc/bit.h
DEPS_27 += $(CONFIG)/obj/sqlite3.o

$(CONFIG)/bin/libsql.out: $(DEPS_27)
	@echo '      [Link] $(CONFIG)/bin/libsql.out'
	$(CC) -r -o $(CONFIG)/bin/libsql.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite3.o" $(LIBS) 
endif

#
#   sqlite.o
#
DEPS_28 += $(CONFIG)/inc/bit.h
DEPS_28 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite.o: \
    src/paks/sqlite/sqlite.c $(DEPS_28)
	@echo '   [Compile] $(CONFIG)/obj/sqlite.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   sqliteshell
#
DEPS_29 += $(CONFIG)/inc/sqlite3.h
DEPS_29 += $(CONFIG)/inc/bit.h
DEPS_29 += $(CONFIG)/obj/sqlite3.o
DEPS_29 += $(CONFIG)/bin/libsql.out
DEPS_29 += $(CONFIG)/obj/sqlite.o

$(CONFIG)/bin/sqlite.out: $(DEPS_29)
	@echo '      [Link] $(CONFIG)/bin/sqlite.out'
	$(CC) -o $(CONFIG)/bin/sqlite.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite.o" $(LIBS) -Wl,-r 
endif

#
#   zlib.h
#
$(CONFIG)/inc/zlib.h: $(DEPS_30)
	@echo '      [Copy] $(CONFIG)/inc/zlib.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/zlib/zlib.h $(CONFIG)/inc/zlib.h

#
#   zlib.o
#
DEPS_31 += $(CONFIG)/inc/bit.h
DEPS_31 += $(CONFIG)/inc/zlib.h

$(CONFIG)/obj/zlib.o: \
    src/paks/zlib/zlib.c $(DEPS_31)
	@echo '   [Compile] $(CONFIG)/obj/zlib.o'
	$(CC) -c -o $(CONFIG)/obj/zlib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/zlib/zlib.c

ifeq ($(BIT_PACK_ZLIB),1)
#
#   libzlib
#
DEPS_32 += $(CONFIG)/inc/zlib.h
DEPS_32 += $(CONFIG)/inc/bit.h
DEPS_32 += $(CONFIG)/obj/zlib.o

$(CONFIG)/bin/libzlib.out: $(DEPS_32)
	@echo '      [Link] $(CONFIG)/bin/libzlib.out'
	$(CC) -r -o $(CONFIG)/bin/libzlib.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/zlib.o" $(LIBS) 
endif

#
#   ejs.cache.local.slots.h
#
$(CONFIG)/inc/ejs.cache.local.slots.h: $(DEPS_33)
	@echo '      [Copy] $(CONFIG)/inc/ejs.cache.local.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/slots/ejs.cache.local.slots.h $(CONFIG)/inc/ejs.cache.local.slots.h

#
#   ejs.db.sqlite.slots.h
#
$(CONFIG)/inc/ejs.db.sqlite.slots.h: $(DEPS_34)
	@echo '      [Copy] $(CONFIG)/inc/ejs.db.sqlite.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/slots/ejs.db.sqlite.slots.h $(CONFIG)/inc/ejs.db.sqlite.slots.h

#
#   ejs.slots.h
#
$(CONFIG)/inc/ejs.slots.h: $(DEPS_35)
	@echo '      [Copy] $(CONFIG)/inc/ejs.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/slots/ejs.slots.h $(CONFIG)/inc/ejs.slots.h

#
#   ejs.web.slots.h
#
$(CONFIG)/inc/ejs.web.slots.h: $(DEPS_36)
	@echo '      [Copy] $(CONFIG)/inc/ejs.web.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/slots/ejs.web.slots.h $(CONFIG)/inc/ejs.web.slots.h

#
#   ejs.zlib.slots.h
#
$(CONFIG)/inc/ejs.zlib.slots.h: $(DEPS_37)
	@echo '      [Copy] $(CONFIG)/inc/ejs.zlib.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/slots/ejs.zlib.slots.h $(CONFIG)/inc/ejs.zlib.slots.h

#
#   ejsByteCode.h
#
$(CONFIG)/inc/ejsByteCode.h: $(DEPS_38)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteCode.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejsByteCode.h $(CONFIG)/inc/ejsByteCode.h

#
#   ejsByteCodeTable.h
#
$(CONFIG)/inc/ejsByteCodeTable.h: $(DEPS_39)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteCodeTable.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejsByteCodeTable.h $(CONFIG)/inc/ejsByteCodeTable.h

#
#   ejsCustomize.h
#
$(CONFIG)/inc/ejsCustomize.h: $(DEPS_40)
	@echo '      [Copy] $(CONFIG)/inc/ejsCustomize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejsCustomize.h $(CONFIG)/inc/ejsCustomize.h

#
#   ejs.h
#
DEPS_41 += $(CONFIG)/inc/mpr.h
DEPS_41 += $(CONFIG)/inc/http.h
DEPS_41 += $(CONFIG)/inc/ejsByteCode.h
DEPS_41 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_41 += $(CONFIG)/inc/ejs.slots.h
DEPS_41 += $(CONFIG)/inc/ejsCustomize.h

$(CONFIG)/inc/ejs.h: $(DEPS_41)
	@echo '      [Copy] $(CONFIG)/inc/ejs.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejs.h $(CONFIG)/inc/ejs.h

#
#   ejsCompiler.h
#
$(CONFIG)/inc/ejsCompiler.h: $(DEPS_42)
	@echo '      [Copy] $(CONFIG)/inc/ejsCompiler.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejsCompiler.h $(CONFIG)/inc/ejsCompiler.h

#
#   ecAst.o
#
DEPS_43 += $(CONFIG)/inc/bit.h
DEPS_43 += $(CONFIG)/inc/ejsCompiler.h
DEPS_43 += $(CONFIG)/inc/mpr.h
DEPS_43 += $(CONFIG)/inc/http.h
DEPS_43 += $(CONFIG)/inc/ejsByteCode.h
DEPS_43 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_43 += $(CONFIG)/inc/ejs.slots.h
DEPS_43 += $(CONFIG)/inc/ejsCustomize.h
DEPS_43 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ecAst.o: \
    src/compiler/ecAst.c $(DEPS_43)
	@echo '   [Compile] $(CONFIG)/obj/ecAst.o'
	$(CC) -c -o $(CONFIG)/obj/ecAst.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecAst.c

#
#   ecCodeGen.o
#
DEPS_44 += $(CONFIG)/inc/bit.h
DEPS_44 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecCodeGen.o: \
    src/compiler/ecCodeGen.c $(DEPS_44)
	@echo '   [Compile] $(CONFIG)/obj/ecCodeGen.o'
	$(CC) -c -o $(CONFIG)/obj/ecCodeGen.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecCodeGen.c

#
#   ecCompiler.o
#
DEPS_45 += $(CONFIG)/inc/bit.h
DEPS_45 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecCompiler.o: \
    src/compiler/ecCompiler.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/ecCompiler.o'
	$(CC) -c -o $(CONFIG)/obj/ecCompiler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecCompiler.c

#
#   ecLex.o
#
DEPS_46 += $(CONFIG)/inc/bit.h
DEPS_46 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecLex.o: \
    src/compiler/ecLex.c $(DEPS_46)
	@echo '   [Compile] $(CONFIG)/obj/ecLex.o'
	$(CC) -c -o $(CONFIG)/obj/ecLex.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecLex.c

#
#   ecModuleWrite.o
#
DEPS_47 += $(CONFIG)/inc/bit.h
DEPS_47 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecModuleWrite.o: \
    src/compiler/ecModuleWrite.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/ecModuleWrite.o'
	$(CC) -c -o $(CONFIG)/obj/ecModuleWrite.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecModuleWrite.c

#
#   ecParser.o
#
DEPS_48 += $(CONFIG)/inc/bit.h
DEPS_48 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecParser.o: \
    src/compiler/ecParser.c $(DEPS_48)
	@echo '   [Compile] $(CONFIG)/obj/ecParser.o'
	$(CC) -c -o $(CONFIG)/obj/ecParser.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecParser.c

#
#   ecState.o
#
DEPS_49 += $(CONFIG)/inc/bit.h
DEPS_49 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ecState.o: \
    src/compiler/ecState.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/ecState.o'
	$(CC) -c -o $(CONFIG)/obj/ecState.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/compiler/ecState.c

#
#   dtoa.o
#
DEPS_50 += $(CONFIG)/inc/bit.h
DEPS_50 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/dtoa.o: \
    src/core/src/dtoa.c $(DEPS_50)
	@echo '   [Compile] $(CONFIG)/obj/dtoa.o'
	$(CC) -c -o $(CONFIG)/obj/dtoa.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/dtoa.c

#
#   ejsApp.o
#
DEPS_51 += $(CONFIG)/inc/bit.h
DEPS_51 += $(CONFIG)/inc/mpr.h
DEPS_51 += $(CONFIG)/inc/http.h
DEPS_51 += $(CONFIG)/inc/ejsByteCode.h
DEPS_51 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_51 += $(CONFIG)/inc/ejs.slots.h
DEPS_51 += $(CONFIG)/inc/ejsCustomize.h
DEPS_51 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsApp.o: \
    src/core/src/ejsApp.c $(DEPS_51)
	@echo '   [Compile] $(CONFIG)/obj/ejsApp.o'
	$(CC) -c -o $(CONFIG)/obj/ejsApp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsApp.c

#
#   ejsArray.o
#
DEPS_52 += $(CONFIG)/inc/bit.h
DEPS_52 += $(CONFIG)/inc/mpr.h
DEPS_52 += $(CONFIG)/inc/http.h
DEPS_52 += $(CONFIG)/inc/ejsByteCode.h
DEPS_52 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_52 += $(CONFIG)/inc/ejs.slots.h
DEPS_52 += $(CONFIG)/inc/ejsCustomize.h
DEPS_52 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsArray.o: \
    src/core/src/ejsArray.c $(DEPS_52)
	@echo '   [Compile] $(CONFIG)/obj/ejsArray.o'
	$(CC) -c -o $(CONFIG)/obj/ejsArray.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsArray.c

#
#   ejsBlock.o
#
DEPS_53 += $(CONFIG)/inc/bit.h
DEPS_53 += $(CONFIG)/inc/mpr.h
DEPS_53 += $(CONFIG)/inc/http.h
DEPS_53 += $(CONFIG)/inc/ejsByteCode.h
DEPS_53 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_53 += $(CONFIG)/inc/ejs.slots.h
DEPS_53 += $(CONFIG)/inc/ejsCustomize.h
DEPS_53 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsBlock.o: \
    src/core/src/ejsBlock.c $(DEPS_53)
	@echo '   [Compile] $(CONFIG)/obj/ejsBlock.o'
	$(CC) -c -o $(CONFIG)/obj/ejsBlock.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsBlock.c

#
#   ejsBoolean.o
#
DEPS_54 += $(CONFIG)/inc/bit.h
DEPS_54 += $(CONFIG)/inc/mpr.h
DEPS_54 += $(CONFIG)/inc/http.h
DEPS_54 += $(CONFIG)/inc/ejsByteCode.h
DEPS_54 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_54 += $(CONFIG)/inc/ejs.slots.h
DEPS_54 += $(CONFIG)/inc/ejsCustomize.h
DEPS_54 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsBoolean.o: \
    src/core/src/ejsBoolean.c $(DEPS_54)
	@echo '   [Compile] $(CONFIG)/obj/ejsBoolean.o'
	$(CC) -c -o $(CONFIG)/obj/ejsBoolean.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsBoolean.c

#
#   ejsByteArray.o
#
DEPS_55 += $(CONFIG)/inc/bit.h
DEPS_55 += $(CONFIG)/inc/mpr.h
DEPS_55 += $(CONFIG)/inc/http.h
DEPS_55 += $(CONFIG)/inc/ejsByteCode.h
DEPS_55 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_55 += $(CONFIG)/inc/ejs.slots.h
DEPS_55 += $(CONFIG)/inc/ejsCustomize.h
DEPS_55 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsByteArray.o: \
    src/core/src/ejsByteArray.c $(DEPS_55)
	@echo '   [Compile] $(CONFIG)/obj/ejsByteArray.o'
	$(CC) -c -o $(CONFIG)/obj/ejsByteArray.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsByteArray.c

#
#   ejsCache.o
#
DEPS_56 += $(CONFIG)/inc/bit.h
DEPS_56 += $(CONFIG)/inc/mpr.h
DEPS_56 += $(CONFIG)/inc/http.h
DEPS_56 += $(CONFIG)/inc/ejsByteCode.h
DEPS_56 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_56 += $(CONFIG)/inc/ejs.slots.h
DEPS_56 += $(CONFIG)/inc/ejsCustomize.h
DEPS_56 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsCache.o: \
    src/core/src/ejsCache.c $(DEPS_56)
	@echo '   [Compile] $(CONFIG)/obj/ejsCache.o'
	$(CC) -c -o $(CONFIG)/obj/ejsCache.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsCache.c

#
#   ejsCmd.o
#
DEPS_57 += $(CONFIG)/inc/bit.h
DEPS_57 += $(CONFIG)/inc/mpr.h
DEPS_57 += $(CONFIG)/inc/http.h
DEPS_57 += $(CONFIG)/inc/ejsByteCode.h
DEPS_57 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_57 += $(CONFIG)/inc/ejs.slots.h
DEPS_57 += $(CONFIG)/inc/ejsCustomize.h
DEPS_57 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsCmd.o: \
    src/core/src/ejsCmd.c $(DEPS_57)
	@echo '   [Compile] $(CONFIG)/obj/ejsCmd.o'
	$(CC) -c -o $(CONFIG)/obj/ejsCmd.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsCmd.c

#
#   ejsConfig.o
#
DEPS_58 += $(CONFIG)/inc/bit.h
DEPS_58 += $(CONFIG)/inc/mpr.h
DEPS_58 += $(CONFIG)/inc/http.h
DEPS_58 += $(CONFIG)/inc/ejsByteCode.h
DEPS_58 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_58 += $(CONFIG)/inc/ejs.slots.h
DEPS_58 += $(CONFIG)/inc/ejsCustomize.h
DEPS_58 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsConfig.o: \
    src/core/src/ejsConfig.c $(DEPS_58)
	@echo '   [Compile] $(CONFIG)/obj/ejsConfig.o'
	$(CC) -c -o $(CONFIG)/obj/ejsConfig.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsConfig.c

#
#   ejsDate.o
#
DEPS_59 += $(CONFIG)/inc/bit.h
DEPS_59 += $(CONFIG)/inc/mpr.h
DEPS_59 += $(CONFIG)/inc/http.h
DEPS_59 += $(CONFIG)/inc/ejsByteCode.h
DEPS_59 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_59 += $(CONFIG)/inc/ejs.slots.h
DEPS_59 += $(CONFIG)/inc/ejsCustomize.h
DEPS_59 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsDate.o: \
    src/core/src/ejsDate.c $(DEPS_59)
	@echo '   [Compile] $(CONFIG)/obj/ejsDate.o'
	$(CC) -c -o $(CONFIG)/obj/ejsDate.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsDate.c

#
#   ejsDebug.o
#
DEPS_60 += $(CONFIG)/inc/bit.h
DEPS_60 += $(CONFIG)/inc/mpr.h
DEPS_60 += $(CONFIG)/inc/http.h
DEPS_60 += $(CONFIG)/inc/ejsByteCode.h
DEPS_60 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_60 += $(CONFIG)/inc/ejs.slots.h
DEPS_60 += $(CONFIG)/inc/ejsCustomize.h
DEPS_60 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsDebug.o: \
    src/core/src/ejsDebug.c $(DEPS_60)
	@echo '   [Compile] $(CONFIG)/obj/ejsDebug.o'
	$(CC) -c -o $(CONFIG)/obj/ejsDebug.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsDebug.c

#
#   ejsError.o
#
DEPS_61 += $(CONFIG)/inc/bit.h
DEPS_61 += $(CONFIG)/inc/mpr.h
DEPS_61 += $(CONFIG)/inc/http.h
DEPS_61 += $(CONFIG)/inc/ejsByteCode.h
DEPS_61 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_61 += $(CONFIG)/inc/ejs.slots.h
DEPS_61 += $(CONFIG)/inc/ejsCustomize.h
DEPS_61 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsError.o: \
    src/core/src/ejsError.c $(DEPS_61)
	@echo '   [Compile] $(CONFIG)/obj/ejsError.o'
	$(CC) -c -o $(CONFIG)/obj/ejsError.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsError.c

#
#   ejsFile.o
#
DEPS_62 += $(CONFIG)/inc/bit.h
DEPS_62 += $(CONFIG)/inc/mpr.h
DEPS_62 += $(CONFIG)/inc/http.h
DEPS_62 += $(CONFIG)/inc/ejsByteCode.h
DEPS_62 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_62 += $(CONFIG)/inc/ejs.slots.h
DEPS_62 += $(CONFIG)/inc/ejsCustomize.h
DEPS_62 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsFile.o: \
    src/core/src/ejsFile.c $(DEPS_62)
	@echo '   [Compile] $(CONFIG)/obj/ejsFile.o'
	$(CC) -c -o $(CONFIG)/obj/ejsFile.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsFile.c

#
#   ejsFileSystem.o
#
DEPS_63 += $(CONFIG)/inc/bit.h
DEPS_63 += $(CONFIG)/inc/mpr.h
DEPS_63 += $(CONFIG)/inc/http.h
DEPS_63 += $(CONFIG)/inc/ejsByteCode.h
DEPS_63 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_63 += $(CONFIG)/inc/ejs.slots.h
DEPS_63 += $(CONFIG)/inc/ejsCustomize.h
DEPS_63 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsFileSystem.o: \
    src/core/src/ejsFileSystem.c $(DEPS_63)
	@echo '   [Compile] $(CONFIG)/obj/ejsFileSystem.o'
	$(CC) -c -o $(CONFIG)/obj/ejsFileSystem.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsFileSystem.c

#
#   ejsFrame.o
#
DEPS_64 += $(CONFIG)/inc/bit.h
DEPS_64 += $(CONFIG)/inc/mpr.h
DEPS_64 += $(CONFIG)/inc/http.h
DEPS_64 += $(CONFIG)/inc/ejsByteCode.h
DEPS_64 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_64 += $(CONFIG)/inc/ejs.slots.h
DEPS_64 += $(CONFIG)/inc/ejsCustomize.h
DEPS_64 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsFrame.o: \
    src/core/src/ejsFrame.c $(DEPS_64)
	@echo '   [Compile] $(CONFIG)/obj/ejsFrame.o'
	$(CC) -c -o $(CONFIG)/obj/ejsFrame.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsFrame.c

#
#   ejsFunction.o
#
DEPS_65 += $(CONFIG)/inc/bit.h
DEPS_65 += $(CONFIG)/inc/mpr.h
DEPS_65 += $(CONFIG)/inc/http.h
DEPS_65 += $(CONFIG)/inc/ejsByteCode.h
DEPS_65 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_65 += $(CONFIG)/inc/ejs.slots.h
DEPS_65 += $(CONFIG)/inc/ejsCustomize.h
DEPS_65 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsFunction.o: \
    src/core/src/ejsFunction.c $(DEPS_65)
	@echo '   [Compile] $(CONFIG)/obj/ejsFunction.o'
	$(CC) -c -o $(CONFIG)/obj/ejsFunction.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsFunction.c

#
#   ejsGC.o
#
DEPS_66 += $(CONFIG)/inc/bit.h
DEPS_66 += $(CONFIG)/inc/mpr.h
DEPS_66 += $(CONFIG)/inc/http.h
DEPS_66 += $(CONFIG)/inc/ejsByteCode.h
DEPS_66 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_66 += $(CONFIG)/inc/ejs.slots.h
DEPS_66 += $(CONFIG)/inc/ejsCustomize.h
DEPS_66 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsGC.o: \
    src/core/src/ejsGC.c $(DEPS_66)
	@echo '   [Compile] $(CONFIG)/obj/ejsGC.o'
	$(CC) -c -o $(CONFIG)/obj/ejsGC.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsGC.c

#
#   ejsGlobal.o
#
DEPS_67 += $(CONFIG)/inc/bit.h
DEPS_67 += $(CONFIG)/inc/mpr.h
DEPS_67 += $(CONFIG)/inc/http.h
DEPS_67 += $(CONFIG)/inc/ejsByteCode.h
DEPS_67 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_67 += $(CONFIG)/inc/ejs.slots.h
DEPS_67 += $(CONFIG)/inc/ejsCustomize.h
DEPS_67 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsGlobal.o: \
    src/core/src/ejsGlobal.c $(DEPS_67)
	@echo '   [Compile] $(CONFIG)/obj/ejsGlobal.o'
	$(CC) -c -o $(CONFIG)/obj/ejsGlobal.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsGlobal.c

#
#   ejsHttp.o
#
DEPS_68 += $(CONFIG)/inc/bit.h
DEPS_68 += $(CONFIG)/inc/mpr.h
DEPS_68 += $(CONFIG)/inc/http.h
DEPS_68 += $(CONFIG)/inc/ejsByteCode.h
DEPS_68 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_68 += $(CONFIG)/inc/ejs.slots.h
DEPS_68 += $(CONFIG)/inc/ejsCustomize.h
DEPS_68 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsHttp.o: \
    src/core/src/ejsHttp.c $(DEPS_68)
	@echo '   [Compile] $(CONFIG)/obj/ejsHttp.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHttp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsHttp.c

#
#   ejsIterator.o
#
DEPS_69 += $(CONFIG)/inc/bit.h
DEPS_69 += $(CONFIG)/inc/mpr.h
DEPS_69 += $(CONFIG)/inc/http.h
DEPS_69 += $(CONFIG)/inc/ejsByteCode.h
DEPS_69 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_69 += $(CONFIG)/inc/ejs.slots.h
DEPS_69 += $(CONFIG)/inc/ejsCustomize.h
DEPS_69 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsIterator.o: \
    src/core/src/ejsIterator.c $(DEPS_69)
	@echo '   [Compile] $(CONFIG)/obj/ejsIterator.o'
	$(CC) -c -o $(CONFIG)/obj/ejsIterator.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsIterator.c

#
#   ejsJSON.o
#
DEPS_70 += $(CONFIG)/inc/bit.h
DEPS_70 += $(CONFIG)/inc/mpr.h
DEPS_70 += $(CONFIG)/inc/http.h
DEPS_70 += $(CONFIG)/inc/ejsByteCode.h
DEPS_70 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_70 += $(CONFIG)/inc/ejs.slots.h
DEPS_70 += $(CONFIG)/inc/ejsCustomize.h
DEPS_70 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsJSON.o: \
    src/core/src/ejsJSON.c $(DEPS_70)
	@echo '   [Compile] $(CONFIG)/obj/ejsJSON.o'
	$(CC) -c -o $(CONFIG)/obj/ejsJSON.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsJSON.c

#
#   ejsLocalCache.o
#
DEPS_71 += $(CONFIG)/inc/bit.h
DEPS_71 += $(CONFIG)/inc/mpr.h
DEPS_71 += $(CONFIG)/inc/http.h
DEPS_71 += $(CONFIG)/inc/ejsByteCode.h
DEPS_71 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_71 += $(CONFIG)/inc/ejs.slots.h
DEPS_71 += $(CONFIG)/inc/ejsCustomize.h
DEPS_71 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsLocalCache.o: \
    src/core/src/ejsLocalCache.c $(DEPS_71)
	@echo '   [Compile] $(CONFIG)/obj/ejsLocalCache.o'
	$(CC) -c -o $(CONFIG)/obj/ejsLocalCache.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsLocalCache.c

#
#   ejsMath.o
#
DEPS_72 += $(CONFIG)/inc/bit.h
DEPS_72 += $(CONFIG)/inc/mpr.h
DEPS_72 += $(CONFIG)/inc/http.h
DEPS_72 += $(CONFIG)/inc/ejsByteCode.h
DEPS_72 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_72 += $(CONFIG)/inc/ejs.slots.h
DEPS_72 += $(CONFIG)/inc/ejsCustomize.h
DEPS_72 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsMath.o: \
    src/core/src/ejsMath.c $(DEPS_72)
	@echo '   [Compile] $(CONFIG)/obj/ejsMath.o'
	$(CC) -c -o $(CONFIG)/obj/ejsMath.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsMath.c

#
#   ejsMemory.o
#
DEPS_73 += $(CONFIG)/inc/bit.h
DEPS_73 += $(CONFIG)/inc/mpr.h
DEPS_73 += $(CONFIG)/inc/http.h
DEPS_73 += $(CONFIG)/inc/ejsByteCode.h
DEPS_73 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_73 += $(CONFIG)/inc/ejs.slots.h
DEPS_73 += $(CONFIG)/inc/ejsCustomize.h
DEPS_73 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsMemory.o: \
    src/core/src/ejsMemory.c $(DEPS_73)
	@echo '   [Compile] $(CONFIG)/obj/ejsMemory.o'
	$(CC) -c -o $(CONFIG)/obj/ejsMemory.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsMemory.c

#
#   ejsMprLog.o
#
DEPS_74 += $(CONFIG)/inc/bit.h
DEPS_74 += $(CONFIG)/inc/mpr.h
DEPS_74 += $(CONFIG)/inc/http.h
DEPS_74 += $(CONFIG)/inc/ejsByteCode.h
DEPS_74 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_74 += $(CONFIG)/inc/ejs.slots.h
DEPS_74 += $(CONFIG)/inc/ejsCustomize.h
DEPS_74 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsMprLog.o: \
    src/core/src/ejsMprLog.c $(DEPS_74)
	@echo '   [Compile] $(CONFIG)/obj/ejsMprLog.o'
	$(CC) -c -o $(CONFIG)/obj/ejsMprLog.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsMprLog.c

#
#   ejsNamespace.o
#
DEPS_75 += $(CONFIG)/inc/bit.h
DEPS_75 += $(CONFIG)/inc/mpr.h
DEPS_75 += $(CONFIG)/inc/http.h
DEPS_75 += $(CONFIG)/inc/ejsByteCode.h
DEPS_75 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_75 += $(CONFIG)/inc/ejs.slots.h
DEPS_75 += $(CONFIG)/inc/ejsCustomize.h
DEPS_75 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsNamespace.o: \
    src/core/src/ejsNamespace.c $(DEPS_75)
	@echo '   [Compile] $(CONFIG)/obj/ejsNamespace.o'
	$(CC) -c -o $(CONFIG)/obj/ejsNamespace.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsNamespace.c

#
#   ejsNull.o
#
DEPS_76 += $(CONFIG)/inc/bit.h
DEPS_76 += $(CONFIG)/inc/mpr.h
DEPS_76 += $(CONFIG)/inc/http.h
DEPS_76 += $(CONFIG)/inc/ejsByteCode.h
DEPS_76 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_76 += $(CONFIG)/inc/ejs.slots.h
DEPS_76 += $(CONFIG)/inc/ejsCustomize.h
DEPS_76 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsNull.o: \
    src/core/src/ejsNull.c $(DEPS_76)
	@echo '   [Compile] $(CONFIG)/obj/ejsNull.o'
	$(CC) -c -o $(CONFIG)/obj/ejsNull.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsNull.c

#
#   ejsNumber.o
#
DEPS_77 += $(CONFIG)/inc/bit.h
DEPS_77 += $(CONFIG)/inc/mpr.h
DEPS_77 += $(CONFIG)/inc/http.h
DEPS_77 += $(CONFIG)/inc/ejsByteCode.h
DEPS_77 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_77 += $(CONFIG)/inc/ejs.slots.h
DEPS_77 += $(CONFIG)/inc/ejsCustomize.h
DEPS_77 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsNumber.o: \
    src/core/src/ejsNumber.c $(DEPS_77)
	@echo '   [Compile] $(CONFIG)/obj/ejsNumber.o'
	$(CC) -c -o $(CONFIG)/obj/ejsNumber.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsNumber.c

#
#   ejsObject.o
#
DEPS_78 += $(CONFIG)/inc/bit.h
DEPS_78 += $(CONFIG)/inc/mpr.h
DEPS_78 += $(CONFIG)/inc/http.h
DEPS_78 += $(CONFIG)/inc/ejsByteCode.h
DEPS_78 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_78 += $(CONFIG)/inc/ejs.slots.h
DEPS_78 += $(CONFIG)/inc/ejsCustomize.h
DEPS_78 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsObject.o: \
    src/core/src/ejsObject.c $(DEPS_78)
	@echo '   [Compile] $(CONFIG)/obj/ejsObject.o'
	$(CC) -c -o $(CONFIG)/obj/ejsObject.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsObject.c

#
#   ejsPath.o
#
DEPS_79 += $(CONFIG)/inc/bit.h
DEPS_79 += $(CONFIG)/inc/mpr.h
DEPS_79 += $(CONFIG)/inc/http.h
DEPS_79 += $(CONFIG)/inc/ejsByteCode.h
DEPS_79 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_79 += $(CONFIG)/inc/ejs.slots.h
DEPS_79 += $(CONFIG)/inc/ejsCustomize.h
DEPS_79 += $(CONFIG)/inc/ejs.h
DEPS_79 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/ejsPath.o: \
    src/core/src/ejsPath.c $(DEPS_79)
	@echo '   [Compile] $(CONFIG)/obj/ejsPath.o'
	$(CC) -c -o $(CONFIG)/obj/ejsPath.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsPath.c

#
#   ejsPot.o
#
DEPS_80 += $(CONFIG)/inc/bit.h
DEPS_80 += $(CONFIG)/inc/mpr.h
DEPS_80 += $(CONFIG)/inc/http.h
DEPS_80 += $(CONFIG)/inc/ejsByteCode.h
DEPS_80 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_80 += $(CONFIG)/inc/ejs.slots.h
DEPS_80 += $(CONFIG)/inc/ejsCustomize.h
DEPS_80 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsPot.o: \
    src/core/src/ejsPot.c $(DEPS_80)
	@echo '   [Compile] $(CONFIG)/obj/ejsPot.o'
	$(CC) -c -o $(CONFIG)/obj/ejsPot.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsPot.c

#
#   ejsRegExp.o
#
DEPS_81 += $(CONFIG)/inc/bit.h
DEPS_81 += $(CONFIG)/inc/mpr.h
DEPS_81 += $(CONFIG)/inc/http.h
DEPS_81 += $(CONFIG)/inc/ejsByteCode.h
DEPS_81 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_81 += $(CONFIG)/inc/ejs.slots.h
DEPS_81 += $(CONFIG)/inc/ejsCustomize.h
DEPS_81 += $(CONFIG)/inc/ejs.h
DEPS_81 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/ejsRegExp.o: \
    src/core/src/ejsRegExp.c $(DEPS_81)
	@echo '   [Compile] $(CONFIG)/obj/ejsRegExp.o'
	$(CC) -c -o $(CONFIG)/obj/ejsRegExp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsRegExp.c

#
#   ejsSocket.o
#
DEPS_82 += $(CONFIG)/inc/bit.h
DEPS_82 += $(CONFIG)/inc/mpr.h
DEPS_82 += $(CONFIG)/inc/http.h
DEPS_82 += $(CONFIG)/inc/ejsByteCode.h
DEPS_82 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_82 += $(CONFIG)/inc/ejs.slots.h
DEPS_82 += $(CONFIG)/inc/ejsCustomize.h
DEPS_82 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsSocket.o: \
    src/core/src/ejsSocket.c $(DEPS_82)
	@echo '   [Compile] $(CONFIG)/obj/ejsSocket.o'
	$(CC) -c -o $(CONFIG)/obj/ejsSocket.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsSocket.c

#
#   ejsString.o
#
DEPS_83 += $(CONFIG)/inc/bit.h
DEPS_83 += $(CONFIG)/inc/mpr.h
DEPS_83 += $(CONFIG)/inc/http.h
DEPS_83 += $(CONFIG)/inc/ejsByteCode.h
DEPS_83 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_83 += $(CONFIG)/inc/ejs.slots.h
DEPS_83 += $(CONFIG)/inc/ejsCustomize.h
DEPS_83 += $(CONFIG)/inc/ejs.h
DEPS_83 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/ejsString.o: \
    src/core/src/ejsString.c $(DEPS_83)
	@echo '   [Compile] $(CONFIG)/obj/ejsString.o'
	$(CC) -c -o $(CONFIG)/obj/ejsString.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsString.c

#
#   ejsSystem.o
#
DEPS_84 += $(CONFIG)/inc/bit.h
DEPS_84 += $(CONFIG)/inc/mpr.h
DEPS_84 += $(CONFIG)/inc/http.h
DEPS_84 += $(CONFIG)/inc/ejsByteCode.h
DEPS_84 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_84 += $(CONFIG)/inc/ejs.slots.h
DEPS_84 += $(CONFIG)/inc/ejsCustomize.h
DEPS_84 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsSystem.o: \
    src/core/src/ejsSystem.c $(DEPS_84)
	@echo '   [Compile] $(CONFIG)/obj/ejsSystem.o'
	$(CC) -c -o $(CONFIG)/obj/ejsSystem.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsSystem.c

#
#   ejsTimer.o
#
DEPS_85 += $(CONFIG)/inc/bit.h
DEPS_85 += $(CONFIG)/inc/mpr.h
DEPS_85 += $(CONFIG)/inc/http.h
DEPS_85 += $(CONFIG)/inc/ejsByteCode.h
DEPS_85 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_85 += $(CONFIG)/inc/ejs.slots.h
DEPS_85 += $(CONFIG)/inc/ejsCustomize.h
DEPS_85 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsTimer.o: \
    src/core/src/ejsTimer.c $(DEPS_85)
	@echo '   [Compile] $(CONFIG)/obj/ejsTimer.o'
	$(CC) -c -o $(CONFIG)/obj/ejsTimer.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsTimer.c

#
#   ejsType.o
#
DEPS_86 += $(CONFIG)/inc/bit.h
DEPS_86 += $(CONFIG)/inc/mpr.h
DEPS_86 += $(CONFIG)/inc/http.h
DEPS_86 += $(CONFIG)/inc/ejsByteCode.h
DEPS_86 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_86 += $(CONFIG)/inc/ejs.slots.h
DEPS_86 += $(CONFIG)/inc/ejsCustomize.h
DEPS_86 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsType.o: \
    src/core/src/ejsType.c $(DEPS_86)
	@echo '   [Compile] $(CONFIG)/obj/ejsType.o'
	$(CC) -c -o $(CONFIG)/obj/ejsType.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsType.c

#
#   ejsUri.o
#
DEPS_87 += $(CONFIG)/inc/bit.h
DEPS_87 += $(CONFIG)/inc/mpr.h
DEPS_87 += $(CONFIG)/inc/http.h
DEPS_87 += $(CONFIG)/inc/ejsByteCode.h
DEPS_87 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_87 += $(CONFIG)/inc/ejs.slots.h
DEPS_87 += $(CONFIG)/inc/ejsCustomize.h
DEPS_87 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsUri.o: \
    src/core/src/ejsUri.c $(DEPS_87)
	@echo '   [Compile] $(CONFIG)/obj/ejsUri.o'
	$(CC) -c -o $(CONFIG)/obj/ejsUri.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsUri.c

#
#   ejsVoid.o
#
DEPS_88 += $(CONFIG)/inc/bit.h
DEPS_88 += $(CONFIG)/inc/mpr.h
DEPS_88 += $(CONFIG)/inc/http.h
DEPS_88 += $(CONFIG)/inc/ejsByteCode.h
DEPS_88 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_88 += $(CONFIG)/inc/ejs.slots.h
DEPS_88 += $(CONFIG)/inc/ejsCustomize.h
DEPS_88 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsVoid.o: \
    src/core/src/ejsVoid.c $(DEPS_88)
	@echo '   [Compile] $(CONFIG)/obj/ejsVoid.o'
	$(CC) -c -o $(CONFIG)/obj/ejsVoid.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsVoid.c

#
#   ejsWebSocket.o
#
DEPS_89 += $(CONFIG)/inc/bit.h
DEPS_89 += $(CONFIG)/inc/mpr.h
DEPS_89 += $(CONFIG)/inc/http.h
DEPS_89 += $(CONFIG)/inc/ejsByteCode.h
DEPS_89 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_89 += $(CONFIG)/inc/ejs.slots.h
DEPS_89 += $(CONFIG)/inc/ejsCustomize.h
DEPS_89 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsWebSocket.o: \
    src/core/src/ejsWebSocket.c $(DEPS_89)
	@echo '   [Compile] $(CONFIG)/obj/ejsWebSocket.o'
	$(CC) -c -o $(CONFIG)/obj/ejsWebSocket.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsWebSocket.c

#
#   ejsWorker.o
#
DEPS_90 += $(CONFIG)/inc/bit.h
DEPS_90 += $(CONFIG)/inc/mpr.h
DEPS_90 += $(CONFIG)/inc/http.h
DEPS_90 += $(CONFIG)/inc/ejsByteCode.h
DEPS_90 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_90 += $(CONFIG)/inc/ejs.slots.h
DEPS_90 += $(CONFIG)/inc/ejsCustomize.h
DEPS_90 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsWorker.o: \
    src/core/src/ejsWorker.c $(DEPS_90)
	@echo '   [Compile] $(CONFIG)/obj/ejsWorker.o'
	$(CC) -c -o $(CONFIG)/obj/ejsWorker.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsWorker.c

#
#   ejsXML.o
#
DEPS_91 += $(CONFIG)/inc/bit.h
DEPS_91 += $(CONFIG)/inc/mpr.h
DEPS_91 += $(CONFIG)/inc/http.h
DEPS_91 += $(CONFIG)/inc/ejsByteCode.h
DEPS_91 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_91 += $(CONFIG)/inc/ejs.slots.h
DEPS_91 += $(CONFIG)/inc/ejsCustomize.h
DEPS_91 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsXML.o: \
    src/core/src/ejsXML.c $(DEPS_91)
	@echo '   [Compile] $(CONFIG)/obj/ejsXML.o'
	$(CC) -c -o $(CONFIG)/obj/ejsXML.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsXML.c

#
#   ejsXMLList.o
#
DEPS_92 += $(CONFIG)/inc/bit.h
DEPS_92 += $(CONFIG)/inc/mpr.h
DEPS_92 += $(CONFIG)/inc/http.h
DEPS_92 += $(CONFIG)/inc/ejsByteCode.h
DEPS_92 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_92 += $(CONFIG)/inc/ejs.slots.h
DEPS_92 += $(CONFIG)/inc/ejsCustomize.h
DEPS_92 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsXMLList.o: \
    src/core/src/ejsXMLList.c $(DEPS_92)
	@echo '   [Compile] $(CONFIG)/obj/ejsXMLList.o'
	$(CC) -c -o $(CONFIG)/obj/ejsXMLList.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsXMLList.c

#
#   ejsXMLLoader.o
#
DEPS_93 += $(CONFIG)/inc/bit.h
DEPS_93 += $(CONFIG)/inc/mpr.h
DEPS_93 += $(CONFIG)/inc/http.h
DEPS_93 += $(CONFIG)/inc/ejsByteCode.h
DEPS_93 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_93 += $(CONFIG)/inc/ejs.slots.h
DEPS_93 += $(CONFIG)/inc/ejsCustomize.h
DEPS_93 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsXMLLoader.o: \
    src/core/src/ejsXMLLoader.c $(DEPS_93)
	@echo '   [Compile] $(CONFIG)/obj/ejsXMLLoader.o'
	$(CC) -c -o $(CONFIG)/obj/ejsXMLLoader.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/core/src/ejsXMLLoader.c

#
#   ejsByteCode.o
#
DEPS_94 += $(CONFIG)/inc/bit.h
DEPS_94 += $(CONFIG)/inc/mpr.h
DEPS_94 += $(CONFIG)/inc/http.h
DEPS_94 += $(CONFIG)/inc/ejsByteCode.h
DEPS_94 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_94 += $(CONFIG)/inc/ejs.slots.h
DEPS_94 += $(CONFIG)/inc/ejsCustomize.h
DEPS_94 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsByteCode.o: \
    src/vm/ejsByteCode.c $(DEPS_94)
	@echo '   [Compile] $(CONFIG)/obj/ejsByteCode.o'
	$(CC) -c -o $(CONFIG)/obj/ejsByteCode.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsByteCode.c

#
#   ejsException.o
#
DEPS_95 += $(CONFIG)/inc/bit.h
DEPS_95 += $(CONFIG)/inc/mpr.h
DEPS_95 += $(CONFIG)/inc/http.h
DEPS_95 += $(CONFIG)/inc/ejsByteCode.h
DEPS_95 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_95 += $(CONFIG)/inc/ejs.slots.h
DEPS_95 += $(CONFIG)/inc/ejsCustomize.h
DEPS_95 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsException.o: \
    src/vm/ejsException.c $(DEPS_95)
	@echo '   [Compile] $(CONFIG)/obj/ejsException.o'
	$(CC) -c -o $(CONFIG)/obj/ejsException.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsException.c

#
#   ejsHelper.o
#
DEPS_96 += $(CONFIG)/inc/bit.h
DEPS_96 += $(CONFIG)/inc/mpr.h
DEPS_96 += $(CONFIG)/inc/http.h
DEPS_96 += $(CONFIG)/inc/ejsByteCode.h
DEPS_96 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_96 += $(CONFIG)/inc/ejs.slots.h
DEPS_96 += $(CONFIG)/inc/ejsCustomize.h
DEPS_96 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsHelper.o: \
    src/vm/ejsHelper.c $(DEPS_96)
	@echo '   [Compile] $(CONFIG)/obj/ejsHelper.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHelper.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsHelper.c

#
#   ejsInterp.o
#
DEPS_97 += $(CONFIG)/inc/bit.h
DEPS_97 += $(CONFIG)/inc/mpr.h
DEPS_97 += $(CONFIG)/inc/http.h
DEPS_97 += $(CONFIG)/inc/ejsByteCode.h
DEPS_97 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_97 += $(CONFIG)/inc/ejs.slots.h
DEPS_97 += $(CONFIG)/inc/ejsCustomize.h
DEPS_97 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsInterp.o: \
    src/vm/ejsInterp.c $(DEPS_97)
	@echo '   [Compile] $(CONFIG)/obj/ejsInterp.o'
	$(CC) -c -o $(CONFIG)/obj/ejsInterp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsInterp.c

#
#   ejsLoader.o
#
DEPS_98 += $(CONFIG)/inc/bit.h
DEPS_98 += $(CONFIG)/inc/mpr.h
DEPS_98 += $(CONFIG)/inc/http.h
DEPS_98 += $(CONFIG)/inc/ejsByteCode.h
DEPS_98 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_98 += $(CONFIG)/inc/ejs.slots.h
DEPS_98 += $(CONFIG)/inc/ejsCustomize.h
DEPS_98 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsLoader.o: \
    src/vm/ejsLoader.c $(DEPS_98)
	@echo '   [Compile] $(CONFIG)/obj/ejsLoader.o'
	$(CC) -c -o $(CONFIG)/obj/ejsLoader.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsLoader.c

#
#   ejsModule.o
#
DEPS_99 += $(CONFIG)/inc/bit.h
DEPS_99 += $(CONFIG)/inc/mpr.h
DEPS_99 += $(CONFIG)/inc/http.h
DEPS_99 += $(CONFIG)/inc/ejsByteCode.h
DEPS_99 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_99 += $(CONFIG)/inc/ejs.slots.h
DEPS_99 += $(CONFIG)/inc/ejsCustomize.h
DEPS_99 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsModule.o: \
    src/vm/ejsModule.c $(DEPS_99)
	@echo '   [Compile] $(CONFIG)/obj/ejsModule.o'
	$(CC) -c -o $(CONFIG)/obj/ejsModule.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsModule.c

#
#   ejsScope.o
#
DEPS_100 += $(CONFIG)/inc/bit.h
DEPS_100 += $(CONFIG)/inc/mpr.h
DEPS_100 += $(CONFIG)/inc/http.h
DEPS_100 += $(CONFIG)/inc/ejsByteCode.h
DEPS_100 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_100 += $(CONFIG)/inc/ejs.slots.h
DEPS_100 += $(CONFIG)/inc/ejsCustomize.h
DEPS_100 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsScope.o: \
    src/vm/ejsScope.c $(DEPS_100)
	@echo '   [Compile] $(CONFIG)/obj/ejsScope.o'
	$(CC) -c -o $(CONFIG)/obj/ejsScope.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsScope.c

#
#   ejsService.o
#
DEPS_101 += $(CONFIG)/inc/bit.h
DEPS_101 += $(CONFIG)/inc/mpr.h
DEPS_101 += $(CONFIG)/inc/http.h
DEPS_101 += $(CONFIG)/inc/ejsByteCode.h
DEPS_101 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_101 += $(CONFIG)/inc/ejs.slots.h
DEPS_101 += $(CONFIG)/inc/ejsCustomize.h
DEPS_101 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsService.o: \
    src/vm/ejsService.c $(DEPS_101)
	@echo '   [Compile] $(CONFIG)/obj/ejsService.o'
	$(CC) -c -o $(CONFIG)/obj/ejsService.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/vm/ejsService.c

#
#   libejs
#
DEPS_102 += $(CONFIG)/inc/mpr.h
DEPS_102 += $(CONFIG)/inc/bit.h
DEPS_102 += $(CONFIG)/inc/bitos.h
DEPS_102 += $(CONFIG)/obj/mprLib.o
DEPS_102 += $(CONFIG)/bin/libmpr.out
DEPS_102 += $(CONFIG)/inc/pcre.h
DEPS_102 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_102 += $(CONFIG)/bin/libpcre.out
endif
DEPS_102 += $(CONFIG)/inc/http.h
DEPS_102 += $(CONFIG)/obj/httpLib.o
DEPS_102 += $(CONFIG)/bin/libhttp.out
DEPS_102 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_102 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_102 += $(CONFIG)/inc/ejs.slots.h
DEPS_102 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_102 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_102 += $(CONFIG)/inc/ejsByteCode.h
DEPS_102 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_102 += $(CONFIG)/inc/ejsCustomize.h
DEPS_102 += $(CONFIG)/inc/ejs.h
DEPS_102 += $(CONFIG)/inc/ejsCompiler.h
DEPS_102 += $(CONFIG)/obj/ecAst.o
DEPS_102 += $(CONFIG)/obj/ecCodeGen.o
DEPS_102 += $(CONFIG)/obj/ecCompiler.o
DEPS_102 += $(CONFIG)/obj/ecLex.o
DEPS_102 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_102 += $(CONFIG)/obj/ecParser.o
DEPS_102 += $(CONFIG)/obj/ecState.o
DEPS_102 += $(CONFIG)/obj/dtoa.o
DEPS_102 += $(CONFIG)/obj/ejsApp.o
DEPS_102 += $(CONFIG)/obj/ejsArray.o
DEPS_102 += $(CONFIG)/obj/ejsBlock.o
DEPS_102 += $(CONFIG)/obj/ejsBoolean.o
DEPS_102 += $(CONFIG)/obj/ejsByteArray.o
DEPS_102 += $(CONFIG)/obj/ejsCache.o
DEPS_102 += $(CONFIG)/obj/ejsCmd.o
DEPS_102 += $(CONFIG)/obj/ejsConfig.o
DEPS_102 += $(CONFIG)/obj/ejsDate.o
DEPS_102 += $(CONFIG)/obj/ejsDebug.o
DEPS_102 += $(CONFIG)/obj/ejsError.o
DEPS_102 += $(CONFIG)/obj/ejsFile.o
DEPS_102 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_102 += $(CONFIG)/obj/ejsFrame.o
DEPS_102 += $(CONFIG)/obj/ejsFunction.o
DEPS_102 += $(CONFIG)/obj/ejsGC.o
DEPS_102 += $(CONFIG)/obj/ejsGlobal.o
DEPS_102 += $(CONFIG)/obj/ejsHttp.o
DEPS_102 += $(CONFIG)/obj/ejsIterator.o
DEPS_102 += $(CONFIG)/obj/ejsJSON.o
DEPS_102 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_102 += $(CONFIG)/obj/ejsMath.o
DEPS_102 += $(CONFIG)/obj/ejsMemory.o
DEPS_102 += $(CONFIG)/obj/ejsMprLog.o
DEPS_102 += $(CONFIG)/obj/ejsNamespace.o
DEPS_102 += $(CONFIG)/obj/ejsNull.o
DEPS_102 += $(CONFIG)/obj/ejsNumber.o
DEPS_102 += $(CONFIG)/obj/ejsObject.o
DEPS_102 += $(CONFIG)/obj/ejsPath.o
DEPS_102 += $(CONFIG)/obj/ejsPot.o
DEPS_102 += $(CONFIG)/obj/ejsRegExp.o
DEPS_102 += $(CONFIG)/obj/ejsSocket.o
DEPS_102 += $(CONFIG)/obj/ejsString.o
DEPS_102 += $(CONFIG)/obj/ejsSystem.o
DEPS_102 += $(CONFIG)/obj/ejsTimer.o
DEPS_102 += $(CONFIG)/obj/ejsType.o
DEPS_102 += $(CONFIG)/obj/ejsUri.o
DEPS_102 += $(CONFIG)/obj/ejsVoid.o
DEPS_102 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_102 += $(CONFIG)/obj/ejsWorker.o
DEPS_102 += $(CONFIG)/obj/ejsXML.o
DEPS_102 += $(CONFIG)/obj/ejsXMLList.o
DEPS_102 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_102 += $(CONFIG)/obj/ejsByteCode.o
DEPS_102 += $(CONFIG)/obj/ejsException.o
DEPS_102 += $(CONFIG)/obj/ejsHelper.o
DEPS_102 += $(CONFIG)/obj/ejsInterp.o
DEPS_102 += $(CONFIG)/obj/ejsLoader.o
DEPS_102 += $(CONFIG)/obj/ejsModule.o
DEPS_102 += $(CONFIG)/obj/ejsScope.o
DEPS_102 += $(CONFIG)/obj/ejsService.o

$(CONFIG)/bin/libejs.out: $(DEPS_102)
	@echo '      [Link] $(CONFIG)/bin/libejs.out'
	$(CC) -r -o $(CONFIG)/bin/libejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ecAst.o" "$(CONFIG)/obj/ecCodeGen.o" "$(CONFIG)/obj/ecCompiler.o" "$(CONFIG)/obj/ecLex.o" "$(CONFIG)/obj/ecModuleWrite.o" "$(CONFIG)/obj/ecParser.o" "$(CONFIG)/obj/ecState.o" "$(CONFIG)/obj/dtoa.o" "$(CONFIG)/obj/ejsApp.o" "$(CONFIG)/obj/ejsArray.o" "$(CONFIG)/obj/ejsBlock.o" "$(CONFIG)/obj/ejsBoolean.o" "$(CONFIG)/obj/ejsByteArray.o" "$(CONFIG)/obj/ejsCache.o" "$(CONFIG)/obj/ejsCmd.o" "$(CONFIG)/obj/ejsConfig.o" "$(CONFIG)/obj/ejsDate.o" "$(CONFIG)/obj/ejsDebug.o" "$(CONFIG)/obj/ejsError.o" "$(CONFIG)/obj/ejsFile.o" "$(CONFIG)/obj/ejsFileSystem.o" "$(CONFIG)/obj/ejsFrame.o" "$(CONFIG)/obj/ejsFunction.o" "$(CONFIG)/obj/ejsGC.o" "$(CONFIG)/obj/ejsGlobal.o" "$(CONFIG)/obj/ejsHttp.o" "$(CONFIG)/obj/ejsIterator.o" "$(CONFIG)/obj/ejsJSON.o" "$(CONFIG)/obj/ejsLocalCache.o" "$(CONFIG)/obj/ejsMath.o" "$(CONFIG)/obj/ejsMemory.o" "$(CONFIG)/obj/ejsMprLog.o" "$(CONFIG)/obj/ejsNamespace.o" "$(CONFIG)/obj/ejsNull.o" "$(CONFIG)/obj/ejsNumber.o" "$(CONFIG)/obj/ejsObject.o" "$(CONFIG)/obj/ejsPath.o" "$(CONFIG)/obj/ejsPot.o" "$(CONFIG)/obj/ejsRegExp.o" "$(CONFIG)/obj/ejsSocket.o" "$(CONFIG)/obj/ejsString.o" "$(CONFIG)/obj/ejsSystem.o" "$(CONFIG)/obj/ejsTimer.o" "$(CONFIG)/obj/ejsType.o" "$(CONFIG)/obj/ejsUri.o" "$(CONFIG)/obj/ejsVoid.o" "$(CONFIG)/obj/ejsWebSocket.o" "$(CONFIG)/obj/ejsWorker.o" "$(CONFIG)/obj/ejsXML.o" "$(CONFIG)/obj/ejsXMLList.o" "$(CONFIG)/obj/ejsXMLLoader.o" "$(CONFIG)/obj/ejsByteCode.o" "$(CONFIG)/obj/ejsException.o" "$(CONFIG)/obj/ejsHelper.o" "$(CONFIG)/obj/ejsInterp.o" "$(CONFIG)/obj/ejsLoader.o" "$(CONFIG)/obj/ejsModule.o" "$(CONFIG)/obj/ejsScope.o" "$(CONFIG)/obj/ejsService.o" $(LIBS) 

#
#   ejs.o
#
DEPS_103 += $(CONFIG)/inc/bit.h
DEPS_103 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ejs.o: \
    src/cmd/ejs.c $(DEPS_103)
	@echo '   [Compile] $(CONFIG)/obj/ejs.o'
	$(CC) -c -o $(CONFIG)/obj/ejs.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/cmd/ejs.c

#
#   ejs
#
DEPS_104 += $(CONFIG)/inc/mpr.h
DEPS_104 += $(CONFIG)/inc/bit.h
DEPS_104 += $(CONFIG)/inc/bitos.h
DEPS_104 += $(CONFIG)/obj/mprLib.o
DEPS_104 += $(CONFIG)/bin/libmpr.out
DEPS_104 += $(CONFIG)/inc/pcre.h
DEPS_104 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_104 += $(CONFIG)/bin/libpcre.out
endif
DEPS_104 += $(CONFIG)/inc/http.h
DEPS_104 += $(CONFIG)/obj/httpLib.o
DEPS_104 += $(CONFIG)/bin/libhttp.out
DEPS_104 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_104 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_104 += $(CONFIG)/inc/ejs.slots.h
DEPS_104 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_104 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_104 += $(CONFIG)/inc/ejsByteCode.h
DEPS_104 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_104 += $(CONFIG)/inc/ejsCustomize.h
DEPS_104 += $(CONFIG)/inc/ejs.h
DEPS_104 += $(CONFIG)/inc/ejsCompiler.h
DEPS_104 += $(CONFIG)/obj/ecAst.o
DEPS_104 += $(CONFIG)/obj/ecCodeGen.o
DEPS_104 += $(CONFIG)/obj/ecCompiler.o
DEPS_104 += $(CONFIG)/obj/ecLex.o
DEPS_104 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_104 += $(CONFIG)/obj/ecParser.o
DEPS_104 += $(CONFIG)/obj/ecState.o
DEPS_104 += $(CONFIG)/obj/dtoa.o
DEPS_104 += $(CONFIG)/obj/ejsApp.o
DEPS_104 += $(CONFIG)/obj/ejsArray.o
DEPS_104 += $(CONFIG)/obj/ejsBlock.o
DEPS_104 += $(CONFIG)/obj/ejsBoolean.o
DEPS_104 += $(CONFIG)/obj/ejsByteArray.o
DEPS_104 += $(CONFIG)/obj/ejsCache.o
DEPS_104 += $(CONFIG)/obj/ejsCmd.o
DEPS_104 += $(CONFIG)/obj/ejsConfig.o
DEPS_104 += $(CONFIG)/obj/ejsDate.o
DEPS_104 += $(CONFIG)/obj/ejsDebug.o
DEPS_104 += $(CONFIG)/obj/ejsError.o
DEPS_104 += $(CONFIG)/obj/ejsFile.o
DEPS_104 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_104 += $(CONFIG)/obj/ejsFrame.o
DEPS_104 += $(CONFIG)/obj/ejsFunction.o
DEPS_104 += $(CONFIG)/obj/ejsGC.o
DEPS_104 += $(CONFIG)/obj/ejsGlobal.o
DEPS_104 += $(CONFIG)/obj/ejsHttp.o
DEPS_104 += $(CONFIG)/obj/ejsIterator.o
DEPS_104 += $(CONFIG)/obj/ejsJSON.o
DEPS_104 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_104 += $(CONFIG)/obj/ejsMath.o
DEPS_104 += $(CONFIG)/obj/ejsMemory.o
DEPS_104 += $(CONFIG)/obj/ejsMprLog.o
DEPS_104 += $(CONFIG)/obj/ejsNamespace.o
DEPS_104 += $(CONFIG)/obj/ejsNull.o
DEPS_104 += $(CONFIG)/obj/ejsNumber.o
DEPS_104 += $(CONFIG)/obj/ejsObject.o
DEPS_104 += $(CONFIG)/obj/ejsPath.o
DEPS_104 += $(CONFIG)/obj/ejsPot.o
DEPS_104 += $(CONFIG)/obj/ejsRegExp.o
DEPS_104 += $(CONFIG)/obj/ejsSocket.o
DEPS_104 += $(CONFIG)/obj/ejsString.o
DEPS_104 += $(CONFIG)/obj/ejsSystem.o
DEPS_104 += $(CONFIG)/obj/ejsTimer.o
DEPS_104 += $(CONFIG)/obj/ejsType.o
DEPS_104 += $(CONFIG)/obj/ejsUri.o
DEPS_104 += $(CONFIG)/obj/ejsVoid.o
DEPS_104 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_104 += $(CONFIG)/obj/ejsWorker.o
DEPS_104 += $(CONFIG)/obj/ejsXML.o
DEPS_104 += $(CONFIG)/obj/ejsXMLList.o
DEPS_104 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_104 += $(CONFIG)/obj/ejsByteCode.o
DEPS_104 += $(CONFIG)/obj/ejsException.o
DEPS_104 += $(CONFIG)/obj/ejsHelper.o
DEPS_104 += $(CONFIG)/obj/ejsInterp.o
DEPS_104 += $(CONFIG)/obj/ejsLoader.o
DEPS_104 += $(CONFIG)/obj/ejsModule.o
DEPS_104 += $(CONFIG)/obj/ejsScope.o
DEPS_104 += $(CONFIG)/obj/ejsService.o
DEPS_104 += $(CONFIG)/bin/libejs.out
DEPS_104 += $(CONFIG)/obj/ejs.o

$(CONFIG)/bin/ejs.out: $(DEPS_104)
	@echo '      [Link] $(CONFIG)/bin/ejs.out'
	$(CC) -o $(CONFIG)/bin/ejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejs.o" $(LIBS) -Wl,-r 

#
#   ejsc.o
#
DEPS_105 += $(CONFIG)/inc/bit.h
DEPS_105 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ejsc.o: \
    src/cmd/ejsc.c $(DEPS_105)
	@echo '   [Compile] $(CONFIG)/obj/ejsc.o'
	$(CC) -c -o $(CONFIG)/obj/ejsc.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/cmd/ejsc.c

#
#   ejsc
#
DEPS_106 += $(CONFIG)/inc/mpr.h
DEPS_106 += $(CONFIG)/inc/bit.h
DEPS_106 += $(CONFIG)/inc/bitos.h
DEPS_106 += $(CONFIG)/obj/mprLib.o
DEPS_106 += $(CONFIG)/bin/libmpr.out
DEPS_106 += $(CONFIG)/inc/pcre.h
DEPS_106 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_106 += $(CONFIG)/bin/libpcre.out
endif
DEPS_106 += $(CONFIG)/inc/http.h
DEPS_106 += $(CONFIG)/obj/httpLib.o
DEPS_106 += $(CONFIG)/bin/libhttp.out
DEPS_106 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_106 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_106 += $(CONFIG)/inc/ejs.slots.h
DEPS_106 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_106 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_106 += $(CONFIG)/inc/ejsByteCode.h
DEPS_106 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_106 += $(CONFIG)/inc/ejsCustomize.h
DEPS_106 += $(CONFIG)/inc/ejs.h
DEPS_106 += $(CONFIG)/inc/ejsCompiler.h
DEPS_106 += $(CONFIG)/obj/ecAst.o
DEPS_106 += $(CONFIG)/obj/ecCodeGen.o
DEPS_106 += $(CONFIG)/obj/ecCompiler.o
DEPS_106 += $(CONFIG)/obj/ecLex.o
DEPS_106 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_106 += $(CONFIG)/obj/ecParser.o
DEPS_106 += $(CONFIG)/obj/ecState.o
DEPS_106 += $(CONFIG)/obj/dtoa.o
DEPS_106 += $(CONFIG)/obj/ejsApp.o
DEPS_106 += $(CONFIG)/obj/ejsArray.o
DEPS_106 += $(CONFIG)/obj/ejsBlock.o
DEPS_106 += $(CONFIG)/obj/ejsBoolean.o
DEPS_106 += $(CONFIG)/obj/ejsByteArray.o
DEPS_106 += $(CONFIG)/obj/ejsCache.o
DEPS_106 += $(CONFIG)/obj/ejsCmd.o
DEPS_106 += $(CONFIG)/obj/ejsConfig.o
DEPS_106 += $(CONFIG)/obj/ejsDate.o
DEPS_106 += $(CONFIG)/obj/ejsDebug.o
DEPS_106 += $(CONFIG)/obj/ejsError.o
DEPS_106 += $(CONFIG)/obj/ejsFile.o
DEPS_106 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_106 += $(CONFIG)/obj/ejsFrame.o
DEPS_106 += $(CONFIG)/obj/ejsFunction.o
DEPS_106 += $(CONFIG)/obj/ejsGC.o
DEPS_106 += $(CONFIG)/obj/ejsGlobal.o
DEPS_106 += $(CONFIG)/obj/ejsHttp.o
DEPS_106 += $(CONFIG)/obj/ejsIterator.o
DEPS_106 += $(CONFIG)/obj/ejsJSON.o
DEPS_106 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_106 += $(CONFIG)/obj/ejsMath.o
DEPS_106 += $(CONFIG)/obj/ejsMemory.o
DEPS_106 += $(CONFIG)/obj/ejsMprLog.o
DEPS_106 += $(CONFIG)/obj/ejsNamespace.o
DEPS_106 += $(CONFIG)/obj/ejsNull.o
DEPS_106 += $(CONFIG)/obj/ejsNumber.o
DEPS_106 += $(CONFIG)/obj/ejsObject.o
DEPS_106 += $(CONFIG)/obj/ejsPath.o
DEPS_106 += $(CONFIG)/obj/ejsPot.o
DEPS_106 += $(CONFIG)/obj/ejsRegExp.o
DEPS_106 += $(CONFIG)/obj/ejsSocket.o
DEPS_106 += $(CONFIG)/obj/ejsString.o
DEPS_106 += $(CONFIG)/obj/ejsSystem.o
DEPS_106 += $(CONFIG)/obj/ejsTimer.o
DEPS_106 += $(CONFIG)/obj/ejsType.o
DEPS_106 += $(CONFIG)/obj/ejsUri.o
DEPS_106 += $(CONFIG)/obj/ejsVoid.o
DEPS_106 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_106 += $(CONFIG)/obj/ejsWorker.o
DEPS_106 += $(CONFIG)/obj/ejsXML.o
DEPS_106 += $(CONFIG)/obj/ejsXMLList.o
DEPS_106 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_106 += $(CONFIG)/obj/ejsByteCode.o
DEPS_106 += $(CONFIG)/obj/ejsException.o
DEPS_106 += $(CONFIG)/obj/ejsHelper.o
DEPS_106 += $(CONFIG)/obj/ejsInterp.o
DEPS_106 += $(CONFIG)/obj/ejsLoader.o
DEPS_106 += $(CONFIG)/obj/ejsModule.o
DEPS_106 += $(CONFIG)/obj/ejsScope.o
DEPS_106 += $(CONFIG)/obj/ejsService.o
DEPS_106 += $(CONFIG)/bin/libejs.out
DEPS_106 += $(CONFIG)/obj/ejsc.o

$(CONFIG)/bin/ejsc.out: $(DEPS_106)
	@echo '      [Link] $(CONFIG)/bin/ejsc.out'
	$(CC) -o $(CONFIG)/bin/ejsc.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsc.o" $(LIBS) -Wl,-r 

#
#   ejsmod.h
#
src/cmd/ejsmod.h: $(DEPS_107)
	@echo '      [Copy] src/cmd/ejsmod.h'

#
#   ejsmod.o
#
DEPS_108 += $(CONFIG)/inc/bit.h
DEPS_108 += src/cmd/ejsmod.h
DEPS_108 += $(CONFIG)/inc/mpr.h
DEPS_108 += $(CONFIG)/inc/http.h
DEPS_108 += $(CONFIG)/inc/ejsByteCode.h
DEPS_108 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_108 += $(CONFIG)/inc/ejs.slots.h
DEPS_108 += $(CONFIG)/inc/ejsCustomize.h
DEPS_108 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsmod.o: \
    src/cmd/ejsmod.c $(DEPS_108)
	@echo '   [Compile] $(CONFIG)/obj/ejsmod.o'
	$(CC) -c -o $(CONFIG)/obj/ejsmod.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/cmd/ejsmod.c

#
#   doc.o
#
DEPS_109 += $(CONFIG)/inc/bit.h
DEPS_109 += src/cmd/ejsmod.h

$(CONFIG)/obj/doc.o: \
    src/cmd/doc.c $(DEPS_109)
	@echo '   [Compile] $(CONFIG)/obj/doc.o'
	$(CC) -c -o $(CONFIG)/obj/doc.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/cmd/doc.c

#
#   docFiles.o
#
DEPS_110 += $(CONFIG)/inc/bit.h
DEPS_110 += src/cmd/ejsmod.h

$(CONFIG)/obj/docFiles.o: \
    src/cmd/docFiles.c $(DEPS_110)
	@echo '   [Compile] $(CONFIG)/obj/docFiles.o'
	$(CC) -c -o $(CONFIG)/obj/docFiles.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/cmd/docFiles.c

#
#   listing.o
#
DEPS_111 += $(CONFIG)/inc/bit.h
DEPS_111 += src/cmd/ejsmod.h
DEPS_111 += $(CONFIG)/inc/ejsByteCodeTable.h

$(CONFIG)/obj/listing.o: \
    src/cmd/listing.c $(DEPS_111)
	@echo '   [Compile] $(CONFIG)/obj/listing.o'
	$(CC) -c -o $(CONFIG)/obj/listing.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/cmd/listing.c

#
#   slotGen.o
#
DEPS_112 += $(CONFIG)/inc/bit.h
DEPS_112 += src/cmd/ejsmod.h

$(CONFIG)/obj/slotGen.o: \
    src/cmd/slotGen.c $(DEPS_112)
	@echo '   [Compile] $(CONFIG)/obj/slotGen.o'
	$(CC) -c -o $(CONFIG)/obj/slotGen.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/cmd/slotGen.c

#
#   ejsmod
#
DEPS_113 += $(CONFIG)/inc/mpr.h
DEPS_113 += $(CONFIG)/inc/bit.h
DEPS_113 += $(CONFIG)/inc/bitos.h
DEPS_113 += $(CONFIG)/obj/mprLib.o
DEPS_113 += $(CONFIG)/bin/libmpr.out
DEPS_113 += $(CONFIG)/inc/pcre.h
DEPS_113 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_113 += $(CONFIG)/bin/libpcre.out
endif
DEPS_113 += $(CONFIG)/inc/http.h
DEPS_113 += $(CONFIG)/obj/httpLib.o
DEPS_113 += $(CONFIG)/bin/libhttp.out
DEPS_113 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_113 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_113 += $(CONFIG)/inc/ejs.slots.h
DEPS_113 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_113 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_113 += $(CONFIG)/inc/ejsByteCode.h
DEPS_113 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_113 += $(CONFIG)/inc/ejsCustomize.h
DEPS_113 += $(CONFIG)/inc/ejs.h
DEPS_113 += $(CONFIG)/inc/ejsCompiler.h
DEPS_113 += $(CONFIG)/obj/ecAst.o
DEPS_113 += $(CONFIG)/obj/ecCodeGen.o
DEPS_113 += $(CONFIG)/obj/ecCompiler.o
DEPS_113 += $(CONFIG)/obj/ecLex.o
DEPS_113 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_113 += $(CONFIG)/obj/ecParser.o
DEPS_113 += $(CONFIG)/obj/ecState.o
DEPS_113 += $(CONFIG)/obj/dtoa.o
DEPS_113 += $(CONFIG)/obj/ejsApp.o
DEPS_113 += $(CONFIG)/obj/ejsArray.o
DEPS_113 += $(CONFIG)/obj/ejsBlock.o
DEPS_113 += $(CONFIG)/obj/ejsBoolean.o
DEPS_113 += $(CONFIG)/obj/ejsByteArray.o
DEPS_113 += $(CONFIG)/obj/ejsCache.o
DEPS_113 += $(CONFIG)/obj/ejsCmd.o
DEPS_113 += $(CONFIG)/obj/ejsConfig.o
DEPS_113 += $(CONFIG)/obj/ejsDate.o
DEPS_113 += $(CONFIG)/obj/ejsDebug.o
DEPS_113 += $(CONFIG)/obj/ejsError.o
DEPS_113 += $(CONFIG)/obj/ejsFile.o
DEPS_113 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_113 += $(CONFIG)/obj/ejsFrame.o
DEPS_113 += $(CONFIG)/obj/ejsFunction.o
DEPS_113 += $(CONFIG)/obj/ejsGC.o
DEPS_113 += $(CONFIG)/obj/ejsGlobal.o
DEPS_113 += $(CONFIG)/obj/ejsHttp.o
DEPS_113 += $(CONFIG)/obj/ejsIterator.o
DEPS_113 += $(CONFIG)/obj/ejsJSON.o
DEPS_113 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_113 += $(CONFIG)/obj/ejsMath.o
DEPS_113 += $(CONFIG)/obj/ejsMemory.o
DEPS_113 += $(CONFIG)/obj/ejsMprLog.o
DEPS_113 += $(CONFIG)/obj/ejsNamespace.o
DEPS_113 += $(CONFIG)/obj/ejsNull.o
DEPS_113 += $(CONFIG)/obj/ejsNumber.o
DEPS_113 += $(CONFIG)/obj/ejsObject.o
DEPS_113 += $(CONFIG)/obj/ejsPath.o
DEPS_113 += $(CONFIG)/obj/ejsPot.o
DEPS_113 += $(CONFIG)/obj/ejsRegExp.o
DEPS_113 += $(CONFIG)/obj/ejsSocket.o
DEPS_113 += $(CONFIG)/obj/ejsString.o
DEPS_113 += $(CONFIG)/obj/ejsSystem.o
DEPS_113 += $(CONFIG)/obj/ejsTimer.o
DEPS_113 += $(CONFIG)/obj/ejsType.o
DEPS_113 += $(CONFIG)/obj/ejsUri.o
DEPS_113 += $(CONFIG)/obj/ejsVoid.o
DEPS_113 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_113 += $(CONFIG)/obj/ejsWorker.o
DEPS_113 += $(CONFIG)/obj/ejsXML.o
DEPS_113 += $(CONFIG)/obj/ejsXMLList.o
DEPS_113 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_113 += $(CONFIG)/obj/ejsByteCode.o
DEPS_113 += $(CONFIG)/obj/ejsException.o
DEPS_113 += $(CONFIG)/obj/ejsHelper.o
DEPS_113 += $(CONFIG)/obj/ejsInterp.o
DEPS_113 += $(CONFIG)/obj/ejsLoader.o
DEPS_113 += $(CONFIG)/obj/ejsModule.o
DEPS_113 += $(CONFIG)/obj/ejsScope.o
DEPS_113 += $(CONFIG)/obj/ejsService.o
DEPS_113 += $(CONFIG)/bin/libejs.out
DEPS_113 += src/cmd/ejsmod.h
DEPS_113 += $(CONFIG)/obj/ejsmod.o
DEPS_113 += $(CONFIG)/obj/doc.o
DEPS_113 += $(CONFIG)/obj/docFiles.o
DEPS_113 += $(CONFIG)/obj/listing.o
DEPS_113 += $(CONFIG)/obj/slotGen.o

$(CONFIG)/bin/ejsmod.out: $(DEPS_113)
	@echo '      [Link] $(CONFIG)/bin/ejsmod.out'
	$(CC) -o $(CONFIG)/bin/ejsmod.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsmod.o" "$(CONFIG)/obj/doc.o" "$(CONFIG)/obj/docFiles.o" "$(CONFIG)/obj/listing.o" "$(CONFIG)/obj/slotGen.o" $(LIBS) -Wl,-r 

#
#   ejsrun.o
#
DEPS_114 += $(CONFIG)/inc/bit.h
DEPS_114 += $(CONFIG)/inc/ejsCompiler.h

$(CONFIG)/obj/ejsrun.o: \
    src/cmd/ejsrun.c $(DEPS_114)
	@echo '   [Compile] $(CONFIG)/obj/ejsrun.o'
	$(CC) -c -o $(CONFIG)/obj/ejsrun.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/cmd/ejsrun.c

#
#   ejsrun
#
DEPS_115 += $(CONFIG)/inc/mpr.h
DEPS_115 += $(CONFIG)/inc/bit.h
DEPS_115 += $(CONFIG)/inc/bitos.h
DEPS_115 += $(CONFIG)/obj/mprLib.o
DEPS_115 += $(CONFIG)/bin/libmpr.out
DEPS_115 += $(CONFIG)/inc/pcre.h
DEPS_115 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_115 += $(CONFIG)/bin/libpcre.out
endif
DEPS_115 += $(CONFIG)/inc/http.h
DEPS_115 += $(CONFIG)/obj/httpLib.o
DEPS_115 += $(CONFIG)/bin/libhttp.out
DEPS_115 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_115 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_115 += $(CONFIG)/inc/ejs.slots.h
DEPS_115 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_115 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_115 += $(CONFIG)/inc/ejsByteCode.h
DEPS_115 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_115 += $(CONFIG)/inc/ejsCustomize.h
DEPS_115 += $(CONFIG)/inc/ejs.h
DEPS_115 += $(CONFIG)/inc/ejsCompiler.h
DEPS_115 += $(CONFIG)/obj/ecAst.o
DEPS_115 += $(CONFIG)/obj/ecCodeGen.o
DEPS_115 += $(CONFIG)/obj/ecCompiler.o
DEPS_115 += $(CONFIG)/obj/ecLex.o
DEPS_115 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_115 += $(CONFIG)/obj/ecParser.o
DEPS_115 += $(CONFIG)/obj/ecState.o
DEPS_115 += $(CONFIG)/obj/dtoa.o
DEPS_115 += $(CONFIG)/obj/ejsApp.o
DEPS_115 += $(CONFIG)/obj/ejsArray.o
DEPS_115 += $(CONFIG)/obj/ejsBlock.o
DEPS_115 += $(CONFIG)/obj/ejsBoolean.o
DEPS_115 += $(CONFIG)/obj/ejsByteArray.o
DEPS_115 += $(CONFIG)/obj/ejsCache.o
DEPS_115 += $(CONFIG)/obj/ejsCmd.o
DEPS_115 += $(CONFIG)/obj/ejsConfig.o
DEPS_115 += $(CONFIG)/obj/ejsDate.o
DEPS_115 += $(CONFIG)/obj/ejsDebug.o
DEPS_115 += $(CONFIG)/obj/ejsError.o
DEPS_115 += $(CONFIG)/obj/ejsFile.o
DEPS_115 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_115 += $(CONFIG)/obj/ejsFrame.o
DEPS_115 += $(CONFIG)/obj/ejsFunction.o
DEPS_115 += $(CONFIG)/obj/ejsGC.o
DEPS_115 += $(CONFIG)/obj/ejsGlobal.o
DEPS_115 += $(CONFIG)/obj/ejsHttp.o
DEPS_115 += $(CONFIG)/obj/ejsIterator.o
DEPS_115 += $(CONFIG)/obj/ejsJSON.o
DEPS_115 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_115 += $(CONFIG)/obj/ejsMath.o
DEPS_115 += $(CONFIG)/obj/ejsMemory.o
DEPS_115 += $(CONFIG)/obj/ejsMprLog.o
DEPS_115 += $(CONFIG)/obj/ejsNamespace.o
DEPS_115 += $(CONFIG)/obj/ejsNull.o
DEPS_115 += $(CONFIG)/obj/ejsNumber.o
DEPS_115 += $(CONFIG)/obj/ejsObject.o
DEPS_115 += $(CONFIG)/obj/ejsPath.o
DEPS_115 += $(CONFIG)/obj/ejsPot.o
DEPS_115 += $(CONFIG)/obj/ejsRegExp.o
DEPS_115 += $(CONFIG)/obj/ejsSocket.o
DEPS_115 += $(CONFIG)/obj/ejsString.o
DEPS_115 += $(CONFIG)/obj/ejsSystem.o
DEPS_115 += $(CONFIG)/obj/ejsTimer.o
DEPS_115 += $(CONFIG)/obj/ejsType.o
DEPS_115 += $(CONFIG)/obj/ejsUri.o
DEPS_115 += $(CONFIG)/obj/ejsVoid.o
DEPS_115 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_115 += $(CONFIG)/obj/ejsWorker.o
DEPS_115 += $(CONFIG)/obj/ejsXML.o
DEPS_115 += $(CONFIG)/obj/ejsXMLList.o
DEPS_115 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_115 += $(CONFIG)/obj/ejsByteCode.o
DEPS_115 += $(CONFIG)/obj/ejsException.o
DEPS_115 += $(CONFIG)/obj/ejsHelper.o
DEPS_115 += $(CONFIG)/obj/ejsInterp.o
DEPS_115 += $(CONFIG)/obj/ejsLoader.o
DEPS_115 += $(CONFIG)/obj/ejsModule.o
DEPS_115 += $(CONFIG)/obj/ejsScope.o
DEPS_115 += $(CONFIG)/obj/ejsService.o
DEPS_115 += $(CONFIG)/bin/libejs.out
DEPS_115 += $(CONFIG)/obj/ejsrun.o

$(CONFIG)/bin/ejsrun.out: $(DEPS_115)
	@echo '      [Link] $(CONFIG)/bin/ejsrun.out'
	$(CC) -o $(CONFIG)/bin/ejsrun.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsrun.o" $(LIBS) -Wl,-r 

#
#   ejs.mod
#
DEPS_116 += src/core/App.es
DEPS_116 += src/core/Args.es
DEPS_116 += src/core/Array.es
DEPS_116 += src/core/BinaryStream.es
DEPS_116 += src/core/Block.es
DEPS_116 += src/core/Boolean.es
DEPS_116 += src/core/ByteArray.es
DEPS_116 += src/core/Cache.es
DEPS_116 += src/core/Cmd.es
DEPS_116 += src/core/Compat.es
DEPS_116 += src/core/Config.es
DEPS_116 += src/core/Date.es
DEPS_116 += src/core/Debug.es
DEPS_116 += src/core/Emitter.es
DEPS_116 += src/core/Error.es
DEPS_116 += src/core/File.es
DEPS_116 += src/core/FileSystem.es
DEPS_116 += src/core/Frame.es
DEPS_116 += src/core/Function.es
DEPS_116 += src/core/GC.es
DEPS_116 += src/core/Global.es
DEPS_116 += src/core/Http.es
DEPS_116 += src/core/Inflector.es
DEPS_116 += src/core/Iterator.es
DEPS_116 += src/core/JSON.es
DEPS_116 += src/core/Loader.es
DEPS_116 += src/core/LocalCache.es
DEPS_116 += src/core/Locale.es
DEPS_116 += src/core/Logger.es
DEPS_116 += src/core/Math.es
DEPS_116 += src/core/Memory.es
DEPS_116 += src/core/MprLog.es
DEPS_116 += src/core/Name.es
DEPS_116 += src/core/Namespace.es
DEPS_116 += src/core/Null.es
DEPS_116 += src/core/Number.es
DEPS_116 += src/core/Object.es
DEPS_116 += src/core/Path.es
DEPS_116 += src/core/Promise.es
DEPS_116 += src/core/RegExp.es
DEPS_116 += src/core/Socket.es
DEPS_116 += src/core/Stream.es
DEPS_116 += src/core/String.es
DEPS_116 += src/core/System.es
DEPS_116 += src/core/TextStream.es
DEPS_116 += src/core/Timer.es
DEPS_116 += src/core/Type.es
DEPS_116 += src/core/Uri.es
DEPS_116 += src/core/Void.es
DEPS_116 += src/core/WebSocket.es
DEPS_116 += src/core/Worker.es
DEPS_116 += src/core/XML.es
DEPS_116 += src/core/XMLHttp.es
DEPS_116 += src/core/XMLList.es
DEPS_116 += $(CONFIG)/inc/mpr.h
DEPS_116 += $(CONFIG)/inc/bit.h
DEPS_116 += $(CONFIG)/inc/bitos.h
DEPS_116 += $(CONFIG)/obj/mprLib.o
DEPS_116 += $(CONFIG)/bin/libmpr.out
DEPS_116 += $(CONFIG)/inc/pcre.h
DEPS_116 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_116 += $(CONFIG)/bin/libpcre.out
endif
DEPS_116 += $(CONFIG)/inc/http.h
DEPS_116 += $(CONFIG)/obj/httpLib.o
DEPS_116 += $(CONFIG)/bin/libhttp.out
DEPS_116 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_116 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_116 += $(CONFIG)/inc/ejs.slots.h
DEPS_116 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_116 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_116 += $(CONFIG)/inc/ejsByteCode.h
DEPS_116 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_116 += $(CONFIG)/inc/ejsCustomize.h
DEPS_116 += $(CONFIG)/inc/ejs.h
DEPS_116 += $(CONFIG)/inc/ejsCompiler.h
DEPS_116 += $(CONFIG)/obj/ecAst.o
DEPS_116 += $(CONFIG)/obj/ecCodeGen.o
DEPS_116 += $(CONFIG)/obj/ecCompiler.o
DEPS_116 += $(CONFIG)/obj/ecLex.o
DEPS_116 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_116 += $(CONFIG)/obj/ecParser.o
DEPS_116 += $(CONFIG)/obj/ecState.o
DEPS_116 += $(CONFIG)/obj/dtoa.o
DEPS_116 += $(CONFIG)/obj/ejsApp.o
DEPS_116 += $(CONFIG)/obj/ejsArray.o
DEPS_116 += $(CONFIG)/obj/ejsBlock.o
DEPS_116 += $(CONFIG)/obj/ejsBoolean.o
DEPS_116 += $(CONFIG)/obj/ejsByteArray.o
DEPS_116 += $(CONFIG)/obj/ejsCache.o
DEPS_116 += $(CONFIG)/obj/ejsCmd.o
DEPS_116 += $(CONFIG)/obj/ejsConfig.o
DEPS_116 += $(CONFIG)/obj/ejsDate.o
DEPS_116 += $(CONFIG)/obj/ejsDebug.o
DEPS_116 += $(CONFIG)/obj/ejsError.o
DEPS_116 += $(CONFIG)/obj/ejsFile.o
DEPS_116 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_116 += $(CONFIG)/obj/ejsFrame.o
DEPS_116 += $(CONFIG)/obj/ejsFunction.o
DEPS_116 += $(CONFIG)/obj/ejsGC.o
DEPS_116 += $(CONFIG)/obj/ejsGlobal.o
DEPS_116 += $(CONFIG)/obj/ejsHttp.o
DEPS_116 += $(CONFIG)/obj/ejsIterator.o
DEPS_116 += $(CONFIG)/obj/ejsJSON.o
DEPS_116 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_116 += $(CONFIG)/obj/ejsMath.o
DEPS_116 += $(CONFIG)/obj/ejsMemory.o
DEPS_116 += $(CONFIG)/obj/ejsMprLog.o
DEPS_116 += $(CONFIG)/obj/ejsNamespace.o
DEPS_116 += $(CONFIG)/obj/ejsNull.o
DEPS_116 += $(CONFIG)/obj/ejsNumber.o
DEPS_116 += $(CONFIG)/obj/ejsObject.o
DEPS_116 += $(CONFIG)/obj/ejsPath.o
DEPS_116 += $(CONFIG)/obj/ejsPot.o
DEPS_116 += $(CONFIG)/obj/ejsRegExp.o
DEPS_116 += $(CONFIG)/obj/ejsSocket.o
DEPS_116 += $(CONFIG)/obj/ejsString.o
DEPS_116 += $(CONFIG)/obj/ejsSystem.o
DEPS_116 += $(CONFIG)/obj/ejsTimer.o
DEPS_116 += $(CONFIG)/obj/ejsType.o
DEPS_116 += $(CONFIG)/obj/ejsUri.o
DEPS_116 += $(CONFIG)/obj/ejsVoid.o
DEPS_116 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_116 += $(CONFIG)/obj/ejsWorker.o
DEPS_116 += $(CONFIG)/obj/ejsXML.o
DEPS_116 += $(CONFIG)/obj/ejsXMLList.o
DEPS_116 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_116 += $(CONFIG)/obj/ejsByteCode.o
DEPS_116 += $(CONFIG)/obj/ejsException.o
DEPS_116 += $(CONFIG)/obj/ejsHelper.o
DEPS_116 += $(CONFIG)/obj/ejsInterp.o
DEPS_116 += $(CONFIG)/obj/ejsLoader.o
DEPS_116 += $(CONFIG)/obj/ejsModule.o
DEPS_116 += $(CONFIG)/obj/ejsScope.o
DEPS_116 += $(CONFIG)/obj/ejsService.o
DEPS_116 += $(CONFIG)/bin/libejs.out
DEPS_116 += $(CONFIG)/obj/ejsc.o
DEPS_116 += $(CONFIG)/bin/ejsc.out
DEPS_116 += src/cmd/ejsmod.h
DEPS_116 += $(CONFIG)/obj/ejsmod.o
DEPS_116 += $(CONFIG)/obj/doc.o
DEPS_116 += $(CONFIG)/obj/docFiles.o
DEPS_116 += $(CONFIG)/obj/listing.o
DEPS_116 += $(CONFIG)/obj/slotGen.o
DEPS_116 += $(CONFIG)/bin/ejsmod.out

$(CONFIG)/bin/ejs.mod: $(DEPS_116)
	( \
	cd src/core; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.mod  --optimize 9 --bind --require null *.es  ; \
	../../$(CONFIG)/bin/ejsmod --require null --cslots ../../$(CONFIG)/bin/ejs.mod ; \
	if ! diff ejs.slots.h ../../$(CONFIG)/inc/ejs.slots.h >/dev/null; then cp ejs.slots.h ../../$(CONFIG)/inc; fi ; \
	rm -f ejs.slots.h ; \
	)

#
#   ejs.unix.mod
#
DEPS_117 += src/ejs.unix/Unix.es
DEPS_117 += $(CONFIG)/inc/mpr.h
DEPS_117 += $(CONFIG)/inc/bit.h
DEPS_117 += $(CONFIG)/inc/bitos.h
DEPS_117 += $(CONFIG)/obj/mprLib.o
DEPS_117 += $(CONFIG)/bin/libmpr.out
DEPS_117 += $(CONFIG)/inc/pcre.h
DEPS_117 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_117 += $(CONFIG)/bin/libpcre.out
endif
DEPS_117 += $(CONFIG)/inc/http.h
DEPS_117 += $(CONFIG)/obj/httpLib.o
DEPS_117 += $(CONFIG)/bin/libhttp.out
DEPS_117 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_117 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_117 += $(CONFIG)/inc/ejs.slots.h
DEPS_117 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_117 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_117 += $(CONFIG)/inc/ejsByteCode.h
DEPS_117 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_117 += $(CONFIG)/inc/ejsCustomize.h
DEPS_117 += $(CONFIG)/inc/ejs.h
DEPS_117 += $(CONFIG)/inc/ejsCompiler.h
DEPS_117 += $(CONFIG)/obj/ecAst.o
DEPS_117 += $(CONFIG)/obj/ecCodeGen.o
DEPS_117 += $(CONFIG)/obj/ecCompiler.o
DEPS_117 += $(CONFIG)/obj/ecLex.o
DEPS_117 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_117 += $(CONFIG)/obj/ecParser.o
DEPS_117 += $(CONFIG)/obj/ecState.o
DEPS_117 += $(CONFIG)/obj/dtoa.o
DEPS_117 += $(CONFIG)/obj/ejsApp.o
DEPS_117 += $(CONFIG)/obj/ejsArray.o
DEPS_117 += $(CONFIG)/obj/ejsBlock.o
DEPS_117 += $(CONFIG)/obj/ejsBoolean.o
DEPS_117 += $(CONFIG)/obj/ejsByteArray.o
DEPS_117 += $(CONFIG)/obj/ejsCache.o
DEPS_117 += $(CONFIG)/obj/ejsCmd.o
DEPS_117 += $(CONFIG)/obj/ejsConfig.o
DEPS_117 += $(CONFIG)/obj/ejsDate.o
DEPS_117 += $(CONFIG)/obj/ejsDebug.o
DEPS_117 += $(CONFIG)/obj/ejsError.o
DEPS_117 += $(CONFIG)/obj/ejsFile.o
DEPS_117 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_117 += $(CONFIG)/obj/ejsFrame.o
DEPS_117 += $(CONFIG)/obj/ejsFunction.o
DEPS_117 += $(CONFIG)/obj/ejsGC.o
DEPS_117 += $(CONFIG)/obj/ejsGlobal.o
DEPS_117 += $(CONFIG)/obj/ejsHttp.o
DEPS_117 += $(CONFIG)/obj/ejsIterator.o
DEPS_117 += $(CONFIG)/obj/ejsJSON.o
DEPS_117 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_117 += $(CONFIG)/obj/ejsMath.o
DEPS_117 += $(CONFIG)/obj/ejsMemory.o
DEPS_117 += $(CONFIG)/obj/ejsMprLog.o
DEPS_117 += $(CONFIG)/obj/ejsNamespace.o
DEPS_117 += $(CONFIG)/obj/ejsNull.o
DEPS_117 += $(CONFIG)/obj/ejsNumber.o
DEPS_117 += $(CONFIG)/obj/ejsObject.o
DEPS_117 += $(CONFIG)/obj/ejsPath.o
DEPS_117 += $(CONFIG)/obj/ejsPot.o
DEPS_117 += $(CONFIG)/obj/ejsRegExp.o
DEPS_117 += $(CONFIG)/obj/ejsSocket.o
DEPS_117 += $(CONFIG)/obj/ejsString.o
DEPS_117 += $(CONFIG)/obj/ejsSystem.o
DEPS_117 += $(CONFIG)/obj/ejsTimer.o
DEPS_117 += $(CONFIG)/obj/ejsType.o
DEPS_117 += $(CONFIG)/obj/ejsUri.o
DEPS_117 += $(CONFIG)/obj/ejsVoid.o
DEPS_117 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_117 += $(CONFIG)/obj/ejsWorker.o
DEPS_117 += $(CONFIG)/obj/ejsXML.o
DEPS_117 += $(CONFIG)/obj/ejsXMLList.o
DEPS_117 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_117 += $(CONFIG)/obj/ejsByteCode.o
DEPS_117 += $(CONFIG)/obj/ejsException.o
DEPS_117 += $(CONFIG)/obj/ejsHelper.o
DEPS_117 += $(CONFIG)/obj/ejsInterp.o
DEPS_117 += $(CONFIG)/obj/ejsLoader.o
DEPS_117 += $(CONFIG)/obj/ejsModule.o
DEPS_117 += $(CONFIG)/obj/ejsScope.o
DEPS_117 += $(CONFIG)/obj/ejsService.o
DEPS_117 += $(CONFIG)/bin/libejs.out
DEPS_117 += $(CONFIG)/obj/ejsc.o
DEPS_117 += $(CONFIG)/bin/ejsc.out
DEPS_117 += src/cmd/ejsmod.h
DEPS_117 += $(CONFIG)/obj/ejsmod.o
DEPS_117 += $(CONFIG)/obj/doc.o
DEPS_117 += $(CONFIG)/obj/docFiles.o
DEPS_117 += $(CONFIG)/obj/listing.o
DEPS_117 += $(CONFIG)/obj/slotGen.o
DEPS_117 += $(CONFIG)/bin/ejsmod.out
DEPS_117 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.unix.mod: $(DEPS_117)
	( \
	cd src/ejs.unix; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.unix.mod  --optimize 9 Unix.es ; \
	)

#
#   ejs.db.mod
#
DEPS_118 += src/ejs.db/Database.es
DEPS_118 += src/ejs.db/DatabaseConnector.es
DEPS_118 += $(CONFIG)/inc/mpr.h
DEPS_118 += $(CONFIG)/inc/bit.h
DEPS_118 += $(CONFIG)/inc/bitos.h
DEPS_118 += $(CONFIG)/obj/mprLib.o
DEPS_118 += $(CONFIG)/bin/libmpr.out
DEPS_118 += $(CONFIG)/inc/pcre.h
DEPS_118 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_118 += $(CONFIG)/bin/libpcre.out
endif
DEPS_118 += $(CONFIG)/inc/http.h
DEPS_118 += $(CONFIG)/obj/httpLib.o
DEPS_118 += $(CONFIG)/bin/libhttp.out
DEPS_118 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_118 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_118 += $(CONFIG)/inc/ejs.slots.h
DEPS_118 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_118 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_118 += $(CONFIG)/inc/ejsByteCode.h
DEPS_118 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_118 += $(CONFIG)/inc/ejsCustomize.h
DEPS_118 += $(CONFIG)/inc/ejs.h
DEPS_118 += $(CONFIG)/inc/ejsCompiler.h
DEPS_118 += $(CONFIG)/obj/ecAst.o
DEPS_118 += $(CONFIG)/obj/ecCodeGen.o
DEPS_118 += $(CONFIG)/obj/ecCompiler.o
DEPS_118 += $(CONFIG)/obj/ecLex.o
DEPS_118 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_118 += $(CONFIG)/obj/ecParser.o
DEPS_118 += $(CONFIG)/obj/ecState.o
DEPS_118 += $(CONFIG)/obj/dtoa.o
DEPS_118 += $(CONFIG)/obj/ejsApp.o
DEPS_118 += $(CONFIG)/obj/ejsArray.o
DEPS_118 += $(CONFIG)/obj/ejsBlock.o
DEPS_118 += $(CONFIG)/obj/ejsBoolean.o
DEPS_118 += $(CONFIG)/obj/ejsByteArray.o
DEPS_118 += $(CONFIG)/obj/ejsCache.o
DEPS_118 += $(CONFIG)/obj/ejsCmd.o
DEPS_118 += $(CONFIG)/obj/ejsConfig.o
DEPS_118 += $(CONFIG)/obj/ejsDate.o
DEPS_118 += $(CONFIG)/obj/ejsDebug.o
DEPS_118 += $(CONFIG)/obj/ejsError.o
DEPS_118 += $(CONFIG)/obj/ejsFile.o
DEPS_118 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_118 += $(CONFIG)/obj/ejsFrame.o
DEPS_118 += $(CONFIG)/obj/ejsFunction.o
DEPS_118 += $(CONFIG)/obj/ejsGC.o
DEPS_118 += $(CONFIG)/obj/ejsGlobal.o
DEPS_118 += $(CONFIG)/obj/ejsHttp.o
DEPS_118 += $(CONFIG)/obj/ejsIterator.o
DEPS_118 += $(CONFIG)/obj/ejsJSON.o
DEPS_118 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_118 += $(CONFIG)/obj/ejsMath.o
DEPS_118 += $(CONFIG)/obj/ejsMemory.o
DEPS_118 += $(CONFIG)/obj/ejsMprLog.o
DEPS_118 += $(CONFIG)/obj/ejsNamespace.o
DEPS_118 += $(CONFIG)/obj/ejsNull.o
DEPS_118 += $(CONFIG)/obj/ejsNumber.o
DEPS_118 += $(CONFIG)/obj/ejsObject.o
DEPS_118 += $(CONFIG)/obj/ejsPath.o
DEPS_118 += $(CONFIG)/obj/ejsPot.o
DEPS_118 += $(CONFIG)/obj/ejsRegExp.o
DEPS_118 += $(CONFIG)/obj/ejsSocket.o
DEPS_118 += $(CONFIG)/obj/ejsString.o
DEPS_118 += $(CONFIG)/obj/ejsSystem.o
DEPS_118 += $(CONFIG)/obj/ejsTimer.o
DEPS_118 += $(CONFIG)/obj/ejsType.o
DEPS_118 += $(CONFIG)/obj/ejsUri.o
DEPS_118 += $(CONFIG)/obj/ejsVoid.o
DEPS_118 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_118 += $(CONFIG)/obj/ejsWorker.o
DEPS_118 += $(CONFIG)/obj/ejsXML.o
DEPS_118 += $(CONFIG)/obj/ejsXMLList.o
DEPS_118 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_118 += $(CONFIG)/obj/ejsByteCode.o
DEPS_118 += $(CONFIG)/obj/ejsException.o
DEPS_118 += $(CONFIG)/obj/ejsHelper.o
DEPS_118 += $(CONFIG)/obj/ejsInterp.o
DEPS_118 += $(CONFIG)/obj/ejsLoader.o
DEPS_118 += $(CONFIG)/obj/ejsModule.o
DEPS_118 += $(CONFIG)/obj/ejsScope.o
DEPS_118 += $(CONFIG)/obj/ejsService.o
DEPS_118 += $(CONFIG)/bin/libejs.out
DEPS_118 += $(CONFIG)/obj/ejsc.o
DEPS_118 += $(CONFIG)/bin/ejsc.out
DEPS_118 += src/cmd/ejsmod.h
DEPS_118 += $(CONFIG)/obj/ejsmod.o
DEPS_118 += $(CONFIG)/obj/doc.o
DEPS_118 += $(CONFIG)/obj/docFiles.o
DEPS_118 += $(CONFIG)/obj/listing.o
DEPS_118 += $(CONFIG)/obj/slotGen.o
DEPS_118 += $(CONFIG)/bin/ejsmod.out
DEPS_118 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.db.mod: $(DEPS_118)
	( \
	cd src/ejs.db; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.db.mod  --optimize 9 *.es ; \
	)

#
#   ejs.db.mapper.mod
#
DEPS_119 += src/ejs.db.mapper/Record.es
DEPS_119 += $(CONFIG)/inc/mpr.h
DEPS_119 += $(CONFIG)/inc/bit.h
DEPS_119 += $(CONFIG)/inc/bitos.h
DEPS_119 += $(CONFIG)/obj/mprLib.o
DEPS_119 += $(CONFIG)/bin/libmpr.out
DEPS_119 += $(CONFIG)/inc/pcre.h
DEPS_119 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_119 += $(CONFIG)/bin/libpcre.out
endif
DEPS_119 += $(CONFIG)/inc/http.h
DEPS_119 += $(CONFIG)/obj/httpLib.o
DEPS_119 += $(CONFIG)/bin/libhttp.out
DEPS_119 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_119 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_119 += $(CONFIG)/inc/ejs.slots.h
DEPS_119 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_119 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_119 += $(CONFIG)/inc/ejsByteCode.h
DEPS_119 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_119 += $(CONFIG)/inc/ejsCustomize.h
DEPS_119 += $(CONFIG)/inc/ejs.h
DEPS_119 += $(CONFIG)/inc/ejsCompiler.h
DEPS_119 += $(CONFIG)/obj/ecAst.o
DEPS_119 += $(CONFIG)/obj/ecCodeGen.o
DEPS_119 += $(CONFIG)/obj/ecCompiler.o
DEPS_119 += $(CONFIG)/obj/ecLex.o
DEPS_119 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_119 += $(CONFIG)/obj/ecParser.o
DEPS_119 += $(CONFIG)/obj/ecState.o
DEPS_119 += $(CONFIG)/obj/dtoa.o
DEPS_119 += $(CONFIG)/obj/ejsApp.o
DEPS_119 += $(CONFIG)/obj/ejsArray.o
DEPS_119 += $(CONFIG)/obj/ejsBlock.o
DEPS_119 += $(CONFIG)/obj/ejsBoolean.o
DEPS_119 += $(CONFIG)/obj/ejsByteArray.o
DEPS_119 += $(CONFIG)/obj/ejsCache.o
DEPS_119 += $(CONFIG)/obj/ejsCmd.o
DEPS_119 += $(CONFIG)/obj/ejsConfig.o
DEPS_119 += $(CONFIG)/obj/ejsDate.o
DEPS_119 += $(CONFIG)/obj/ejsDebug.o
DEPS_119 += $(CONFIG)/obj/ejsError.o
DEPS_119 += $(CONFIG)/obj/ejsFile.o
DEPS_119 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_119 += $(CONFIG)/obj/ejsFrame.o
DEPS_119 += $(CONFIG)/obj/ejsFunction.o
DEPS_119 += $(CONFIG)/obj/ejsGC.o
DEPS_119 += $(CONFIG)/obj/ejsGlobal.o
DEPS_119 += $(CONFIG)/obj/ejsHttp.o
DEPS_119 += $(CONFIG)/obj/ejsIterator.o
DEPS_119 += $(CONFIG)/obj/ejsJSON.o
DEPS_119 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_119 += $(CONFIG)/obj/ejsMath.o
DEPS_119 += $(CONFIG)/obj/ejsMemory.o
DEPS_119 += $(CONFIG)/obj/ejsMprLog.o
DEPS_119 += $(CONFIG)/obj/ejsNamespace.o
DEPS_119 += $(CONFIG)/obj/ejsNull.o
DEPS_119 += $(CONFIG)/obj/ejsNumber.o
DEPS_119 += $(CONFIG)/obj/ejsObject.o
DEPS_119 += $(CONFIG)/obj/ejsPath.o
DEPS_119 += $(CONFIG)/obj/ejsPot.o
DEPS_119 += $(CONFIG)/obj/ejsRegExp.o
DEPS_119 += $(CONFIG)/obj/ejsSocket.o
DEPS_119 += $(CONFIG)/obj/ejsString.o
DEPS_119 += $(CONFIG)/obj/ejsSystem.o
DEPS_119 += $(CONFIG)/obj/ejsTimer.o
DEPS_119 += $(CONFIG)/obj/ejsType.o
DEPS_119 += $(CONFIG)/obj/ejsUri.o
DEPS_119 += $(CONFIG)/obj/ejsVoid.o
DEPS_119 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_119 += $(CONFIG)/obj/ejsWorker.o
DEPS_119 += $(CONFIG)/obj/ejsXML.o
DEPS_119 += $(CONFIG)/obj/ejsXMLList.o
DEPS_119 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_119 += $(CONFIG)/obj/ejsByteCode.o
DEPS_119 += $(CONFIG)/obj/ejsException.o
DEPS_119 += $(CONFIG)/obj/ejsHelper.o
DEPS_119 += $(CONFIG)/obj/ejsInterp.o
DEPS_119 += $(CONFIG)/obj/ejsLoader.o
DEPS_119 += $(CONFIG)/obj/ejsModule.o
DEPS_119 += $(CONFIG)/obj/ejsScope.o
DEPS_119 += $(CONFIG)/obj/ejsService.o
DEPS_119 += $(CONFIG)/bin/libejs.out
DEPS_119 += $(CONFIG)/obj/ejsc.o
DEPS_119 += $(CONFIG)/bin/ejsc.out
DEPS_119 += src/cmd/ejsmod.h
DEPS_119 += $(CONFIG)/obj/ejsmod.o
DEPS_119 += $(CONFIG)/obj/doc.o
DEPS_119 += $(CONFIG)/obj/docFiles.o
DEPS_119 += $(CONFIG)/obj/listing.o
DEPS_119 += $(CONFIG)/obj/slotGen.o
DEPS_119 += $(CONFIG)/bin/ejsmod.out
DEPS_119 += $(CONFIG)/bin/ejs.mod
DEPS_119 += $(CONFIG)/bin/ejs.db.mod

$(CONFIG)/bin/ejs.db.mapper.mod: $(DEPS_119)
	( \
	cd src/ejs.db.mapper; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.db.mapper.mod  --optimize 9 *.es ; \
	)

#
#   ejs.db.sqlite.mod
#
DEPS_120 += src/ejs.db.sqlite/Sqlite.es
DEPS_120 += $(CONFIG)/inc/mpr.h
DEPS_120 += $(CONFIG)/inc/bit.h
DEPS_120 += $(CONFIG)/inc/bitos.h
DEPS_120 += $(CONFIG)/obj/mprLib.o
DEPS_120 += $(CONFIG)/bin/libmpr.out
DEPS_120 += $(CONFIG)/inc/pcre.h
DEPS_120 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_120 += $(CONFIG)/bin/libpcre.out
endif
DEPS_120 += $(CONFIG)/inc/http.h
DEPS_120 += $(CONFIG)/obj/httpLib.o
DEPS_120 += $(CONFIG)/bin/libhttp.out
DEPS_120 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_120 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_120 += $(CONFIG)/inc/ejs.slots.h
DEPS_120 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_120 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_120 += $(CONFIG)/inc/ejsByteCode.h
DEPS_120 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_120 += $(CONFIG)/inc/ejsCustomize.h
DEPS_120 += $(CONFIG)/inc/ejs.h
DEPS_120 += $(CONFIG)/inc/ejsCompiler.h
DEPS_120 += $(CONFIG)/obj/ecAst.o
DEPS_120 += $(CONFIG)/obj/ecCodeGen.o
DEPS_120 += $(CONFIG)/obj/ecCompiler.o
DEPS_120 += $(CONFIG)/obj/ecLex.o
DEPS_120 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_120 += $(CONFIG)/obj/ecParser.o
DEPS_120 += $(CONFIG)/obj/ecState.o
DEPS_120 += $(CONFIG)/obj/dtoa.o
DEPS_120 += $(CONFIG)/obj/ejsApp.o
DEPS_120 += $(CONFIG)/obj/ejsArray.o
DEPS_120 += $(CONFIG)/obj/ejsBlock.o
DEPS_120 += $(CONFIG)/obj/ejsBoolean.o
DEPS_120 += $(CONFIG)/obj/ejsByteArray.o
DEPS_120 += $(CONFIG)/obj/ejsCache.o
DEPS_120 += $(CONFIG)/obj/ejsCmd.o
DEPS_120 += $(CONFIG)/obj/ejsConfig.o
DEPS_120 += $(CONFIG)/obj/ejsDate.o
DEPS_120 += $(CONFIG)/obj/ejsDebug.o
DEPS_120 += $(CONFIG)/obj/ejsError.o
DEPS_120 += $(CONFIG)/obj/ejsFile.o
DEPS_120 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_120 += $(CONFIG)/obj/ejsFrame.o
DEPS_120 += $(CONFIG)/obj/ejsFunction.o
DEPS_120 += $(CONFIG)/obj/ejsGC.o
DEPS_120 += $(CONFIG)/obj/ejsGlobal.o
DEPS_120 += $(CONFIG)/obj/ejsHttp.o
DEPS_120 += $(CONFIG)/obj/ejsIterator.o
DEPS_120 += $(CONFIG)/obj/ejsJSON.o
DEPS_120 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_120 += $(CONFIG)/obj/ejsMath.o
DEPS_120 += $(CONFIG)/obj/ejsMemory.o
DEPS_120 += $(CONFIG)/obj/ejsMprLog.o
DEPS_120 += $(CONFIG)/obj/ejsNamespace.o
DEPS_120 += $(CONFIG)/obj/ejsNull.o
DEPS_120 += $(CONFIG)/obj/ejsNumber.o
DEPS_120 += $(CONFIG)/obj/ejsObject.o
DEPS_120 += $(CONFIG)/obj/ejsPath.o
DEPS_120 += $(CONFIG)/obj/ejsPot.o
DEPS_120 += $(CONFIG)/obj/ejsRegExp.o
DEPS_120 += $(CONFIG)/obj/ejsSocket.o
DEPS_120 += $(CONFIG)/obj/ejsString.o
DEPS_120 += $(CONFIG)/obj/ejsSystem.o
DEPS_120 += $(CONFIG)/obj/ejsTimer.o
DEPS_120 += $(CONFIG)/obj/ejsType.o
DEPS_120 += $(CONFIG)/obj/ejsUri.o
DEPS_120 += $(CONFIG)/obj/ejsVoid.o
DEPS_120 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_120 += $(CONFIG)/obj/ejsWorker.o
DEPS_120 += $(CONFIG)/obj/ejsXML.o
DEPS_120 += $(CONFIG)/obj/ejsXMLList.o
DEPS_120 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_120 += $(CONFIG)/obj/ejsByteCode.o
DEPS_120 += $(CONFIG)/obj/ejsException.o
DEPS_120 += $(CONFIG)/obj/ejsHelper.o
DEPS_120 += $(CONFIG)/obj/ejsInterp.o
DEPS_120 += $(CONFIG)/obj/ejsLoader.o
DEPS_120 += $(CONFIG)/obj/ejsModule.o
DEPS_120 += $(CONFIG)/obj/ejsScope.o
DEPS_120 += $(CONFIG)/obj/ejsService.o
DEPS_120 += $(CONFIG)/bin/libejs.out
DEPS_120 += $(CONFIG)/obj/ejsc.o
DEPS_120 += $(CONFIG)/bin/ejsc.out
DEPS_120 += src/cmd/ejsmod.h
DEPS_120 += $(CONFIG)/obj/ejsmod.o
DEPS_120 += $(CONFIG)/obj/doc.o
DEPS_120 += $(CONFIG)/obj/docFiles.o
DEPS_120 += $(CONFIG)/obj/listing.o
DEPS_120 += $(CONFIG)/obj/slotGen.o
DEPS_120 += $(CONFIG)/bin/ejsmod.out
DEPS_120 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.db.sqlite.mod: $(DEPS_120)
	( \
	cd src/ejs.db.sqlite; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.db.sqlite.mod  --optimize 9 *.es ; \
	)

#
#   ejsSqlite.o
#
DEPS_121 += $(CONFIG)/inc/bit.h
DEPS_121 += $(CONFIG)/inc/mpr.h
DEPS_121 += $(CONFIG)/inc/http.h
DEPS_121 += $(CONFIG)/inc/ejsByteCode.h
DEPS_121 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_121 += $(CONFIG)/inc/ejs.slots.h
DEPS_121 += $(CONFIG)/inc/ejsCustomize.h
DEPS_121 += $(CONFIG)/inc/ejs.h
DEPS_121 += $(CONFIG)/inc/ejs.db.sqlite.slots.h

$(CONFIG)/obj/ejsSqlite.o: \
    src/ejs.db.sqlite/ejsSqlite.c $(DEPS_121)
	@echo '   [Compile] $(CONFIG)/obj/ejsSqlite.o'
	$(CC) -c -o $(CONFIG)/obj/ejsSqlite.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.db.sqlite/ejsSqlite.c

#
#   libejs.db.sqlite
#
DEPS_122 += $(CONFIG)/inc/mpr.h
DEPS_122 += $(CONFIG)/inc/bit.h
DEPS_122 += $(CONFIG)/inc/bitos.h
DEPS_122 += $(CONFIG)/obj/mprLib.o
DEPS_122 += $(CONFIG)/bin/libmpr.out
DEPS_122 += $(CONFIG)/inc/pcre.h
DEPS_122 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_122 += $(CONFIG)/bin/libpcre.out
endif
DEPS_122 += $(CONFIG)/inc/http.h
DEPS_122 += $(CONFIG)/obj/httpLib.o
DEPS_122 += $(CONFIG)/bin/libhttp.out
DEPS_122 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_122 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_122 += $(CONFIG)/inc/ejs.slots.h
DEPS_122 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_122 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_122 += $(CONFIG)/inc/ejsByteCode.h
DEPS_122 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_122 += $(CONFIG)/inc/ejsCustomize.h
DEPS_122 += $(CONFIG)/inc/ejs.h
DEPS_122 += $(CONFIG)/inc/ejsCompiler.h
DEPS_122 += $(CONFIG)/obj/ecAst.o
DEPS_122 += $(CONFIG)/obj/ecCodeGen.o
DEPS_122 += $(CONFIG)/obj/ecCompiler.o
DEPS_122 += $(CONFIG)/obj/ecLex.o
DEPS_122 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_122 += $(CONFIG)/obj/ecParser.o
DEPS_122 += $(CONFIG)/obj/ecState.o
DEPS_122 += $(CONFIG)/obj/dtoa.o
DEPS_122 += $(CONFIG)/obj/ejsApp.o
DEPS_122 += $(CONFIG)/obj/ejsArray.o
DEPS_122 += $(CONFIG)/obj/ejsBlock.o
DEPS_122 += $(CONFIG)/obj/ejsBoolean.o
DEPS_122 += $(CONFIG)/obj/ejsByteArray.o
DEPS_122 += $(CONFIG)/obj/ejsCache.o
DEPS_122 += $(CONFIG)/obj/ejsCmd.o
DEPS_122 += $(CONFIG)/obj/ejsConfig.o
DEPS_122 += $(CONFIG)/obj/ejsDate.o
DEPS_122 += $(CONFIG)/obj/ejsDebug.o
DEPS_122 += $(CONFIG)/obj/ejsError.o
DEPS_122 += $(CONFIG)/obj/ejsFile.o
DEPS_122 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_122 += $(CONFIG)/obj/ejsFrame.o
DEPS_122 += $(CONFIG)/obj/ejsFunction.o
DEPS_122 += $(CONFIG)/obj/ejsGC.o
DEPS_122 += $(CONFIG)/obj/ejsGlobal.o
DEPS_122 += $(CONFIG)/obj/ejsHttp.o
DEPS_122 += $(CONFIG)/obj/ejsIterator.o
DEPS_122 += $(CONFIG)/obj/ejsJSON.o
DEPS_122 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_122 += $(CONFIG)/obj/ejsMath.o
DEPS_122 += $(CONFIG)/obj/ejsMemory.o
DEPS_122 += $(CONFIG)/obj/ejsMprLog.o
DEPS_122 += $(CONFIG)/obj/ejsNamespace.o
DEPS_122 += $(CONFIG)/obj/ejsNull.o
DEPS_122 += $(CONFIG)/obj/ejsNumber.o
DEPS_122 += $(CONFIG)/obj/ejsObject.o
DEPS_122 += $(CONFIG)/obj/ejsPath.o
DEPS_122 += $(CONFIG)/obj/ejsPot.o
DEPS_122 += $(CONFIG)/obj/ejsRegExp.o
DEPS_122 += $(CONFIG)/obj/ejsSocket.o
DEPS_122 += $(CONFIG)/obj/ejsString.o
DEPS_122 += $(CONFIG)/obj/ejsSystem.o
DEPS_122 += $(CONFIG)/obj/ejsTimer.o
DEPS_122 += $(CONFIG)/obj/ejsType.o
DEPS_122 += $(CONFIG)/obj/ejsUri.o
DEPS_122 += $(CONFIG)/obj/ejsVoid.o
DEPS_122 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_122 += $(CONFIG)/obj/ejsWorker.o
DEPS_122 += $(CONFIG)/obj/ejsXML.o
DEPS_122 += $(CONFIG)/obj/ejsXMLList.o
DEPS_122 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_122 += $(CONFIG)/obj/ejsByteCode.o
DEPS_122 += $(CONFIG)/obj/ejsException.o
DEPS_122 += $(CONFIG)/obj/ejsHelper.o
DEPS_122 += $(CONFIG)/obj/ejsInterp.o
DEPS_122 += $(CONFIG)/obj/ejsLoader.o
DEPS_122 += $(CONFIG)/obj/ejsModule.o
DEPS_122 += $(CONFIG)/obj/ejsScope.o
DEPS_122 += $(CONFIG)/obj/ejsService.o
DEPS_122 += $(CONFIG)/bin/libejs.out
DEPS_122 += $(CONFIG)/obj/ejsc.o
DEPS_122 += $(CONFIG)/bin/ejsc.out
DEPS_122 += src/cmd/ejsmod.h
DEPS_122 += $(CONFIG)/obj/ejsmod.o
DEPS_122 += $(CONFIG)/obj/doc.o
DEPS_122 += $(CONFIG)/obj/docFiles.o
DEPS_122 += $(CONFIG)/obj/listing.o
DEPS_122 += $(CONFIG)/obj/slotGen.o
DEPS_122 += $(CONFIG)/bin/ejsmod.out
DEPS_122 += $(CONFIG)/bin/ejs.mod
DEPS_122 += $(CONFIG)/bin/ejs.db.sqlite.mod
DEPS_122 += $(CONFIG)/inc/sqlite3.h
DEPS_122 += $(CONFIG)/obj/sqlite3.o
ifeq ($(BIT_PACK_SQLITE),1)
    DEPS_122 += $(CONFIG)/bin/libsql.out
endif
DEPS_122 += $(CONFIG)/obj/ejsSqlite.o

$(CONFIG)/bin/libejs.db.sqlite.out: $(DEPS_122)
	@echo '      [Link] $(CONFIG)/bin/libejs.db.sqlite.out'
	$(CC) -r -o $(CONFIG)/bin/libejs.db.sqlite.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsSqlite.o" $(LIBS) 

#
#   ejs.mail.mod
#
DEPS_123 += src/ejs.mail/Mail.es
DEPS_123 += $(CONFIG)/inc/mpr.h
DEPS_123 += $(CONFIG)/inc/bit.h
DEPS_123 += $(CONFIG)/inc/bitos.h
DEPS_123 += $(CONFIG)/obj/mprLib.o
DEPS_123 += $(CONFIG)/bin/libmpr.out
DEPS_123 += $(CONFIG)/inc/pcre.h
DEPS_123 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_123 += $(CONFIG)/bin/libpcre.out
endif
DEPS_123 += $(CONFIG)/inc/http.h
DEPS_123 += $(CONFIG)/obj/httpLib.o
DEPS_123 += $(CONFIG)/bin/libhttp.out
DEPS_123 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_123 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_123 += $(CONFIG)/inc/ejs.slots.h
DEPS_123 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_123 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_123 += $(CONFIG)/inc/ejsByteCode.h
DEPS_123 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_123 += $(CONFIG)/inc/ejsCustomize.h
DEPS_123 += $(CONFIG)/inc/ejs.h
DEPS_123 += $(CONFIG)/inc/ejsCompiler.h
DEPS_123 += $(CONFIG)/obj/ecAst.o
DEPS_123 += $(CONFIG)/obj/ecCodeGen.o
DEPS_123 += $(CONFIG)/obj/ecCompiler.o
DEPS_123 += $(CONFIG)/obj/ecLex.o
DEPS_123 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_123 += $(CONFIG)/obj/ecParser.o
DEPS_123 += $(CONFIG)/obj/ecState.o
DEPS_123 += $(CONFIG)/obj/dtoa.o
DEPS_123 += $(CONFIG)/obj/ejsApp.o
DEPS_123 += $(CONFIG)/obj/ejsArray.o
DEPS_123 += $(CONFIG)/obj/ejsBlock.o
DEPS_123 += $(CONFIG)/obj/ejsBoolean.o
DEPS_123 += $(CONFIG)/obj/ejsByteArray.o
DEPS_123 += $(CONFIG)/obj/ejsCache.o
DEPS_123 += $(CONFIG)/obj/ejsCmd.o
DEPS_123 += $(CONFIG)/obj/ejsConfig.o
DEPS_123 += $(CONFIG)/obj/ejsDate.o
DEPS_123 += $(CONFIG)/obj/ejsDebug.o
DEPS_123 += $(CONFIG)/obj/ejsError.o
DEPS_123 += $(CONFIG)/obj/ejsFile.o
DEPS_123 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_123 += $(CONFIG)/obj/ejsFrame.o
DEPS_123 += $(CONFIG)/obj/ejsFunction.o
DEPS_123 += $(CONFIG)/obj/ejsGC.o
DEPS_123 += $(CONFIG)/obj/ejsGlobal.o
DEPS_123 += $(CONFIG)/obj/ejsHttp.o
DEPS_123 += $(CONFIG)/obj/ejsIterator.o
DEPS_123 += $(CONFIG)/obj/ejsJSON.o
DEPS_123 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_123 += $(CONFIG)/obj/ejsMath.o
DEPS_123 += $(CONFIG)/obj/ejsMemory.o
DEPS_123 += $(CONFIG)/obj/ejsMprLog.o
DEPS_123 += $(CONFIG)/obj/ejsNamespace.o
DEPS_123 += $(CONFIG)/obj/ejsNull.o
DEPS_123 += $(CONFIG)/obj/ejsNumber.o
DEPS_123 += $(CONFIG)/obj/ejsObject.o
DEPS_123 += $(CONFIG)/obj/ejsPath.o
DEPS_123 += $(CONFIG)/obj/ejsPot.o
DEPS_123 += $(CONFIG)/obj/ejsRegExp.o
DEPS_123 += $(CONFIG)/obj/ejsSocket.o
DEPS_123 += $(CONFIG)/obj/ejsString.o
DEPS_123 += $(CONFIG)/obj/ejsSystem.o
DEPS_123 += $(CONFIG)/obj/ejsTimer.o
DEPS_123 += $(CONFIG)/obj/ejsType.o
DEPS_123 += $(CONFIG)/obj/ejsUri.o
DEPS_123 += $(CONFIG)/obj/ejsVoid.o
DEPS_123 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_123 += $(CONFIG)/obj/ejsWorker.o
DEPS_123 += $(CONFIG)/obj/ejsXML.o
DEPS_123 += $(CONFIG)/obj/ejsXMLList.o
DEPS_123 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_123 += $(CONFIG)/obj/ejsByteCode.o
DEPS_123 += $(CONFIG)/obj/ejsException.o
DEPS_123 += $(CONFIG)/obj/ejsHelper.o
DEPS_123 += $(CONFIG)/obj/ejsInterp.o
DEPS_123 += $(CONFIG)/obj/ejsLoader.o
DEPS_123 += $(CONFIG)/obj/ejsModule.o
DEPS_123 += $(CONFIG)/obj/ejsScope.o
DEPS_123 += $(CONFIG)/obj/ejsService.o
DEPS_123 += $(CONFIG)/bin/libejs.out
DEPS_123 += $(CONFIG)/obj/ejsc.o
DEPS_123 += $(CONFIG)/bin/ejsc.out
DEPS_123 += src/cmd/ejsmod.h
DEPS_123 += $(CONFIG)/obj/ejsmod.o
DEPS_123 += $(CONFIG)/obj/doc.o
DEPS_123 += $(CONFIG)/obj/docFiles.o
DEPS_123 += $(CONFIG)/obj/listing.o
DEPS_123 += $(CONFIG)/obj/slotGen.o
DEPS_123 += $(CONFIG)/bin/ejsmod.out
DEPS_123 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.mail.mod: $(DEPS_123)
	( \
	cd src/ejs.mail; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.mail.mod  --optimize 9 *.es ; \
	)

#
#   ejs.web.mod
#
DEPS_124 += src/ejs.web/Cascade.es
DEPS_124 += src/ejs.web/CommonLog.es
DEPS_124 += src/ejs.web/ContentType.es
DEPS_124 += src/ejs.web/Controller.es
DEPS_124 += src/ejs.web/Dir.es
DEPS_124 += src/ejs.web/Google.es
DEPS_124 += src/ejs.web/Head.es
DEPS_124 += src/ejs.web/Html.es
DEPS_124 += src/ejs.web/HttpServer.es
DEPS_124 += src/ejs.web/MethodOverride.es
DEPS_124 += src/ejs.web/Middleware.es
DEPS_124 += src/ejs.web/Mvc.es
DEPS_124 += src/ejs.web/Request.es
DEPS_124 += src/ejs.web/Router.es
DEPS_124 += src/ejs.web/Script.es
DEPS_124 += src/ejs.web/Session.es
DEPS_124 += src/ejs.web/ShowExceptions.es
DEPS_124 += src/ejs.web/Static.es
DEPS_124 += src/ejs.web/Template.es
DEPS_124 += src/ejs.web/UploadFile.es
DEPS_124 += src/ejs.web/UrlMap.es
DEPS_124 += src/ejs.web/Utils.es
DEPS_124 += src/ejs.web/View.es
DEPS_124 += $(CONFIG)/inc/mpr.h
DEPS_124 += $(CONFIG)/inc/bit.h
DEPS_124 += $(CONFIG)/inc/bitos.h
DEPS_124 += $(CONFIG)/obj/mprLib.o
DEPS_124 += $(CONFIG)/bin/libmpr.out
DEPS_124 += $(CONFIG)/inc/pcre.h
DEPS_124 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_124 += $(CONFIG)/bin/libpcre.out
endif
DEPS_124 += $(CONFIG)/inc/http.h
DEPS_124 += $(CONFIG)/obj/httpLib.o
DEPS_124 += $(CONFIG)/bin/libhttp.out
DEPS_124 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_124 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_124 += $(CONFIG)/inc/ejs.slots.h
DEPS_124 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_124 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_124 += $(CONFIG)/inc/ejsByteCode.h
DEPS_124 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_124 += $(CONFIG)/inc/ejsCustomize.h
DEPS_124 += $(CONFIG)/inc/ejs.h
DEPS_124 += $(CONFIG)/inc/ejsCompiler.h
DEPS_124 += $(CONFIG)/obj/ecAst.o
DEPS_124 += $(CONFIG)/obj/ecCodeGen.o
DEPS_124 += $(CONFIG)/obj/ecCompiler.o
DEPS_124 += $(CONFIG)/obj/ecLex.o
DEPS_124 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_124 += $(CONFIG)/obj/ecParser.o
DEPS_124 += $(CONFIG)/obj/ecState.o
DEPS_124 += $(CONFIG)/obj/dtoa.o
DEPS_124 += $(CONFIG)/obj/ejsApp.o
DEPS_124 += $(CONFIG)/obj/ejsArray.o
DEPS_124 += $(CONFIG)/obj/ejsBlock.o
DEPS_124 += $(CONFIG)/obj/ejsBoolean.o
DEPS_124 += $(CONFIG)/obj/ejsByteArray.o
DEPS_124 += $(CONFIG)/obj/ejsCache.o
DEPS_124 += $(CONFIG)/obj/ejsCmd.o
DEPS_124 += $(CONFIG)/obj/ejsConfig.o
DEPS_124 += $(CONFIG)/obj/ejsDate.o
DEPS_124 += $(CONFIG)/obj/ejsDebug.o
DEPS_124 += $(CONFIG)/obj/ejsError.o
DEPS_124 += $(CONFIG)/obj/ejsFile.o
DEPS_124 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_124 += $(CONFIG)/obj/ejsFrame.o
DEPS_124 += $(CONFIG)/obj/ejsFunction.o
DEPS_124 += $(CONFIG)/obj/ejsGC.o
DEPS_124 += $(CONFIG)/obj/ejsGlobal.o
DEPS_124 += $(CONFIG)/obj/ejsHttp.o
DEPS_124 += $(CONFIG)/obj/ejsIterator.o
DEPS_124 += $(CONFIG)/obj/ejsJSON.o
DEPS_124 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_124 += $(CONFIG)/obj/ejsMath.o
DEPS_124 += $(CONFIG)/obj/ejsMemory.o
DEPS_124 += $(CONFIG)/obj/ejsMprLog.o
DEPS_124 += $(CONFIG)/obj/ejsNamespace.o
DEPS_124 += $(CONFIG)/obj/ejsNull.o
DEPS_124 += $(CONFIG)/obj/ejsNumber.o
DEPS_124 += $(CONFIG)/obj/ejsObject.o
DEPS_124 += $(CONFIG)/obj/ejsPath.o
DEPS_124 += $(CONFIG)/obj/ejsPot.o
DEPS_124 += $(CONFIG)/obj/ejsRegExp.o
DEPS_124 += $(CONFIG)/obj/ejsSocket.o
DEPS_124 += $(CONFIG)/obj/ejsString.o
DEPS_124 += $(CONFIG)/obj/ejsSystem.o
DEPS_124 += $(CONFIG)/obj/ejsTimer.o
DEPS_124 += $(CONFIG)/obj/ejsType.o
DEPS_124 += $(CONFIG)/obj/ejsUri.o
DEPS_124 += $(CONFIG)/obj/ejsVoid.o
DEPS_124 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_124 += $(CONFIG)/obj/ejsWorker.o
DEPS_124 += $(CONFIG)/obj/ejsXML.o
DEPS_124 += $(CONFIG)/obj/ejsXMLList.o
DEPS_124 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_124 += $(CONFIG)/obj/ejsByteCode.o
DEPS_124 += $(CONFIG)/obj/ejsException.o
DEPS_124 += $(CONFIG)/obj/ejsHelper.o
DEPS_124 += $(CONFIG)/obj/ejsInterp.o
DEPS_124 += $(CONFIG)/obj/ejsLoader.o
DEPS_124 += $(CONFIG)/obj/ejsModule.o
DEPS_124 += $(CONFIG)/obj/ejsScope.o
DEPS_124 += $(CONFIG)/obj/ejsService.o
DEPS_124 += $(CONFIG)/bin/libejs.out
DEPS_124 += $(CONFIG)/obj/ejsc.o
DEPS_124 += $(CONFIG)/bin/ejsc.out
DEPS_124 += src/cmd/ejsmod.h
DEPS_124 += $(CONFIG)/obj/ejsmod.o
DEPS_124 += $(CONFIG)/obj/doc.o
DEPS_124 += $(CONFIG)/obj/docFiles.o
DEPS_124 += $(CONFIG)/obj/listing.o
DEPS_124 += $(CONFIG)/obj/slotGen.o
DEPS_124 += $(CONFIG)/bin/ejsmod.out
DEPS_124 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.web.mod: $(DEPS_124)
	( \
	cd src/ejs.web; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.web.mod  --optimize 9 *.es ; \
	../../$(CONFIG)/bin/ejsmod --cslots ../../$(CONFIG)/bin/ejs.web.mod ; \
	if ! diff ejs.web.slots.h ../../$(CONFIG)/inc/ejs.web.slots.h >/dev/null; then cp ejs.web.slots.h ../../$(CONFIG)/inc; fi ; \
	rm -f ejs.web.slots.h ; \
	)

#
#   ejsWeb.h
#
$(CONFIG)/inc/ejsWeb.h: $(DEPS_125)
	@echo '      [Copy] $(CONFIG)/inc/ejsWeb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ejs.web/ejsWeb.h $(CONFIG)/inc/ejsWeb.h

#
#   ejsHttpServer.o
#
DEPS_126 += $(CONFIG)/inc/bit.h
DEPS_126 += $(CONFIG)/inc/mpr.h
DEPS_126 += $(CONFIG)/inc/http.h
DEPS_126 += $(CONFIG)/inc/ejsByteCode.h
DEPS_126 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_126 += $(CONFIG)/inc/ejs.slots.h
DEPS_126 += $(CONFIG)/inc/ejsCustomize.h
DEPS_126 += $(CONFIG)/inc/ejs.h
DEPS_126 += $(CONFIG)/inc/ejsCompiler.h
DEPS_126 += $(CONFIG)/inc/ejsWeb.h
DEPS_126 += $(CONFIG)/inc/ejs.web.slots.h

$(CONFIG)/obj/ejsHttpServer.o: \
    src/ejs.web/ejsHttpServer.c $(DEPS_126)
	@echo '   [Compile] $(CONFIG)/obj/ejsHttpServer.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHttpServer.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.web/ejsHttpServer.c

#
#   ejsRequest.o
#
DEPS_127 += $(CONFIG)/inc/bit.h
DEPS_127 += $(CONFIG)/inc/mpr.h
DEPS_127 += $(CONFIG)/inc/http.h
DEPS_127 += $(CONFIG)/inc/ejsByteCode.h
DEPS_127 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_127 += $(CONFIG)/inc/ejs.slots.h
DEPS_127 += $(CONFIG)/inc/ejsCustomize.h
DEPS_127 += $(CONFIG)/inc/ejs.h
DEPS_127 += $(CONFIG)/inc/ejsCompiler.h
DEPS_127 += $(CONFIG)/inc/ejsWeb.h
DEPS_127 += $(CONFIG)/inc/ejs.web.slots.h

$(CONFIG)/obj/ejsRequest.o: \
    src/ejs.web/ejsRequest.c $(DEPS_127)
	@echo '   [Compile] $(CONFIG)/obj/ejsRequest.o'
	$(CC) -c -o $(CONFIG)/obj/ejsRequest.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.web/ejsRequest.c

#
#   ejsSession.o
#
DEPS_128 += $(CONFIG)/inc/bit.h
DEPS_128 += $(CONFIG)/inc/mpr.h
DEPS_128 += $(CONFIG)/inc/http.h
DEPS_128 += $(CONFIG)/inc/ejsByteCode.h
DEPS_128 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_128 += $(CONFIG)/inc/ejs.slots.h
DEPS_128 += $(CONFIG)/inc/ejsCustomize.h
DEPS_128 += $(CONFIG)/inc/ejs.h
DEPS_128 += $(CONFIG)/inc/ejsWeb.h

$(CONFIG)/obj/ejsSession.o: \
    src/ejs.web/ejsSession.c $(DEPS_128)
	@echo '   [Compile] $(CONFIG)/obj/ejsSession.o'
	$(CC) -c -o $(CONFIG)/obj/ejsSession.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.web/ejsSession.c

#
#   ejsWeb.o
#
DEPS_129 += $(CONFIG)/inc/bit.h
DEPS_129 += $(CONFIG)/inc/mpr.h
DEPS_129 += $(CONFIG)/inc/http.h
DEPS_129 += $(CONFIG)/inc/ejsByteCode.h
DEPS_129 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_129 += $(CONFIG)/inc/ejs.slots.h
DEPS_129 += $(CONFIG)/inc/ejsCustomize.h
DEPS_129 += $(CONFIG)/inc/ejs.h
DEPS_129 += $(CONFIG)/inc/ejsCompiler.h
DEPS_129 += $(CONFIG)/inc/ejsWeb.h
DEPS_129 += $(CONFIG)/inc/ejs.web.slots.h

$(CONFIG)/obj/ejsWeb.o: \
    src/ejs.web/ejsWeb.c $(DEPS_129)
	@echo '   [Compile] $(CONFIG)/obj/ejsWeb.o'
	$(CC) -c -o $(CONFIG)/obj/ejsWeb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.web/ejsWeb.c

#
#   libejs.web
#
DEPS_130 += $(CONFIG)/inc/mpr.h
DEPS_130 += $(CONFIG)/inc/bit.h
DEPS_130 += $(CONFIG)/inc/bitos.h
DEPS_130 += $(CONFIG)/obj/mprLib.o
DEPS_130 += $(CONFIG)/bin/libmpr.out
DEPS_130 += $(CONFIG)/inc/pcre.h
DEPS_130 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_130 += $(CONFIG)/bin/libpcre.out
endif
DEPS_130 += $(CONFIG)/inc/http.h
DEPS_130 += $(CONFIG)/obj/httpLib.o
DEPS_130 += $(CONFIG)/bin/libhttp.out
DEPS_130 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_130 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_130 += $(CONFIG)/inc/ejs.slots.h
DEPS_130 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_130 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_130 += $(CONFIG)/inc/ejsByteCode.h
DEPS_130 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_130 += $(CONFIG)/inc/ejsCustomize.h
DEPS_130 += $(CONFIG)/inc/ejs.h
DEPS_130 += $(CONFIG)/inc/ejsCompiler.h
DEPS_130 += $(CONFIG)/obj/ecAst.o
DEPS_130 += $(CONFIG)/obj/ecCodeGen.o
DEPS_130 += $(CONFIG)/obj/ecCompiler.o
DEPS_130 += $(CONFIG)/obj/ecLex.o
DEPS_130 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_130 += $(CONFIG)/obj/ecParser.o
DEPS_130 += $(CONFIG)/obj/ecState.o
DEPS_130 += $(CONFIG)/obj/dtoa.o
DEPS_130 += $(CONFIG)/obj/ejsApp.o
DEPS_130 += $(CONFIG)/obj/ejsArray.o
DEPS_130 += $(CONFIG)/obj/ejsBlock.o
DEPS_130 += $(CONFIG)/obj/ejsBoolean.o
DEPS_130 += $(CONFIG)/obj/ejsByteArray.o
DEPS_130 += $(CONFIG)/obj/ejsCache.o
DEPS_130 += $(CONFIG)/obj/ejsCmd.o
DEPS_130 += $(CONFIG)/obj/ejsConfig.o
DEPS_130 += $(CONFIG)/obj/ejsDate.o
DEPS_130 += $(CONFIG)/obj/ejsDebug.o
DEPS_130 += $(CONFIG)/obj/ejsError.o
DEPS_130 += $(CONFIG)/obj/ejsFile.o
DEPS_130 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_130 += $(CONFIG)/obj/ejsFrame.o
DEPS_130 += $(CONFIG)/obj/ejsFunction.o
DEPS_130 += $(CONFIG)/obj/ejsGC.o
DEPS_130 += $(CONFIG)/obj/ejsGlobal.o
DEPS_130 += $(CONFIG)/obj/ejsHttp.o
DEPS_130 += $(CONFIG)/obj/ejsIterator.o
DEPS_130 += $(CONFIG)/obj/ejsJSON.o
DEPS_130 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_130 += $(CONFIG)/obj/ejsMath.o
DEPS_130 += $(CONFIG)/obj/ejsMemory.o
DEPS_130 += $(CONFIG)/obj/ejsMprLog.o
DEPS_130 += $(CONFIG)/obj/ejsNamespace.o
DEPS_130 += $(CONFIG)/obj/ejsNull.o
DEPS_130 += $(CONFIG)/obj/ejsNumber.o
DEPS_130 += $(CONFIG)/obj/ejsObject.o
DEPS_130 += $(CONFIG)/obj/ejsPath.o
DEPS_130 += $(CONFIG)/obj/ejsPot.o
DEPS_130 += $(CONFIG)/obj/ejsRegExp.o
DEPS_130 += $(CONFIG)/obj/ejsSocket.o
DEPS_130 += $(CONFIG)/obj/ejsString.o
DEPS_130 += $(CONFIG)/obj/ejsSystem.o
DEPS_130 += $(CONFIG)/obj/ejsTimer.o
DEPS_130 += $(CONFIG)/obj/ejsType.o
DEPS_130 += $(CONFIG)/obj/ejsUri.o
DEPS_130 += $(CONFIG)/obj/ejsVoid.o
DEPS_130 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_130 += $(CONFIG)/obj/ejsWorker.o
DEPS_130 += $(CONFIG)/obj/ejsXML.o
DEPS_130 += $(CONFIG)/obj/ejsXMLList.o
DEPS_130 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_130 += $(CONFIG)/obj/ejsByteCode.o
DEPS_130 += $(CONFIG)/obj/ejsException.o
DEPS_130 += $(CONFIG)/obj/ejsHelper.o
DEPS_130 += $(CONFIG)/obj/ejsInterp.o
DEPS_130 += $(CONFIG)/obj/ejsLoader.o
DEPS_130 += $(CONFIG)/obj/ejsModule.o
DEPS_130 += $(CONFIG)/obj/ejsScope.o
DEPS_130 += $(CONFIG)/obj/ejsService.o
DEPS_130 += $(CONFIG)/bin/libejs.out
DEPS_130 += $(CONFIG)/obj/ejsc.o
DEPS_130 += $(CONFIG)/bin/ejsc.out
DEPS_130 += src/cmd/ejsmod.h
DEPS_130 += $(CONFIG)/obj/ejsmod.o
DEPS_130 += $(CONFIG)/obj/doc.o
DEPS_130 += $(CONFIG)/obj/docFiles.o
DEPS_130 += $(CONFIG)/obj/listing.o
DEPS_130 += $(CONFIG)/obj/slotGen.o
DEPS_130 += $(CONFIG)/bin/ejsmod.out
DEPS_130 += $(CONFIG)/bin/ejs.mod
DEPS_130 += $(CONFIG)/inc/ejsWeb.h
DEPS_130 += $(CONFIG)/obj/ejsHttpServer.o
DEPS_130 += $(CONFIG)/obj/ejsRequest.o
DEPS_130 += $(CONFIG)/obj/ejsSession.o
DEPS_130 += $(CONFIG)/obj/ejsWeb.o

$(CONFIG)/bin/libejs.web.out: $(DEPS_130)
	@echo '      [Link] $(CONFIG)/bin/libejs.web.out'
	$(CC) -r -o $(CONFIG)/bin/libejs.web.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsHttpServer.o" "$(CONFIG)/obj/ejsRequest.o" "$(CONFIG)/obj/ejsSession.o" "$(CONFIG)/obj/ejsWeb.o" $(LIBS) 

#
#   www
#
DEPS_131 += src/ejs.web/www

$(CONFIG)/bin/www: $(DEPS_131)
	( \
	cd src/ejs.web; \
	rm -fr ../../$(CONFIG)/bin/www ; \
	cp -r www ../../$(CONFIG)/bin ; \
	)

#
#   ejs.template.mod
#
DEPS_132 += src/ejs.template/TemplateParser.es
DEPS_132 += $(CONFIG)/inc/mpr.h
DEPS_132 += $(CONFIG)/inc/bit.h
DEPS_132 += $(CONFIG)/inc/bitos.h
DEPS_132 += $(CONFIG)/obj/mprLib.o
DEPS_132 += $(CONFIG)/bin/libmpr.out
DEPS_132 += $(CONFIG)/inc/pcre.h
DEPS_132 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_132 += $(CONFIG)/bin/libpcre.out
endif
DEPS_132 += $(CONFIG)/inc/http.h
DEPS_132 += $(CONFIG)/obj/httpLib.o
DEPS_132 += $(CONFIG)/bin/libhttp.out
DEPS_132 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_132 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_132 += $(CONFIG)/inc/ejs.slots.h
DEPS_132 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_132 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_132 += $(CONFIG)/inc/ejsByteCode.h
DEPS_132 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_132 += $(CONFIG)/inc/ejsCustomize.h
DEPS_132 += $(CONFIG)/inc/ejs.h
DEPS_132 += $(CONFIG)/inc/ejsCompiler.h
DEPS_132 += $(CONFIG)/obj/ecAst.o
DEPS_132 += $(CONFIG)/obj/ecCodeGen.o
DEPS_132 += $(CONFIG)/obj/ecCompiler.o
DEPS_132 += $(CONFIG)/obj/ecLex.o
DEPS_132 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_132 += $(CONFIG)/obj/ecParser.o
DEPS_132 += $(CONFIG)/obj/ecState.o
DEPS_132 += $(CONFIG)/obj/dtoa.o
DEPS_132 += $(CONFIG)/obj/ejsApp.o
DEPS_132 += $(CONFIG)/obj/ejsArray.o
DEPS_132 += $(CONFIG)/obj/ejsBlock.o
DEPS_132 += $(CONFIG)/obj/ejsBoolean.o
DEPS_132 += $(CONFIG)/obj/ejsByteArray.o
DEPS_132 += $(CONFIG)/obj/ejsCache.o
DEPS_132 += $(CONFIG)/obj/ejsCmd.o
DEPS_132 += $(CONFIG)/obj/ejsConfig.o
DEPS_132 += $(CONFIG)/obj/ejsDate.o
DEPS_132 += $(CONFIG)/obj/ejsDebug.o
DEPS_132 += $(CONFIG)/obj/ejsError.o
DEPS_132 += $(CONFIG)/obj/ejsFile.o
DEPS_132 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_132 += $(CONFIG)/obj/ejsFrame.o
DEPS_132 += $(CONFIG)/obj/ejsFunction.o
DEPS_132 += $(CONFIG)/obj/ejsGC.o
DEPS_132 += $(CONFIG)/obj/ejsGlobal.o
DEPS_132 += $(CONFIG)/obj/ejsHttp.o
DEPS_132 += $(CONFIG)/obj/ejsIterator.o
DEPS_132 += $(CONFIG)/obj/ejsJSON.o
DEPS_132 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_132 += $(CONFIG)/obj/ejsMath.o
DEPS_132 += $(CONFIG)/obj/ejsMemory.o
DEPS_132 += $(CONFIG)/obj/ejsMprLog.o
DEPS_132 += $(CONFIG)/obj/ejsNamespace.o
DEPS_132 += $(CONFIG)/obj/ejsNull.o
DEPS_132 += $(CONFIG)/obj/ejsNumber.o
DEPS_132 += $(CONFIG)/obj/ejsObject.o
DEPS_132 += $(CONFIG)/obj/ejsPath.o
DEPS_132 += $(CONFIG)/obj/ejsPot.o
DEPS_132 += $(CONFIG)/obj/ejsRegExp.o
DEPS_132 += $(CONFIG)/obj/ejsSocket.o
DEPS_132 += $(CONFIG)/obj/ejsString.o
DEPS_132 += $(CONFIG)/obj/ejsSystem.o
DEPS_132 += $(CONFIG)/obj/ejsTimer.o
DEPS_132 += $(CONFIG)/obj/ejsType.o
DEPS_132 += $(CONFIG)/obj/ejsUri.o
DEPS_132 += $(CONFIG)/obj/ejsVoid.o
DEPS_132 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_132 += $(CONFIG)/obj/ejsWorker.o
DEPS_132 += $(CONFIG)/obj/ejsXML.o
DEPS_132 += $(CONFIG)/obj/ejsXMLList.o
DEPS_132 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_132 += $(CONFIG)/obj/ejsByteCode.o
DEPS_132 += $(CONFIG)/obj/ejsException.o
DEPS_132 += $(CONFIG)/obj/ejsHelper.o
DEPS_132 += $(CONFIG)/obj/ejsInterp.o
DEPS_132 += $(CONFIG)/obj/ejsLoader.o
DEPS_132 += $(CONFIG)/obj/ejsModule.o
DEPS_132 += $(CONFIG)/obj/ejsScope.o
DEPS_132 += $(CONFIG)/obj/ejsService.o
DEPS_132 += $(CONFIG)/bin/libejs.out
DEPS_132 += $(CONFIG)/obj/ejsc.o
DEPS_132 += $(CONFIG)/bin/ejsc.out
DEPS_132 += src/cmd/ejsmod.h
DEPS_132 += $(CONFIG)/obj/ejsmod.o
DEPS_132 += $(CONFIG)/obj/doc.o
DEPS_132 += $(CONFIG)/obj/docFiles.o
DEPS_132 += $(CONFIG)/obj/listing.o
DEPS_132 += $(CONFIG)/obj/slotGen.o
DEPS_132 += $(CONFIG)/bin/ejsmod.out
DEPS_132 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.template.mod: $(DEPS_132)
	( \
	cd src/ejs.template; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.template.mod  --optimize 9 TemplateParser.es ; \
	)

#
#   ejs.zlib.mod
#
DEPS_133 += src/ejs.zlib/Zlib.es
DEPS_133 += $(CONFIG)/inc/mpr.h
DEPS_133 += $(CONFIG)/inc/bit.h
DEPS_133 += $(CONFIG)/inc/bitos.h
DEPS_133 += $(CONFIG)/obj/mprLib.o
DEPS_133 += $(CONFIG)/bin/libmpr.out
DEPS_133 += $(CONFIG)/inc/pcre.h
DEPS_133 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_133 += $(CONFIG)/bin/libpcre.out
endif
DEPS_133 += $(CONFIG)/inc/http.h
DEPS_133 += $(CONFIG)/obj/httpLib.o
DEPS_133 += $(CONFIG)/bin/libhttp.out
DEPS_133 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_133 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_133 += $(CONFIG)/inc/ejs.slots.h
DEPS_133 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_133 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_133 += $(CONFIG)/inc/ejsByteCode.h
DEPS_133 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_133 += $(CONFIG)/inc/ejsCustomize.h
DEPS_133 += $(CONFIG)/inc/ejs.h
DEPS_133 += $(CONFIG)/inc/ejsCompiler.h
DEPS_133 += $(CONFIG)/obj/ecAst.o
DEPS_133 += $(CONFIG)/obj/ecCodeGen.o
DEPS_133 += $(CONFIG)/obj/ecCompiler.o
DEPS_133 += $(CONFIG)/obj/ecLex.o
DEPS_133 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_133 += $(CONFIG)/obj/ecParser.o
DEPS_133 += $(CONFIG)/obj/ecState.o
DEPS_133 += $(CONFIG)/obj/dtoa.o
DEPS_133 += $(CONFIG)/obj/ejsApp.o
DEPS_133 += $(CONFIG)/obj/ejsArray.o
DEPS_133 += $(CONFIG)/obj/ejsBlock.o
DEPS_133 += $(CONFIG)/obj/ejsBoolean.o
DEPS_133 += $(CONFIG)/obj/ejsByteArray.o
DEPS_133 += $(CONFIG)/obj/ejsCache.o
DEPS_133 += $(CONFIG)/obj/ejsCmd.o
DEPS_133 += $(CONFIG)/obj/ejsConfig.o
DEPS_133 += $(CONFIG)/obj/ejsDate.o
DEPS_133 += $(CONFIG)/obj/ejsDebug.o
DEPS_133 += $(CONFIG)/obj/ejsError.o
DEPS_133 += $(CONFIG)/obj/ejsFile.o
DEPS_133 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_133 += $(CONFIG)/obj/ejsFrame.o
DEPS_133 += $(CONFIG)/obj/ejsFunction.o
DEPS_133 += $(CONFIG)/obj/ejsGC.o
DEPS_133 += $(CONFIG)/obj/ejsGlobal.o
DEPS_133 += $(CONFIG)/obj/ejsHttp.o
DEPS_133 += $(CONFIG)/obj/ejsIterator.o
DEPS_133 += $(CONFIG)/obj/ejsJSON.o
DEPS_133 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_133 += $(CONFIG)/obj/ejsMath.o
DEPS_133 += $(CONFIG)/obj/ejsMemory.o
DEPS_133 += $(CONFIG)/obj/ejsMprLog.o
DEPS_133 += $(CONFIG)/obj/ejsNamespace.o
DEPS_133 += $(CONFIG)/obj/ejsNull.o
DEPS_133 += $(CONFIG)/obj/ejsNumber.o
DEPS_133 += $(CONFIG)/obj/ejsObject.o
DEPS_133 += $(CONFIG)/obj/ejsPath.o
DEPS_133 += $(CONFIG)/obj/ejsPot.o
DEPS_133 += $(CONFIG)/obj/ejsRegExp.o
DEPS_133 += $(CONFIG)/obj/ejsSocket.o
DEPS_133 += $(CONFIG)/obj/ejsString.o
DEPS_133 += $(CONFIG)/obj/ejsSystem.o
DEPS_133 += $(CONFIG)/obj/ejsTimer.o
DEPS_133 += $(CONFIG)/obj/ejsType.o
DEPS_133 += $(CONFIG)/obj/ejsUri.o
DEPS_133 += $(CONFIG)/obj/ejsVoid.o
DEPS_133 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_133 += $(CONFIG)/obj/ejsWorker.o
DEPS_133 += $(CONFIG)/obj/ejsXML.o
DEPS_133 += $(CONFIG)/obj/ejsXMLList.o
DEPS_133 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_133 += $(CONFIG)/obj/ejsByteCode.o
DEPS_133 += $(CONFIG)/obj/ejsException.o
DEPS_133 += $(CONFIG)/obj/ejsHelper.o
DEPS_133 += $(CONFIG)/obj/ejsInterp.o
DEPS_133 += $(CONFIG)/obj/ejsLoader.o
DEPS_133 += $(CONFIG)/obj/ejsModule.o
DEPS_133 += $(CONFIG)/obj/ejsScope.o
DEPS_133 += $(CONFIG)/obj/ejsService.o
DEPS_133 += $(CONFIG)/bin/libejs.out
DEPS_133 += $(CONFIG)/obj/ejsc.o
DEPS_133 += $(CONFIG)/bin/ejsc.out
DEPS_133 += src/cmd/ejsmod.h
DEPS_133 += $(CONFIG)/obj/ejsmod.o
DEPS_133 += $(CONFIG)/obj/doc.o
DEPS_133 += $(CONFIG)/obj/docFiles.o
DEPS_133 += $(CONFIG)/obj/listing.o
DEPS_133 += $(CONFIG)/obj/slotGen.o
DEPS_133 += $(CONFIG)/bin/ejsmod.out
DEPS_133 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.zlib.mod: $(DEPS_133)
	( \
	cd src/ejs.zlib; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.zlib.mod  --optimize 9 *.es ; \
	)

#
#   ejsZlib.o
#
DEPS_134 += $(CONFIG)/inc/bit.h
DEPS_134 += $(CONFIG)/inc/mpr.h
DEPS_134 += $(CONFIG)/inc/http.h
DEPS_134 += $(CONFIG)/inc/ejsByteCode.h
DEPS_134 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_134 += $(CONFIG)/inc/ejs.slots.h
DEPS_134 += $(CONFIG)/inc/ejsCustomize.h
DEPS_134 += $(CONFIG)/inc/ejs.h
DEPS_134 += $(CONFIG)/inc/zlib.h
DEPS_134 += $(CONFIG)/inc/ejs.zlib.slots.h

$(CONFIG)/obj/ejsZlib.o: \
    src/ejs.zlib/ejsZlib.c $(DEPS_134)
	@echo '   [Compile] $(CONFIG)/obj/ejsZlib.o'
	$(CC) -c -o $(CONFIG)/obj/ejsZlib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-Isrc/cmd" src/ejs.zlib/ejsZlib.c

#
#   libejs.zlib
#
DEPS_135 += $(CONFIG)/inc/mpr.h
DEPS_135 += $(CONFIG)/inc/bit.h
DEPS_135 += $(CONFIG)/inc/bitos.h
DEPS_135 += $(CONFIG)/obj/mprLib.o
DEPS_135 += $(CONFIG)/bin/libmpr.out
DEPS_135 += $(CONFIG)/inc/pcre.h
DEPS_135 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_135 += $(CONFIG)/bin/libpcre.out
endif
DEPS_135 += $(CONFIG)/inc/http.h
DEPS_135 += $(CONFIG)/obj/httpLib.o
DEPS_135 += $(CONFIG)/bin/libhttp.out
DEPS_135 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_135 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_135 += $(CONFIG)/inc/ejs.slots.h
DEPS_135 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_135 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_135 += $(CONFIG)/inc/ejsByteCode.h
DEPS_135 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_135 += $(CONFIG)/inc/ejsCustomize.h
DEPS_135 += $(CONFIG)/inc/ejs.h
DEPS_135 += $(CONFIG)/inc/ejsCompiler.h
DEPS_135 += $(CONFIG)/obj/ecAst.o
DEPS_135 += $(CONFIG)/obj/ecCodeGen.o
DEPS_135 += $(CONFIG)/obj/ecCompiler.o
DEPS_135 += $(CONFIG)/obj/ecLex.o
DEPS_135 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_135 += $(CONFIG)/obj/ecParser.o
DEPS_135 += $(CONFIG)/obj/ecState.o
DEPS_135 += $(CONFIG)/obj/dtoa.o
DEPS_135 += $(CONFIG)/obj/ejsApp.o
DEPS_135 += $(CONFIG)/obj/ejsArray.o
DEPS_135 += $(CONFIG)/obj/ejsBlock.o
DEPS_135 += $(CONFIG)/obj/ejsBoolean.o
DEPS_135 += $(CONFIG)/obj/ejsByteArray.o
DEPS_135 += $(CONFIG)/obj/ejsCache.o
DEPS_135 += $(CONFIG)/obj/ejsCmd.o
DEPS_135 += $(CONFIG)/obj/ejsConfig.o
DEPS_135 += $(CONFIG)/obj/ejsDate.o
DEPS_135 += $(CONFIG)/obj/ejsDebug.o
DEPS_135 += $(CONFIG)/obj/ejsError.o
DEPS_135 += $(CONFIG)/obj/ejsFile.o
DEPS_135 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_135 += $(CONFIG)/obj/ejsFrame.o
DEPS_135 += $(CONFIG)/obj/ejsFunction.o
DEPS_135 += $(CONFIG)/obj/ejsGC.o
DEPS_135 += $(CONFIG)/obj/ejsGlobal.o
DEPS_135 += $(CONFIG)/obj/ejsHttp.o
DEPS_135 += $(CONFIG)/obj/ejsIterator.o
DEPS_135 += $(CONFIG)/obj/ejsJSON.o
DEPS_135 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_135 += $(CONFIG)/obj/ejsMath.o
DEPS_135 += $(CONFIG)/obj/ejsMemory.o
DEPS_135 += $(CONFIG)/obj/ejsMprLog.o
DEPS_135 += $(CONFIG)/obj/ejsNamespace.o
DEPS_135 += $(CONFIG)/obj/ejsNull.o
DEPS_135 += $(CONFIG)/obj/ejsNumber.o
DEPS_135 += $(CONFIG)/obj/ejsObject.o
DEPS_135 += $(CONFIG)/obj/ejsPath.o
DEPS_135 += $(CONFIG)/obj/ejsPot.o
DEPS_135 += $(CONFIG)/obj/ejsRegExp.o
DEPS_135 += $(CONFIG)/obj/ejsSocket.o
DEPS_135 += $(CONFIG)/obj/ejsString.o
DEPS_135 += $(CONFIG)/obj/ejsSystem.o
DEPS_135 += $(CONFIG)/obj/ejsTimer.o
DEPS_135 += $(CONFIG)/obj/ejsType.o
DEPS_135 += $(CONFIG)/obj/ejsUri.o
DEPS_135 += $(CONFIG)/obj/ejsVoid.o
DEPS_135 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_135 += $(CONFIG)/obj/ejsWorker.o
DEPS_135 += $(CONFIG)/obj/ejsXML.o
DEPS_135 += $(CONFIG)/obj/ejsXMLList.o
DEPS_135 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_135 += $(CONFIG)/obj/ejsByteCode.o
DEPS_135 += $(CONFIG)/obj/ejsException.o
DEPS_135 += $(CONFIG)/obj/ejsHelper.o
DEPS_135 += $(CONFIG)/obj/ejsInterp.o
DEPS_135 += $(CONFIG)/obj/ejsLoader.o
DEPS_135 += $(CONFIG)/obj/ejsModule.o
DEPS_135 += $(CONFIG)/obj/ejsScope.o
DEPS_135 += $(CONFIG)/obj/ejsService.o
DEPS_135 += $(CONFIG)/bin/libejs.out
DEPS_135 += $(CONFIG)/obj/ejsc.o
DEPS_135 += $(CONFIG)/bin/ejsc.out
DEPS_135 += src/cmd/ejsmod.h
DEPS_135 += $(CONFIG)/obj/ejsmod.o
DEPS_135 += $(CONFIG)/obj/doc.o
DEPS_135 += $(CONFIG)/obj/docFiles.o
DEPS_135 += $(CONFIG)/obj/listing.o
DEPS_135 += $(CONFIG)/obj/slotGen.o
DEPS_135 += $(CONFIG)/bin/ejsmod.out
DEPS_135 += $(CONFIG)/bin/ejs.mod
DEPS_135 += $(CONFIG)/bin/ejs.zlib.mod
DEPS_135 += $(CONFIG)/inc/zlib.h
DEPS_135 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_135 += $(CONFIG)/bin/libzlib.out
endif
DEPS_135 += $(CONFIG)/obj/ejsZlib.o

$(CONFIG)/bin/libejs.zlib.out: $(DEPS_135)
	@echo '      [Link] $(CONFIG)/bin/libejs.zlib.out'
	$(CC) -r -o $(CONFIG)/bin/libejs.zlib.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsZlib.o" $(LIBS) 

#
#   ejs.tar.mod
#
DEPS_136 += src/ejs.tar/Tar.es
DEPS_136 += $(CONFIG)/inc/mpr.h
DEPS_136 += $(CONFIG)/inc/bit.h
DEPS_136 += $(CONFIG)/inc/bitos.h
DEPS_136 += $(CONFIG)/obj/mprLib.o
DEPS_136 += $(CONFIG)/bin/libmpr.out
DEPS_136 += $(CONFIG)/inc/pcre.h
DEPS_136 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_136 += $(CONFIG)/bin/libpcre.out
endif
DEPS_136 += $(CONFIG)/inc/http.h
DEPS_136 += $(CONFIG)/obj/httpLib.o
DEPS_136 += $(CONFIG)/bin/libhttp.out
DEPS_136 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_136 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_136 += $(CONFIG)/inc/ejs.slots.h
DEPS_136 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_136 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_136 += $(CONFIG)/inc/ejsByteCode.h
DEPS_136 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_136 += $(CONFIG)/inc/ejsCustomize.h
DEPS_136 += $(CONFIG)/inc/ejs.h
DEPS_136 += $(CONFIG)/inc/ejsCompiler.h
DEPS_136 += $(CONFIG)/obj/ecAst.o
DEPS_136 += $(CONFIG)/obj/ecCodeGen.o
DEPS_136 += $(CONFIG)/obj/ecCompiler.o
DEPS_136 += $(CONFIG)/obj/ecLex.o
DEPS_136 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_136 += $(CONFIG)/obj/ecParser.o
DEPS_136 += $(CONFIG)/obj/ecState.o
DEPS_136 += $(CONFIG)/obj/dtoa.o
DEPS_136 += $(CONFIG)/obj/ejsApp.o
DEPS_136 += $(CONFIG)/obj/ejsArray.o
DEPS_136 += $(CONFIG)/obj/ejsBlock.o
DEPS_136 += $(CONFIG)/obj/ejsBoolean.o
DEPS_136 += $(CONFIG)/obj/ejsByteArray.o
DEPS_136 += $(CONFIG)/obj/ejsCache.o
DEPS_136 += $(CONFIG)/obj/ejsCmd.o
DEPS_136 += $(CONFIG)/obj/ejsConfig.o
DEPS_136 += $(CONFIG)/obj/ejsDate.o
DEPS_136 += $(CONFIG)/obj/ejsDebug.o
DEPS_136 += $(CONFIG)/obj/ejsError.o
DEPS_136 += $(CONFIG)/obj/ejsFile.o
DEPS_136 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_136 += $(CONFIG)/obj/ejsFrame.o
DEPS_136 += $(CONFIG)/obj/ejsFunction.o
DEPS_136 += $(CONFIG)/obj/ejsGC.o
DEPS_136 += $(CONFIG)/obj/ejsGlobal.o
DEPS_136 += $(CONFIG)/obj/ejsHttp.o
DEPS_136 += $(CONFIG)/obj/ejsIterator.o
DEPS_136 += $(CONFIG)/obj/ejsJSON.o
DEPS_136 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_136 += $(CONFIG)/obj/ejsMath.o
DEPS_136 += $(CONFIG)/obj/ejsMemory.o
DEPS_136 += $(CONFIG)/obj/ejsMprLog.o
DEPS_136 += $(CONFIG)/obj/ejsNamespace.o
DEPS_136 += $(CONFIG)/obj/ejsNull.o
DEPS_136 += $(CONFIG)/obj/ejsNumber.o
DEPS_136 += $(CONFIG)/obj/ejsObject.o
DEPS_136 += $(CONFIG)/obj/ejsPath.o
DEPS_136 += $(CONFIG)/obj/ejsPot.o
DEPS_136 += $(CONFIG)/obj/ejsRegExp.o
DEPS_136 += $(CONFIG)/obj/ejsSocket.o
DEPS_136 += $(CONFIG)/obj/ejsString.o
DEPS_136 += $(CONFIG)/obj/ejsSystem.o
DEPS_136 += $(CONFIG)/obj/ejsTimer.o
DEPS_136 += $(CONFIG)/obj/ejsType.o
DEPS_136 += $(CONFIG)/obj/ejsUri.o
DEPS_136 += $(CONFIG)/obj/ejsVoid.o
DEPS_136 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_136 += $(CONFIG)/obj/ejsWorker.o
DEPS_136 += $(CONFIG)/obj/ejsXML.o
DEPS_136 += $(CONFIG)/obj/ejsXMLList.o
DEPS_136 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_136 += $(CONFIG)/obj/ejsByteCode.o
DEPS_136 += $(CONFIG)/obj/ejsException.o
DEPS_136 += $(CONFIG)/obj/ejsHelper.o
DEPS_136 += $(CONFIG)/obj/ejsInterp.o
DEPS_136 += $(CONFIG)/obj/ejsLoader.o
DEPS_136 += $(CONFIG)/obj/ejsModule.o
DEPS_136 += $(CONFIG)/obj/ejsScope.o
DEPS_136 += $(CONFIG)/obj/ejsService.o
DEPS_136 += $(CONFIG)/bin/libejs.out
DEPS_136 += $(CONFIG)/obj/ejsc.o
DEPS_136 += $(CONFIG)/bin/ejsc.out
DEPS_136 += src/cmd/ejsmod.h
DEPS_136 += $(CONFIG)/obj/ejsmod.o
DEPS_136 += $(CONFIG)/obj/doc.o
DEPS_136 += $(CONFIG)/obj/docFiles.o
DEPS_136 += $(CONFIG)/obj/listing.o
DEPS_136 += $(CONFIG)/obj/slotGen.o
DEPS_136 += $(CONFIG)/bin/ejsmod.out
DEPS_136 += $(CONFIG)/bin/ejs.mod

$(CONFIG)/bin/ejs.tar.mod: $(DEPS_136)
	( \
	cd src/ejs.tar; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.tar.mod  --optimize 9 *.es ; \
	)

#
#   mvc.es
#
DEPS_137 += src/ejs.mvc/mvc.es

$(CONFIG)/bin/mvc.es: $(DEPS_137)
	( \
	cd src/ejs.mvc; \
	cp mvc.es ../../$(CONFIG)/bin ; \
	)

#
#   mvc
#
DEPS_138 += $(CONFIG)/inc/mpr.h
DEPS_138 += $(CONFIG)/inc/bit.h
DEPS_138 += $(CONFIG)/inc/bitos.h
DEPS_138 += $(CONFIG)/obj/mprLib.o
DEPS_138 += $(CONFIG)/bin/libmpr.out
DEPS_138 += $(CONFIG)/inc/pcre.h
DEPS_138 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_138 += $(CONFIG)/bin/libpcre.out
endif
DEPS_138 += $(CONFIG)/inc/http.h
DEPS_138 += $(CONFIG)/obj/httpLib.o
DEPS_138 += $(CONFIG)/bin/libhttp.out
DEPS_138 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_138 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_138 += $(CONFIG)/inc/ejs.slots.h
DEPS_138 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_138 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_138 += $(CONFIG)/inc/ejsByteCode.h
DEPS_138 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_138 += $(CONFIG)/inc/ejsCustomize.h
DEPS_138 += $(CONFIG)/inc/ejs.h
DEPS_138 += $(CONFIG)/inc/ejsCompiler.h
DEPS_138 += $(CONFIG)/obj/ecAst.o
DEPS_138 += $(CONFIG)/obj/ecCodeGen.o
DEPS_138 += $(CONFIG)/obj/ecCompiler.o
DEPS_138 += $(CONFIG)/obj/ecLex.o
DEPS_138 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_138 += $(CONFIG)/obj/ecParser.o
DEPS_138 += $(CONFIG)/obj/ecState.o
DEPS_138 += $(CONFIG)/obj/dtoa.o
DEPS_138 += $(CONFIG)/obj/ejsApp.o
DEPS_138 += $(CONFIG)/obj/ejsArray.o
DEPS_138 += $(CONFIG)/obj/ejsBlock.o
DEPS_138 += $(CONFIG)/obj/ejsBoolean.o
DEPS_138 += $(CONFIG)/obj/ejsByteArray.o
DEPS_138 += $(CONFIG)/obj/ejsCache.o
DEPS_138 += $(CONFIG)/obj/ejsCmd.o
DEPS_138 += $(CONFIG)/obj/ejsConfig.o
DEPS_138 += $(CONFIG)/obj/ejsDate.o
DEPS_138 += $(CONFIG)/obj/ejsDebug.o
DEPS_138 += $(CONFIG)/obj/ejsError.o
DEPS_138 += $(CONFIG)/obj/ejsFile.o
DEPS_138 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_138 += $(CONFIG)/obj/ejsFrame.o
DEPS_138 += $(CONFIG)/obj/ejsFunction.o
DEPS_138 += $(CONFIG)/obj/ejsGC.o
DEPS_138 += $(CONFIG)/obj/ejsGlobal.o
DEPS_138 += $(CONFIG)/obj/ejsHttp.o
DEPS_138 += $(CONFIG)/obj/ejsIterator.o
DEPS_138 += $(CONFIG)/obj/ejsJSON.o
DEPS_138 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_138 += $(CONFIG)/obj/ejsMath.o
DEPS_138 += $(CONFIG)/obj/ejsMemory.o
DEPS_138 += $(CONFIG)/obj/ejsMprLog.o
DEPS_138 += $(CONFIG)/obj/ejsNamespace.o
DEPS_138 += $(CONFIG)/obj/ejsNull.o
DEPS_138 += $(CONFIG)/obj/ejsNumber.o
DEPS_138 += $(CONFIG)/obj/ejsObject.o
DEPS_138 += $(CONFIG)/obj/ejsPath.o
DEPS_138 += $(CONFIG)/obj/ejsPot.o
DEPS_138 += $(CONFIG)/obj/ejsRegExp.o
DEPS_138 += $(CONFIG)/obj/ejsSocket.o
DEPS_138 += $(CONFIG)/obj/ejsString.o
DEPS_138 += $(CONFIG)/obj/ejsSystem.o
DEPS_138 += $(CONFIG)/obj/ejsTimer.o
DEPS_138 += $(CONFIG)/obj/ejsType.o
DEPS_138 += $(CONFIG)/obj/ejsUri.o
DEPS_138 += $(CONFIG)/obj/ejsVoid.o
DEPS_138 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_138 += $(CONFIG)/obj/ejsWorker.o
DEPS_138 += $(CONFIG)/obj/ejsXML.o
DEPS_138 += $(CONFIG)/obj/ejsXMLList.o
DEPS_138 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_138 += $(CONFIG)/obj/ejsByteCode.o
DEPS_138 += $(CONFIG)/obj/ejsException.o
DEPS_138 += $(CONFIG)/obj/ejsHelper.o
DEPS_138 += $(CONFIG)/obj/ejsInterp.o
DEPS_138 += $(CONFIG)/obj/ejsLoader.o
DEPS_138 += $(CONFIG)/obj/ejsModule.o
DEPS_138 += $(CONFIG)/obj/ejsScope.o
DEPS_138 += $(CONFIG)/obj/ejsService.o
DEPS_138 += $(CONFIG)/bin/libejs.out
DEPS_138 += $(CONFIG)/bin/mvc.es
DEPS_138 += $(CONFIG)/obj/ejsrun.o

$(CONFIG)/bin/mvc.out: $(DEPS_138)
	@echo '      [Link] $(CONFIG)/bin/mvc.out'
	$(CC) -o $(CONFIG)/bin/mvc.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsrun.o" $(LIBS) -Wl,-r 

#
#   ejs.mvc.mod
#
DEPS_139 += src/ejs.mvc/mvc.es
DEPS_139 += $(CONFIG)/inc/mpr.h
DEPS_139 += $(CONFIG)/inc/bit.h
DEPS_139 += $(CONFIG)/inc/bitos.h
DEPS_139 += $(CONFIG)/obj/mprLib.o
DEPS_139 += $(CONFIG)/bin/libmpr.out
DEPS_139 += $(CONFIG)/inc/pcre.h
DEPS_139 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_139 += $(CONFIG)/bin/libpcre.out
endif
DEPS_139 += $(CONFIG)/inc/http.h
DEPS_139 += $(CONFIG)/obj/httpLib.o
DEPS_139 += $(CONFIG)/bin/libhttp.out
DEPS_139 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_139 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_139 += $(CONFIG)/inc/ejs.slots.h
DEPS_139 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_139 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_139 += $(CONFIG)/inc/ejsByteCode.h
DEPS_139 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_139 += $(CONFIG)/inc/ejsCustomize.h
DEPS_139 += $(CONFIG)/inc/ejs.h
DEPS_139 += $(CONFIG)/inc/ejsCompiler.h
DEPS_139 += $(CONFIG)/obj/ecAst.o
DEPS_139 += $(CONFIG)/obj/ecCodeGen.o
DEPS_139 += $(CONFIG)/obj/ecCompiler.o
DEPS_139 += $(CONFIG)/obj/ecLex.o
DEPS_139 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_139 += $(CONFIG)/obj/ecParser.o
DEPS_139 += $(CONFIG)/obj/ecState.o
DEPS_139 += $(CONFIG)/obj/dtoa.o
DEPS_139 += $(CONFIG)/obj/ejsApp.o
DEPS_139 += $(CONFIG)/obj/ejsArray.o
DEPS_139 += $(CONFIG)/obj/ejsBlock.o
DEPS_139 += $(CONFIG)/obj/ejsBoolean.o
DEPS_139 += $(CONFIG)/obj/ejsByteArray.o
DEPS_139 += $(CONFIG)/obj/ejsCache.o
DEPS_139 += $(CONFIG)/obj/ejsCmd.o
DEPS_139 += $(CONFIG)/obj/ejsConfig.o
DEPS_139 += $(CONFIG)/obj/ejsDate.o
DEPS_139 += $(CONFIG)/obj/ejsDebug.o
DEPS_139 += $(CONFIG)/obj/ejsError.o
DEPS_139 += $(CONFIG)/obj/ejsFile.o
DEPS_139 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_139 += $(CONFIG)/obj/ejsFrame.o
DEPS_139 += $(CONFIG)/obj/ejsFunction.o
DEPS_139 += $(CONFIG)/obj/ejsGC.o
DEPS_139 += $(CONFIG)/obj/ejsGlobal.o
DEPS_139 += $(CONFIG)/obj/ejsHttp.o
DEPS_139 += $(CONFIG)/obj/ejsIterator.o
DEPS_139 += $(CONFIG)/obj/ejsJSON.o
DEPS_139 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_139 += $(CONFIG)/obj/ejsMath.o
DEPS_139 += $(CONFIG)/obj/ejsMemory.o
DEPS_139 += $(CONFIG)/obj/ejsMprLog.o
DEPS_139 += $(CONFIG)/obj/ejsNamespace.o
DEPS_139 += $(CONFIG)/obj/ejsNull.o
DEPS_139 += $(CONFIG)/obj/ejsNumber.o
DEPS_139 += $(CONFIG)/obj/ejsObject.o
DEPS_139 += $(CONFIG)/obj/ejsPath.o
DEPS_139 += $(CONFIG)/obj/ejsPot.o
DEPS_139 += $(CONFIG)/obj/ejsRegExp.o
DEPS_139 += $(CONFIG)/obj/ejsSocket.o
DEPS_139 += $(CONFIG)/obj/ejsString.o
DEPS_139 += $(CONFIG)/obj/ejsSystem.o
DEPS_139 += $(CONFIG)/obj/ejsTimer.o
DEPS_139 += $(CONFIG)/obj/ejsType.o
DEPS_139 += $(CONFIG)/obj/ejsUri.o
DEPS_139 += $(CONFIG)/obj/ejsVoid.o
DEPS_139 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_139 += $(CONFIG)/obj/ejsWorker.o
DEPS_139 += $(CONFIG)/obj/ejsXML.o
DEPS_139 += $(CONFIG)/obj/ejsXMLList.o
DEPS_139 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_139 += $(CONFIG)/obj/ejsByteCode.o
DEPS_139 += $(CONFIG)/obj/ejsException.o
DEPS_139 += $(CONFIG)/obj/ejsHelper.o
DEPS_139 += $(CONFIG)/obj/ejsInterp.o
DEPS_139 += $(CONFIG)/obj/ejsLoader.o
DEPS_139 += $(CONFIG)/obj/ejsModule.o
DEPS_139 += $(CONFIG)/obj/ejsScope.o
DEPS_139 += $(CONFIG)/obj/ejsService.o
DEPS_139 += $(CONFIG)/bin/libejs.out
DEPS_139 += $(CONFIG)/obj/ejsc.o
DEPS_139 += $(CONFIG)/bin/ejsc.out
DEPS_139 += src/cmd/ejsmod.h
DEPS_139 += $(CONFIG)/obj/ejsmod.o
DEPS_139 += $(CONFIG)/obj/doc.o
DEPS_139 += $(CONFIG)/obj/docFiles.o
DEPS_139 += $(CONFIG)/obj/listing.o
DEPS_139 += $(CONFIG)/obj/slotGen.o
DEPS_139 += $(CONFIG)/bin/ejsmod.out
DEPS_139 += $(CONFIG)/bin/ejs.mod
DEPS_139 += $(CONFIG)/bin/ejs.web.mod
DEPS_139 += $(CONFIG)/bin/ejs.template.mod
DEPS_139 += $(CONFIG)/bin/ejs.unix.mod

$(CONFIG)/bin/ejs.mvc.mod: $(DEPS_139)
	( \
	cd src/ejs.mvc; \
	../../$(CONFIG)/bin/ejsc --out ../../$(CONFIG)/bin/ejs.mvc.mod  --optimize 9 *.es ; \
	)

#
#   utest.es
#
DEPS_140 += src/ejs.utest/utest.es

$(CONFIG)/bin/utest.es: $(DEPS_140)
	( \
	cd src/ejs.utest; \
	cp utest.es ../../$(CONFIG)/bin ; \
	)

#
#   utest.worker
#
DEPS_141 += src/ejs.utest/utest.worker

$(CONFIG)/bin/utest.worker: $(DEPS_141)
	( \
	cd src/ejs.utest; \
	cp utest.worker ../../$(CONFIG)/bin ; \
	)

#
#   utest
#
DEPS_142 += $(CONFIG)/inc/mpr.h
DEPS_142 += $(CONFIG)/inc/bit.h
DEPS_142 += $(CONFIG)/inc/bitos.h
DEPS_142 += $(CONFIG)/obj/mprLib.o
DEPS_142 += $(CONFIG)/bin/libmpr.out
DEPS_142 += $(CONFIG)/inc/pcre.h
DEPS_142 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_142 += $(CONFIG)/bin/libpcre.out
endif
DEPS_142 += $(CONFIG)/inc/http.h
DEPS_142 += $(CONFIG)/obj/httpLib.o
DEPS_142 += $(CONFIG)/bin/libhttp.out
DEPS_142 += $(CONFIG)/inc/ejs.cache.local.slots.h
DEPS_142 += $(CONFIG)/inc/ejs.db.sqlite.slots.h
DEPS_142 += $(CONFIG)/inc/ejs.slots.h
DEPS_142 += $(CONFIG)/inc/ejs.web.slots.h
DEPS_142 += $(CONFIG)/inc/ejs.zlib.slots.h
DEPS_142 += $(CONFIG)/inc/ejsByteCode.h
DEPS_142 += $(CONFIG)/inc/ejsByteCodeTable.h
DEPS_142 += $(CONFIG)/inc/ejsCustomize.h
DEPS_142 += $(CONFIG)/inc/ejs.h
DEPS_142 += $(CONFIG)/inc/ejsCompiler.h
DEPS_142 += $(CONFIG)/obj/ecAst.o
DEPS_142 += $(CONFIG)/obj/ecCodeGen.o
DEPS_142 += $(CONFIG)/obj/ecCompiler.o
DEPS_142 += $(CONFIG)/obj/ecLex.o
DEPS_142 += $(CONFIG)/obj/ecModuleWrite.o
DEPS_142 += $(CONFIG)/obj/ecParser.o
DEPS_142 += $(CONFIG)/obj/ecState.o
DEPS_142 += $(CONFIG)/obj/dtoa.o
DEPS_142 += $(CONFIG)/obj/ejsApp.o
DEPS_142 += $(CONFIG)/obj/ejsArray.o
DEPS_142 += $(CONFIG)/obj/ejsBlock.o
DEPS_142 += $(CONFIG)/obj/ejsBoolean.o
DEPS_142 += $(CONFIG)/obj/ejsByteArray.o
DEPS_142 += $(CONFIG)/obj/ejsCache.o
DEPS_142 += $(CONFIG)/obj/ejsCmd.o
DEPS_142 += $(CONFIG)/obj/ejsConfig.o
DEPS_142 += $(CONFIG)/obj/ejsDate.o
DEPS_142 += $(CONFIG)/obj/ejsDebug.o
DEPS_142 += $(CONFIG)/obj/ejsError.o
DEPS_142 += $(CONFIG)/obj/ejsFile.o
DEPS_142 += $(CONFIG)/obj/ejsFileSystem.o
DEPS_142 += $(CONFIG)/obj/ejsFrame.o
DEPS_142 += $(CONFIG)/obj/ejsFunction.o
DEPS_142 += $(CONFIG)/obj/ejsGC.o
DEPS_142 += $(CONFIG)/obj/ejsGlobal.o
DEPS_142 += $(CONFIG)/obj/ejsHttp.o
DEPS_142 += $(CONFIG)/obj/ejsIterator.o
DEPS_142 += $(CONFIG)/obj/ejsJSON.o
DEPS_142 += $(CONFIG)/obj/ejsLocalCache.o
DEPS_142 += $(CONFIG)/obj/ejsMath.o
DEPS_142 += $(CONFIG)/obj/ejsMemory.o
DEPS_142 += $(CONFIG)/obj/ejsMprLog.o
DEPS_142 += $(CONFIG)/obj/ejsNamespace.o
DEPS_142 += $(CONFIG)/obj/ejsNull.o
DEPS_142 += $(CONFIG)/obj/ejsNumber.o
DEPS_142 += $(CONFIG)/obj/ejsObject.o
DEPS_142 += $(CONFIG)/obj/ejsPath.o
DEPS_142 += $(CONFIG)/obj/ejsPot.o
DEPS_142 += $(CONFIG)/obj/ejsRegExp.o
DEPS_142 += $(CONFIG)/obj/ejsSocket.o
DEPS_142 += $(CONFIG)/obj/ejsString.o
DEPS_142 += $(CONFIG)/obj/ejsSystem.o
DEPS_142 += $(CONFIG)/obj/ejsTimer.o
DEPS_142 += $(CONFIG)/obj/ejsType.o
DEPS_142 += $(CONFIG)/obj/ejsUri.o
DEPS_142 += $(CONFIG)/obj/ejsVoid.o
DEPS_142 += $(CONFIG)/obj/ejsWebSocket.o
DEPS_142 += $(CONFIG)/obj/ejsWorker.o
DEPS_142 += $(CONFIG)/obj/ejsXML.o
DEPS_142 += $(CONFIG)/obj/ejsXMLList.o
DEPS_142 += $(CONFIG)/obj/ejsXMLLoader.o
DEPS_142 += $(CONFIG)/obj/ejsByteCode.o
DEPS_142 += $(CONFIG)/obj/ejsException.o
DEPS_142 += $(CONFIG)/obj/ejsHelper.o
DEPS_142 += $(CONFIG)/obj/ejsInterp.o
DEPS_142 += $(CONFIG)/obj/ejsLoader.o
DEPS_142 += $(CONFIG)/obj/ejsModule.o
DEPS_142 += $(CONFIG)/obj/ejsScope.o
DEPS_142 += $(CONFIG)/obj/ejsService.o
DEPS_142 += $(CONFIG)/bin/libejs.out
DEPS_142 += $(CONFIG)/bin/utest.es
DEPS_142 += $(CONFIG)/bin/utest.worker
DEPS_142 += $(CONFIG)/obj/ejsrun.o

$(CONFIG)/bin/utest.out: $(DEPS_142)
	@echo '      [Link] $(CONFIG)/bin/utest.out'
	$(CC) -o $(CONFIG)/bin/utest.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsrun.o" $(LIBS) -Wl,-r 

#
#   bower.json
#
DEPS_143 += package.json

bower.json: $(DEPS_143)
	@echo '      [Copy] bower.json'
	mkdir -p "."
	cp package.json bower.json

#
#   stop
#
stop: $(DEPS_144)

#
#   installBinary
#
installBinary: $(DEPS_145)

#
#   start
#
start: $(DEPS_146)

#
#   install
#
DEPS_147 += stop
DEPS_147 += installBinary
DEPS_147 += start

install: $(DEPS_147)

#
#   uninstall
#
DEPS_148 += stop

uninstall: $(DEPS_148)

