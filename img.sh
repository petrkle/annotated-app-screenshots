#!/bin/bash

set -e

OUT=out
IMGFORMAT=".png"

APP="$1"

if [[ ${APP} =~ /mobil ]] ; then
	OUT_W=720
	OUT_H=1280
	DEVICE="phone.png"
	APPGEOMETRY="+40+195"
	TEXTGEOMETRY="+60+200"
fi

if [[ ${APP} =~ /tablet7 ]] ; then
	OUT_W=1024
	OUT_H=768
	DEVICE="tablet7.png"
	APPGEOMETRY="+120+45"
	TEXTGEOMETRY="+0+200"
fi

if [[ ${APP} =~ /tablet10 ]] ; then
	OUT_W=1280
	OUT_H=900
	DEVICE="tablet10.png"
	APPGEOMETRY="+160+50"
	TEXTGEOMETRY="+0+200"
fi

APPDIR=`dirname ${APP}`
IMG=`basename ${APP} ${IMGFORMAT}`

TEXT="`grep \"${IMG}${IMGFORMAT}:\" ${APPDIR}/index.txt | cut -d: -f2`"

LINES=`echo -e "${TEXT}" | wc -l`

[ $LINES -gt 1 ] && FROMTOP=30 || FROMTOP=60


[ -d $OUT/$APPDIR ] || mkdir -p $OUT/$APPDIR

convert -size ${OUT_W}x${OUT_H} xc:'#eee' \
	-font Roboto-Medium \
	-pointsize 60 \
	-fill black \
	-gravity north \
	-stroke none \
	-annotate +0+${FROMTOP} \
	"${TEXT}" \
	text.png

convert ${DEVICE} \
	\( ${APP} \) \
	-geometry ${APPGEOMETRY} \
	-composite \
	-resize ${OUT_W}x${OUT_H} \
	screenshot.png

convert text.png \
	\( screenshot.png \) \
	-geometry ${TEXTGEOMETRY} \
	-composite \
	-resize ${OUT_W}x${OUT_H} \
	${OUT}/${APPDIR}/${IMG}${IMGFORMAT}

rm text.png screenshot.png
