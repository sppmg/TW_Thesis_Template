#!/bin/sh
# windows use busybox sh build.sh
echo "I will build a integrated template for NTU, which language you want?"
read -p "zh / en > " lang

if [ ! $lang = "zh" ] && [ ! $lang = "en" ] ; then
	echo ERROR: Your input is \"$lang\", but only \"zh\" or \"en\" is valid !
	exit 1
fi
if [ ! -d "../NCU_$lang" ] ; then 
	ERROR: Can\'t  find directory \"NCU$lang\"
	exit 1
fi
echo "OK, building $lang version"

cp -r ../NCU_$lang ../NTU_$lang
cp -r ./* ../NTU_$lang
cd ../NTU_$lang
# change class name in every file
find -name "*.tex" -exec sed -i '1 s/NCU_thesis/NTU_thesis/g' {} \;
# remove NCU only files. 
rm titlepage_en.tex titlepage_zh.tex zh_hidden_warning.tex

if [ "$lang" = "en" ] ; then
	sed -i '/lang/ s/zh/en/' config.tex
# Disable Chinese for en avoid no Chinese font
	sed -i '/disableChinese/ s/false/true/' config.tex
	echo "Default disable Chinese for English template avoid no Chinese font, change setting in config.tex if you need Chinese."
	sed -i '/baseFontSize/ s/14/12/' config.tex
	sed -i '/baseLineStretch/ s/1.5/1.3/' config.tex
	rm -rf compatibility
fi

echo "Finish ! Enjoy NTU_$lang LaTeX template by sppmg :D"
