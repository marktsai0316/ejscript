/**
    genbyte.c - Program to generate various forms of the byte code definition files
  
    Generates: ejsByteCode.h, ejsGoto.h
  
    Interactive shell that interprets interactive sessions and command files.
  
    Copyright (c) All Rights Reserved. See details at the end of the file.
 */

/********************************** Includes **********************************/

#include    "mpr.h"

#define EJS_DEFINE_OPTABLE 1

#include    "ejsByteCodeTable.h"

/********************************** Forwards **********************************/

static void footer(MprFile *file);
static void genByteCodeHeader(Mpr *mpr, cchar *dir);
static void genByteGotoHeader(Mpr *mpr, cchar *dir);
static void header(MprFile *file, cchar *name, cchar *desc);

/************************************ Code ************************************/

int main(int argc, char **argv)
{
    Mpr     *mpr;
    cchar   *dir;

    mpr = mprCreate(argc, argv, NULL);
    if (mprStart(mpr) < 0) {
        mprError("genbyte", "Cannot start mpr services");
        return MPR_ERR;
    }
    dir = (argc == 2) ? argv[1] : ".";
    genByteCodeHeader(mpr, dir);
    genByteGotoHeader(mpr, dir);
    mprDestroy(mpr);
    return 0;
}


static void genByteCodeHeader(Mpr *mpr, cchar *dir)
{
    MprFile     *file;
    EjsOptable  *op;
    char        *path;

    path = mprJoinPath(mpr, dir, "ejsByteCode.h");
    file = mprOpenFile(mpr, path, O_WRONLY | O_CREAT | O_TRUNC, 0664);
    if (file == 0) {
        mprError(mpr, "Cannot open %s", path);
        return;
    } 
    header(file, "ejsByteCode", "Ejscript VM Byte Code");

    mprFprintf(file, "typedef enum EjsOpCode {\n");
    for (op = ejsOptable; op->name; op++) {
        mprFprintf(file, "    EJS_OP_%s,\n", op->name);
    }
    mprFprintf(file, "} EjsOpCode;\n");
    footer(file);
    mprCloseFile(file);
}


static void genByteGotoHeader(Mpr *mpr, cchar *dir)
{
    MprFile     *file;
    EjsOptable  *op;
    char        *path;

    path = mprJoinPath(mpr, dir, "ejsByteGoto.h");
    file = mprOpenFile(mpr, path, O_WRONLY | O_CREAT | O_TRUNC, 0664);
    if (file == 0) {
        mprError(mpr, "Cannot open %s", path);
        return;
    } 
    // header(file, "ejsByteGoto", "Ejscript Byte Code Jump Labels");

    mprFprintf(file, "static void *opcodeJump[] = {\n");
    for (op = ejsOptable; op->name; op++) {
        mprFprintf(file, "    &&EJS_OP_%s,\n", op->name);
    }
    mprFprintf(file, "};\n");
    // footer(file);
    mprCloseFile(file);
}


static void header(MprFile *file, cchar *name, cchar *desc)
{
    mprFprintf(file, "\
/*\n\
 *  %s.h - %s\n\
 *\n\
 *  Copyright (c) All Rights Reserved. See details at the end of the file.\n\
 */\n\
\n\
#ifndef _h_EJS_%s\n\
#define _h_EJS_%s 1\n\
\n\
\n", name, desc, name, name);
}


static void footer(MprFile *file)
{
    mprFprintf(file, "\
\n\
#endif\n\
\n\
/*\n\
    Copyright (c) Embedthis Software. All Rights Reserved.\n\
    Copyright (c) Michael O'Brien. All Rights Reserved.\n\
  \n\
    This software is distributed under commercial and open source licenses.\n\
    You may use the GPL open source license described below or you may acquire\n\
    a commercial license from Embedthis Software. You agree to be fully bound\n\
    by the terms of either license. Consult the LICENSE.md distributed with\n\
    this software for full details and other copyrights.\n\
 */\n");
}

/*
    @copy   default

    Copyright (c) Embedthis Software. All Rights Reserved.

    This software is distributed under commercial and open source licenses.
    You may use the Embedthis Open Source license or you may acquire a 
    commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.md distributed with
    this software for full details and other copyrights.

    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=4 ts=4 expandtab

    @end
 */
