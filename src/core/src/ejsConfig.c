/*
    ejsConfig.c -- Config class
  
    Copyright (c) All Rights Reserved. See details at the end of the file.
 */

/********************************** Includes **********************************/

#include    "ejs.h"

/*********************************** Methods **********************************/

void ejsCreateConfigType(Ejs *ejs)
{
    EjsType     *type;
    char        version[16];

    //  MOB -- Config should just be converted back to a non-native type
    type = ejsCreateNativeType(ejs, N("ejs", "Config"), ES_Config, sizeof(EjsObj), NULL, EJS_POT_HELPERS);
    ejs->configType = type;

    ejsSetProperty(ejs, type, ES_Config_Debug, BLD_DEBUG ? ejs->trueValue: ejs->falseValue);
    ejsSetProperty(ejs, type, ES_Config_CPU, ejsCreateStringFromAsc(ejs, BLD_HOST_CPU));
    ejsSetProperty(ejs, type, ES_Config_OS, ejsCreateStringFromAsc(ejs, BLD_OS));
    ejsSetProperty(ejs, type, ES_Config_Product, ejsCreateStringFromAsc(ejs, BLD_PRODUCT));

    ejsSetProperty(ejs, type, ES_Config_Title, ejsCreateStringFromAsc(ejs, BLD_NAME));
    mprSprintf(version, sizeof(version), "%s-%s", BLD_VERSION, BLD_NUMBER);
    ejsSetProperty(ejs, type, ES_Config_Version, ejsCreateStringFromAsc(ejs, version));

    ejsSetProperty(ejs, type, ES_Config_Legacy, ejsCreateBoolean(ejs, BLD_FEATURE_LEGACY_API));
    ejsSetProperty(ejs, type, ES_Config_SSL, ejsCreateBoolean(ejs, BLD_FEATURE_SSL));
    ejsSetProperty(ejs, type, ES_Config_SQLITE, ejsCreateBoolean(ejs, BLD_FEATURE_SQLITE));

#if BLD_WIN_LIKE
{
    EjsString    *path;

    path = ejsCreateStringFromAsc(ejs, mprGetAppDir(ejs));
    ejsSetProperty(ejs, type, ES_Config_BinDir, path);
    ejsSetProperty(ejs, type, ES_Config_ModDir, path);
    ejsSetProperty(ejs, type, ES_Config_LibDir, path);
}
#else
#ifdef BLD_BIN_PREFIX
    ejsSetProperty(ejs, type, ES_Config_BinDir, ejsCreateStringFromAsc(ejs, BLD_BIN_PREFIX));
#endif
#ifdef BLD_MOD_PREFIX
    ejsSetProperty(ejs, type, ES_Config_ModDir, ejsCreateStringFromAsc(ejs, BLD_MOD_PREFIX));
#endif
#ifdef BLD_LIB_PREFIX
    ejsSetProperty(ejs, type, ES_Config_LibDir, ejsCreateStringFromAsc(ejs, BLD_LIB_PREFIX));
#endif
#endif
}


/*
    @copy   default
  
    Copyright (c) Embedthis Software LLC, 2003-2010. All Rights Reserved.
    Copyright (c) Michael O'Brien, 1993-2010. All Rights Reserved.
  
    This software is distributed under commercial and open source licenses.
    You may use the GPL open source license described below or you may acquire
    a commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.TXT distributed with
    this software for full details.
  
    This software is open source; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation; either version 2 of the License, or (at your
    option) any later version. See the GNU General Public License for more
    details at: http://www.embedthis.com/downloads/gplLicense.html
  
    This program is distributed WITHOUT ANY WARRANTY; without even the
    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  
    This GPL license does NOT permit incorporating this software into
    proprietary programs. If you are unable to comply with the GPL, you must
    acquire a commercial license to use this software. Commercial licenses
    for this software and support services are available from Embedthis
    Software at http://www.embedthis.com
  
    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=8 ts=8 expandtab

    @end
 */
