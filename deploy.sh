#!/bin/sh

echo rsync deployment for rubymacros.com
rsync -essh -vta --delete --cvs-exclude build/* tinoboxc@tinobox.com:/home2/tinoboxc/public_html/rubymacros
#rsync -essh -vta --delete --cvs-exclude source/* tinoboxc@tinobox.com:/home2/tinoboxc/public_html/rubymacros

