/*
    bit.h -- Build It Configuration Header for solaris-x86

    This header is generated by Bit during configuration. To change settings, re-run
    configure or define variables in your Makefile to override these default values.
 */

/* Settings */
#ifndef BIT_BUILD_NUMBER
    #define BIT_BUILD_NUMBER "0"
#endif
#ifndef BIT_COMPANY
    #define BIT_COMPANY "Embedthis"
#endif
#ifndef BIT_DEPTH
    #define BIT_DEPTH 1
#endif
#ifndef BIT_HAS_DOUBLE_BRACES
    #define BIT_HAS_DOUBLE_BRACES 1
#endif
#ifndef BIT_HAS_DYN_LOAD
    #define BIT_HAS_DYN_LOAD 1
#endif
#ifndef BIT_HAS_LIB_EDIT
    #define BIT_HAS_LIB_EDIT 0
#endif
#ifndef BIT_HAS_MMU
    #define BIT_HAS_MMU 1
#endif
#ifndef BIT_HAS_MTUNE
    #define BIT_HAS_MTUNE 1
#endif
#ifndef BIT_HAS_PAM
    #define BIT_HAS_PAM 0
#endif
#ifndef BIT_HAS_STACK_PROTECTOR
    #define BIT_HAS_STACK_PROTECTOR 1
#endif
#ifndef BIT_HAS_SYNC
    #define BIT_HAS_SYNC 0
#endif
#ifndef BIT_HAS_SYNC_CAS
    #define BIT_HAS_SYNC_CAS 0
#endif
#ifndef BIT_HAS_UNNAMED_UNIONS
    #define BIT_HAS_UNNAMED_UNIONS 1
#endif
#ifndef BIT_MANAGER
    #define BIT_MANAGER "ejsman"
#endif
#ifndef BIT_MINIMAL
    #define BIT_MINIMAL "doxygen,dsi,man,man2html,zlib"
#endif
#ifndef BIT_OPTIONAL
    #define BIT_OPTIONAL "doxygen,dsi,man,man2html,openssl,matrixssl,pmaker,sqlite,ssl,zlib,zip"
#endif
#ifndef BIT_PACKS
    #define BIT_PACKS "bits/packs"
#endif
#ifndef BIT_PLATFORMS
    #define BIT_PLATFORMS "local"
#endif
#ifndef BIT_PRODUCT
    #define BIT_PRODUCT "ejs"
#endif
#ifndef BIT_REQUIRED
    #define BIT_REQUIRED "compiler,link,pcre"
#endif
#ifndef BIT_SYNC
    #define BIT_SYNC "http,mpr,pcre,sqlite"
#endif
#ifndef BIT_TITLE
    #define BIT_TITLE "Embedthis Ejscript"
#endif
#ifndef BIT_VERSION
    #define BIT_VERSION "2.0.1"
#endif
#ifndef BIT_WARN64TO32
    #define BIT_WARN64TO32 0
#endif
#ifndef BIT_WARN_UNUSED
    #define BIT_WARN_UNUSED 0
#endif

/* Prefixes */
#ifndef BIT_CFG_PREFIX
    #define BIT_CFG_PREFIX "/etc/ejs"
#endif
#ifndef BIT_BIN_PREFIX
    #define BIT_BIN_PREFIX "/usr/lib/ejs/2.0.1/bin"
#endif
#ifndef BIT_INC_PREFIX
    #define BIT_INC_PREFIX "/usr/lib/ejs/2.0.1/inc"
#endif
#ifndef BIT_LOG_PREFIX
    #define BIT_LOG_PREFIX "/var/log/ejs"
#endif
#ifndef BIT_PRD_PREFIX
    #define BIT_PRD_PREFIX "/usr/lib/ejs"
#endif
#ifndef BIT_SPL_PREFIX
    #define BIT_SPL_PREFIX "/var/spool/ejs"
#endif
#ifndef BIT_SRC_PREFIX
    #define BIT_SRC_PREFIX "/usr/src/ejs-2.0.1"
#endif
#ifndef BIT_VER_PREFIX
    #define BIT_VER_PREFIX "/usr/lib/ejs/2.0.1"
#endif
#ifndef BIT_WEB_PREFIX
    #define BIT_WEB_PREFIX "/var/www/ejs-default"
#endif

/* Suffixes */
#ifndef BIT_EXE
    #define BIT_EXE ""
#endif
#ifndef BIT_SHLIB
    #define BIT_SHLIB ".so"
#endif
#ifndef BIT_SHOBJ
    #define BIT_SHOBJ ".so"
#endif
#ifndef BIT_LIB
    #define BIT_LIB ".a"
#endif
#ifndef BIT_OBJ
    #define BIT_OBJ ".o"
#endif

/* Profile */
#ifndef BIT_CONFIG_CMD
    #define BIT_CONFIG_CMD "bit -d -q -platform solaris-x86 -without all -configure . -gen sh,make"
#endif
#ifndef BIT_EJS_PRODUCT
    #define BIT_EJS_PRODUCT 1
#endif
#ifndef BIT_PROFILE
    #define BIT_PROFILE "debug"
#endif

/* Miscellaneous */
#ifndef BIT_MAJOR_VERSION
    #define BIT_MAJOR_VERSION 2
#endif
#ifndef BIT_MINOR_VERSION
    #define BIT_MINOR_VERSION 0
#endif
#ifndef BIT_PATCH_VERSION
    #define BIT_PATCH_VERSION 1
#endif
#ifndef BIT_VNUM
    #define BIT_VNUM 200000001
#endif

/* Packs */
#ifndef BIT_PACK_CC
    #define BIT_PACK_CC 1
#endif
#ifndef BIT_PACK_DOXYGEN
    #define BIT_PACK_DOXYGEN 0
#endif
#ifndef BIT_PACK_DSI
    #define BIT_PACK_DSI 0
#endif
#ifndef BIT_PACK_LINK
    #define BIT_PACK_LINK 1
#endif
#ifndef BIT_PACK_MAN
    #define BIT_PACK_MAN 0
#endif
#ifndef BIT_PACK_MAN2HTML
    #define BIT_PACK_MAN2HTML 0
#endif
#ifndef BIT_PACK_MATRIXSSL
    #define BIT_PACK_MATRIXSSL 0
#endif
#ifndef BIT_PACK_OPENSSL
    #define BIT_PACK_OPENSSL 0
#endif
#ifndef BIT_PACK_PCRE
    #define BIT_PACK_PCRE 1
#endif
#ifndef BIT_PACK_PMAKER
    #define BIT_PACK_PMAKER 1
#endif
#ifndef BIT_PACK_SQLITE
    #define BIT_PACK_SQLITE 1
#endif
#ifndef BIT_PACK_SSL
    #define BIT_PACK_SSL 0
#endif
#ifndef BIT_PACK_ZIP
    #define BIT_PACK_ZIP 1
#endif
#ifndef BIT_PACK_ZLIB
    #define BIT_PACK_ZLIB 0
#endif
