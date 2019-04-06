#!/bin/bash

set -e

OUT=out
IMGFORMAT=".png"

APP="$1"

if [[ ${APP} =~ /mobil ]] ; then
	OUT_W=720
	OUT_H=1280
	DEVICE="phone.png"
fi

TEXTFILE=`echo ${APP} | sed "s/${IMGFORMAT}/.txt/"`
TEXT="`cat ${TEXTFILE}`"

LINES=`echo -e "${TEXT}" | wc -l`

[ $LINES -gt 1 ] && FROMTOP=30 || FROMTOP=60

IMG=`basename ${APP} ${IMGFORMAT}`

OUTDIR=`dirname ${APP}`

[ -d $OUT/$OUTDIR ] || mkdir -p $OUT/$OUTDIR

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
	-geometry +40+195 \
	-composite \
	-resize ${OUT_H}x${OUT_H} \
	screenshot.png

convert text.png \
	\( screenshot.png \) \
	-geometry +60+200 \
	-composite \
	-resize ${OUT_H}x${OUT_H} \
	${OUT}/${OUTDIR}/${IMG}${IMGFORMAT}

rm text.png screenshot.png
