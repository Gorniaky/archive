@echo off
cscript slmgr.vbs /ckms>nul
cscript slmgr.vbs /upk>nul
cscript slmgr.vbs /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX>nul
cscript slmgr.vbs /skms kms8.msguides.com>nul
cscript slmgr.vbs /ato
cscript slmgr.vbs /ckms>nul
pause
