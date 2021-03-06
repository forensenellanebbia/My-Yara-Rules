/*
    This Yara ruleset is under the GNU-GPLv2 license (http://www.gnu.org/licenses/gpl-2.0.html) and open to any user or organization, as long as you use it under this license.

*/


rule MALW_LNK
{
    meta:
        description = "Detects possible malicious shortcut files (.LNK)"
        author = "Gabriele Zambelli @gazambelli"
        last_modified = "2018-08-10"
        filetype = "Microsoft Windows Shortcut Files"

    strings:
        $hdr = { 4C 00 00 00 01 14 02 00 00 00 00 00 C0 00 00 00 00 00 00 46 } //header
        $prg = /(bitsadmin|certutil|chrome|cmd|cscript|(i)?explore(r)?|findstr|firefox|powershell|regsvr32|rundll32|schtasks|wmic|wscript)/ ascii wide nocase
        $str = /(%t(e)?mp%|-enc|-nop|-v(ersion)? 2|\/c |bypass|create|download|echo|exi[ft]{1}|hidden|http|("|{)iex|invoke|pastebin|ps1|start|transfer|vbs|\.js|\.lnk)/ ascii wide nocase

    condition:
        $hdr at 0 and $prg and $str
}