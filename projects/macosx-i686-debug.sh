#
#   build.sh -- Build It Shell Script to build Embedthis Ejscript
#

PLATFORM="macosx-i686-debug"
CC="cc"
CFLAGS="-DMACOSX=1 -DMACOSX -fPIC -Wall -g"
DFLAGS="-DPIC -DCPU=I686"
IFLAGS="-Imacosx-i686-debug/inc"
LDFLAGS="-Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g"
LIBS="-lpthread -lm"

[ ! -x ${PLATFORM}/inc ] && mkdir -p ${PLATFORM}/inc ${PLATFORM}/obj ${PLATFORM}/lib ${PLATFORM}/bin
[ ! -f ${PLATFORM}/inc/buildConfig.h ] && cp src/buildConfig.default ${PLATFORM}/inc/buildConfig.h

rm -rf macosx-i686-debug/inc/mpr.h
cp -r src/deps/mpr/mpr.h macosx-i686-debug/inc/mpr.h

rm -rf macosx-i686-debug/inc/mprSsl.h
cp -r src/deps/mpr/mprSsl.h macosx-i686-debug/inc/mprSsl.h

${CC} -c -o ${PLATFORM}/obj/mprLib.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/mpr/mprLib.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libmpr.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -install_name @rpath/libmpr.dylib ${PLATFORM}/obj/mprLib.o ${LIBS}

${CC} -c -o ${PLATFORM}/obj/mprSsl.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -I../../../../usr/include src/deps/mpr/mprSsl.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libmprssl.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -install_name @rpath/libmprssl.dylib ${PLATFORM}/obj/mprSsl.o ${LIBS} -lmpr -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/makerom.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/mpr/makerom.c

${CC} -o ${PLATFORM}/bin/makerom -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L${PLATFORM}/lib ${PLATFORM}/obj/makerom.o ${LIBS} -lmpr

rm -rf macosx-i686-debug/inc/pcre.h
cp -r src/deps/pcre/pcre.h macosx-i686-debug/inc/pcre.h

${CC} -c -o ${PLATFORM}/obj/pcre.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/pcre/pcre.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libpcre.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -install_name @rpath/libpcre.dylib ${PLATFORM}/obj/pcre.o ${LIBS}

rm -rf macosx-i686-debug/inc/http.h
cp -r src/deps/http/http.h macosx-i686-debug/inc/http.h

${CC} -c -o ${PLATFORM}/obj/httpLib.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/http/httpLib.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libhttp.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -install_name @rpath/libhttp.dylib ${PLATFORM}/obj/httpLib.o ${LIBS} -lmpr -lpcre -lmprssl -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/http.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/http/http.c

${CC} -o ${PLATFORM}/bin/http -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L${PLATFORM}/lib ${PLATFORM}/obj/http.o ${LIBS} -lhttp -lmpr -lpcre -lmprssl -lssl -lcrypto

rm -rf macosx-i686-debug/inc/sqlite3.h
cp -r src/deps/sqlite/sqlite3.h macosx-i686-debug/inc/sqlite3.h

${CC} -c -o ${PLATFORM}/obj/sqlite3.o -arch i686 -fPIC -g ${DFLAGS} -I${PLATFORM}/inc src/deps/sqlite/sqlite3.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libsqlite3.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -install_name @rpath/libsqlite3.dylib ${PLATFORM}/obj/sqlite3.o ${LIBS}

rm -rf macosx-i686-debug/inc/ejs.cache.local.slots.h
cp -r src/slots/ejs.cache.local.slots.h macosx-i686-debug/inc/ejs.cache.local.slots.h

rm -rf macosx-i686-debug/inc/ejs.db.sqlite.slots.h
cp -r src/slots/ejs.db.sqlite.slots.h macosx-i686-debug/inc/ejs.db.sqlite.slots.h

rm -rf macosx-i686-debug/inc/ejs.slots.h
cp -r src/slots/ejs.slots.h macosx-i686-debug/inc/ejs.slots.h

rm -rf macosx-i686-debug/inc/ejs.web.slots.h
cp -r src/slots/ejs.web.slots.h macosx-i686-debug/inc/ejs.web.slots.h

rm -rf macosx-i686-debug/inc/ejs.zlib.slots.h
cp -r src/slots/ejs.zlib.slots.h macosx-i686-debug/inc/ejs.zlib.slots.h

rm -rf macosx-i686-debug/inc/ejs.h
cp -r src/ejs.h macosx-i686-debug/inc/ejs.h

rm -rf macosx-i686-debug/inc/ejsByteCode.h
cp -r src/ejsByteCode.h macosx-i686-debug/inc/ejsByteCode.h

rm -rf macosx-i686-debug/inc/ejsByteCodeTable.h
cp -r src/ejsByteCodeTable.h macosx-i686-debug/inc/ejsByteCodeTable.h

rm -rf macosx-i686-debug/inc/ejsCompiler.h
cp -r src/ejsCompiler.h macosx-i686-debug/inc/ejsCompiler.h

rm -rf macosx-i686-debug/inc/ejsCustomize.h
cp -r src/ejsCustomize.h macosx-i686-debug/inc/ejsCustomize.h

${CC} -c -o ${PLATFORM}/obj/ecAst.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecAst.c

${CC} -c -o ${PLATFORM}/obj/ecCodeGen.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecCodeGen.c

${CC} -c -o ${PLATFORM}/obj/ecCompiler.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecCompiler.c

${CC} -c -o ${PLATFORM}/obj/ecLex.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecLex.c

${CC} -c -o ${PLATFORM}/obj/ecModuleWrite.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecModuleWrite.c

${CC} -c -o ${PLATFORM}/obj/ecParser.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecParser.c

${CC} -c -o ${PLATFORM}/obj/ecState.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/compiler/ecState.c

${CC} -c -o ${PLATFORM}/obj/ejsApp.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsApp.c

${CC} -c -o ${PLATFORM}/obj/ejsArray.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsArray.c

${CC} -c -o ${PLATFORM}/obj/ejsBlock.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsBlock.c

${CC} -c -o ${PLATFORM}/obj/ejsBoolean.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsBoolean.c

${CC} -c -o ${PLATFORM}/obj/ejsByteArray.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsByteArray.c

${CC} -c -o ${PLATFORM}/obj/ejsCache.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsCache.c

${CC} -c -o ${PLATFORM}/obj/ejsCmd.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsCmd.c

${CC} -c -o ${PLATFORM}/obj/ejsConfig.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsConfig.c

${CC} -c -o ${PLATFORM}/obj/ejsDate.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsDate.c

${CC} -c -o ${PLATFORM}/obj/ejsDebug.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsDebug.c

${CC} -c -o ${PLATFORM}/obj/ejsError.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsError.c

${CC} -c -o ${PLATFORM}/obj/ejsFile.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsFile.c

${CC} -c -o ${PLATFORM}/obj/ejsFileSystem.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsFileSystem.c

${CC} -c -o ${PLATFORM}/obj/ejsFrame.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsFrame.c

${CC} -c -o ${PLATFORM}/obj/ejsFunction.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsFunction.c

${CC} -c -o ${PLATFORM}/obj/ejsGC.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsGC.c

${CC} -c -o ${PLATFORM}/obj/ejsGlobal.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsGlobal.c

${CC} -c -o ${PLATFORM}/obj/ejsHttp.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsHttp.c

${CC} -c -o ${PLATFORM}/obj/ejsIterator.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsIterator.c

${CC} -c -o ${PLATFORM}/obj/ejsJSON.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsJSON.c

${CC} -c -o ${PLATFORM}/obj/ejsLocalCache.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsLocalCache.c

${CC} -c -o ${PLATFORM}/obj/ejsMath.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsMath.c

${CC} -c -o ${PLATFORM}/obj/ejsMemory.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsMemory.c

${CC} -c -o ${PLATFORM}/obj/ejsMprLog.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsMprLog.c

${CC} -c -o ${PLATFORM}/obj/ejsNamespace.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsNamespace.c

${CC} -c -o ${PLATFORM}/obj/ejsNull.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsNull.c

${CC} -c -o ${PLATFORM}/obj/ejsNumber.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsNumber.c

${CC} -c -o ${PLATFORM}/obj/ejsObject.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsObject.c

${CC} -c -o ${PLATFORM}/obj/ejsPath.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsPath.c

${CC} -c -o ${PLATFORM}/obj/ejsPot.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsPot.c

${CC} -c -o ${PLATFORM}/obj/ejsRegExp.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsRegExp.c

${CC} -c -o ${PLATFORM}/obj/ejsSocket.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsSocket.c

${CC} -c -o ${PLATFORM}/obj/ejsString.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsString.c

${CC} -c -o ${PLATFORM}/obj/ejsSystem.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsSystem.c

${CC} -c -o ${PLATFORM}/obj/ejsTimer.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsTimer.c

${CC} -c -o ${PLATFORM}/obj/ejsType.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsType.c

${CC} -c -o ${PLATFORM}/obj/ejsUri.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsUri.c

${CC} -c -o ${PLATFORM}/obj/ejsVoid.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsVoid.c

${CC} -c -o ${PLATFORM}/obj/ejsWorker.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsWorker.c

${CC} -c -o ${PLATFORM}/obj/ejsXML.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsXML.c

${CC} -c -o ${PLATFORM}/obj/ejsXMLList.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsXMLList.c

${CC} -c -o ${PLATFORM}/obj/ejsXMLLoader.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/core/src/ejsXMLLoader.c

${CC} -c -o ${PLATFORM}/obj/ejsByteCode.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsByteCode.c

${CC} -c -o ${PLATFORM}/obj/ejsException.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsException.c

${CC} -c -o ${PLATFORM}/obj/ejsHelper.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsHelper.c

${CC} -c -o ${PLATFORM}/obj/ejsInterp.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsInterp.c

${CC} -c -o ${PLATFORM}/obj/ejsLoader.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsLoader.c

${CC} -c -o ${PLATFORM}/obj/ejsModule.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsModule.c

${CC} -c -o ${PLATFORM}/obj/ejsScope.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsScope.c

${CC} -c -o ${PLATFORM}/obj/ejsService.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/vm/ejsService.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libejs.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -install_name @rpath/libejs.dylib ${PLATFORM}/obj/ecAst.o ${PLATFORM}/obj/ecCodeGen.o ${PLATFORM}/obj/ecCompiler.o ${PLATFORM}/obj/ecLex.o ${PLATFORM}/obj/ecModuleWrite.o ${PLATFORM}/obj/ecParser.o ${PLATFORM}/obj/ecState.o ${PLATFORM}/obj/ejsApp.o ${PLATFORM}/obj/ejsArray.o ${PLATFORM}/obj/ejsBlock.o ${PLATFORM}/obj/ejsBoolean.o ${PLATFORM}/obj/ejsByteArray.o ${PLATFORM}/obj/ejsCache.o ${PLATFORM}/obj/ejsCmd.o ${PLATFORM}/obj/ejsConfig.o ${PLATFORM}/obj/ejsDate.o ${PLATFORM}/obj/ejsDebug.o ${PLATFORM}/obj/ejsError.o ${PLATFORM}/obj/ejsFile.o ${PLATFORM}/obj/ejsFileSystem.o ${PLATFORM}/obj/ejsFrame.o ${PLATFORM}/obj/ejsFunction.o ${PLATFORM}/obj/ejsGC.o ${PLATFORM}/obj/ejsGlobal.o ${PLATFORM}/obj/ejsHttp.o ${PLATFORM}/obj/ejsIterator.o ${PLATFORM}/obj/ejsJSON.o ${PLATFORM}/obj/ejsLocalCache.o ${PLATFORM}/obj/ejsMath.o ${PLATFORM}/obj/ejsMemory.o ${PLATFORM}/obj/ejsMprLog.o ${PLATFORM}/obj/ejsNamespace.o ${PLATFORM}/obj/ejsNull.o ${PLATFORM}/obj/ejsNumber.o ${PLATFORM}/obj/ejsObject.o ${PLATFORM}/obj/ejsPath.o ${PLATFORM}/obj/ejsPot.o ${PLATFORM}/obj/ejsRegExp.o ${PLATFORM}/obj/ejsSocket.o ${PLATFORM}/obj/ejsString.o ${PLATFORM}/obj/ejsSystem.o ${PLATFORM}/obj/ejsTimer.o ${PLATFORM}/obj/ejsType.o ${PLATFORM}/obj/ejsUri.o ${PLATFORM}/obj/ejsVoid.o ${PLATFORM}/obj/ejsWorker.o ${PLATFORM}/obj/ejsXML.o ${PLATFORM}/obj/ejsXMLList.o ${PLATFORM}/obj/ejsXMLLoader.o ${PLATFORM}/obj/ejsByteCode.o ${PLATFORM}/obj/ejsException.o ${PLATFORM}/obj/ejsHelper.o ${PLATFORM}/obj/ejsInterp.o ${PLATFORM}/obj/ejsLoader.o ${PLATFORM}/obj/ejsModule.o ${PLATFORM}/obj/ejsScope.o ${PLATFORM}/obj/ejsService.o ${LIBS} -lmpr -lpcre -lhttp -lmprssl -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/ejs.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/cmd/ejs.c

${CC} -o ${PLATFORM}/bin/ejs -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L${PLATFORM}/lib ${PLATFORM}/obj/ejs.o ${LIBS} -lejs -lmpr -lpcre -lhttp -lmprssl -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/ejsc.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/cmd/ejsc.c

${CC} -o ${PLATFORM}/bin/ejsc -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L${PLATFORM}/lib ${PLATFORM}/obj/ejsc.o ${LIBS} -lejs -lmpr -lpcre -lhttp -lmprssl -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/ejsmod.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/cmd src/cmd/ejsmod.c

${CC} -c -o ${PLATFORM}/obj/doc.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/cmd src/cmd/doc.c

${CC} -c -o ${PLATFORM}/obj/docFiles.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/cmd src/cmd/docFiles.c

${CC} -c -o ${PLATFORM}/obj/listing.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/cmd src/cmd/listing.c

${CC} -c -o ${PLATFORM}/obj/slotGen.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/cmd src/cmd/slotGen.c

${CC} -o ${PLATFORM}/bin/ejsmod -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L${PLATFORM}/lib ${PLATFORM}/obj/ejsmod.o ${PLATFORM}/obj/doc.o ${PLATFORM}/obj/docFiles.o ${PLATFORM}/obj/listing.o ${PLATFORM}/obj/slotGen.o ${LIBS} -lejs -lmpr -lpcre -lhttp -lmprssl -lssl -lcrypto

${CC} -c -o ${PLATFORM}/obj/ejsrun.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/cmd/ejsrun.c

${CC} -o ${PLATFORM}/bin/ejsrun -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L${PLATFORM}/lib ${PLATFORM}/obj/ejsrun.o ${LIBS} -lejs -lmpr -lpcre -lhttp -lmprssl -lssl -lcrypto

ejsc --out ${PLATFORM}/lib/ejs.mod --debug --optimize 9 --bind --require null src/core/*.es 
ejsmod --require null --listing --cslots ${PLATFORM}/lib/ejs.mod
cp ejs.slots.h ${PLATFORM}/inc
cp src/jems/ejs.bit/bit.es ${PLATFORM}/bin
cp src/jems/ejs.utest/utest.es ${PLATFORM}/bin
rm -fr ${PLATFORM}/lib/bits
cp -r src/jems/ejs.bit/bits ${PLATFORM}/lib
ejsc --out ${PLATFORM}/lib/ejs.unix.mod --debug --optimize 9 src/jems/ejs.unix/Unix.es
cp src/jems/ejs.jem/jem.es ${PLATFORM}/bin
ejsc --out ${PLATFORM}/lib/ejs.db.mod --debug --optimize 9 src/jems/ejs.db/*.es
ejsc --out ${PLATFORM}/lib/ejs.db.mapper.mod --debug --optimize 9 src/jems/ejs.db.mapper/*.es
ejsc --out ${PLATFORM}/lib/ejs.db.sqlite.mod --debug --optimize 9 src/jems/ejs.db.sqlite/*.es
${CC} -c -o ${PLATFORM}/obj/ejsSqlite.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/jems/ejs.db.sqlite/src/ejsSqlite.c

${CC} -dynamiclib -o ${PLATFORM}/lib/ejs.db.sqlite.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -install_name @rpath/ejs.db.sqlite.dylib ${PLATFORM}/obj/ejsSqlite.o ${LIBS} -lmpr -lejs -lpcre -lhttp -lmprssl -lssl -lcrypto -lsqlite3

ejsc --out ${PLATFORM}/lib/ejs.web.mod --debug --optimize 9 src/jems/ejs.web/*.es
ejsmod --cslots ${PLATFORM}/lib/ejs.web.mod
cp ejs.web.slots.h ${PLATFORM}/inc
${CC} -c -o ${PLATFORM}/obj/ejsHttpServer.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/jems/ejs.web/src src/jems/ejs.web/src/ejsHttpServer.c

${CC} -c -o ${PLATFORM}/obj/ejsRequest.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/jems/ejs.web/src src/jems/ejs.web/src/ejsRequest.c

${CC} -c -o ${PLATFORM}/obj/ejsSession.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/jems/ejs.web/src src/jems/ejs.web/src/ejsSession.c

${CC} -c -o ${PLATFORM}/obj/ejsWeb.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -Isrc/jems/ejs.web/src src/jems/ejs.web/src/ejsWeb.c

${CC} -dynamiclib -o ${PLATFORM}/lib/ejs.web.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -install_name @rpath/ejs.web.dylib ${PLATFORM}/obj/ejsHttpServer.o ${PLATFORM}/obj/ejsRequest.o ${PLATFORM}/obj/ejsSession.o ${PLATFORM}/obj/ejsWeb.o ${LIBS} -lmpr -lhttp -lpcre -lmprssl -lssl -lcrypto -lpcre -lejs

rm -fr ${PLATFORM}/lib/www
cp -r src/jems/ejs.web/www ${PLATFORM}/lib
ejsc --out ${PLATFORM}/lib/ejs.template.mod --debug --optimize 9 src/jems/ejs.template/TemplateParser.es
ejsc --out ${PLATFORM}/lib/ejs.tar.mod/ --debug --optimize 9 src/jems/ejs.tar/*.es
ejsc --out ${PLATFORM}/lib/ejs.zlib.mod/ --debug --optimize 9 src/jems/ejs.zlib/*.es
${CC} -c -o ${PLATFORM}/obj/ejsZlib.o -arch i686 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc -I../../../../usr/include src/jems/ejs.zlib/src/ejsZlib.c

${CC} -dynamiclib -o ${PLATFORM}/lib/ejs.zlib.dylib -arch i686 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -L/usr/lib -L/usr/lib -install_name @rpath/ejs.zlib.dylib ${PLATFORM}/obj/ejsZlib.o ${LIBS} -lmpr -lejs -lpcre -lhttp -lmprssl -lssl -lcrypto -lz

cp src/jems/ejs.mvc/mvc.es ${PLATFORM}/bin
ejsc --out ${PLATFORM}/lib/ejs.mvc.mod/ --debug --optimize 9 src/jems/ejs.mvc/*.es
cp src/jems/ejs.utest/utest.worker ${PLATFORM}/bin