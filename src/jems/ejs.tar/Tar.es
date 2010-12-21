/**
    Tar.es -- Tar class
    @hide
 */

module ejs.tar {

    //  MOB -- need some ability to trace commands  (tar tvf)

    /** @hide */
    class Tar {
        private var path: Path
        private var files = []

        use default namespace public

        function Tar(path: Path) {
            this.path = path.portable
            if (this.path.hasDrive) {
                //  MOB - temp hack until we have proper zip class
                this.path = this.path.toString().slice(2)
            }
        }
        function add(path: Path): Void {
            path = path.portable
            if (!files.contains(path)) {
                files.append(path)
            }
        }
        function create(): Void {
            let cmd = "tar czf " + path + " " + files.join(" ")
            cmd = cmd.replace(/\\/g, "\\\\")
            Cmd.sh(cmd)
        }
        function extract(...files): Void {
            let cmd = "tar xzf " + path + " " + files.join(" ")
            cmd = cmd.replace(/\\/g, "\\\\")
            Cmd.sh(cmd)
        }
        function cat(...files): String {
            let cmd = "tar xOzf " + path + " " + files.join(" ")
            cmd = cmd.replace(/\\/g, "\\\\")
            return Cmd.sh(cmd)
        }
    }
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
 *
    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=8 ts=8 expandtab

    @end
 */
