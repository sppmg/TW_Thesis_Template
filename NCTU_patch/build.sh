#!/bin/sh
# windows use busybox.exe sh build.sh

# University abbreviation from directory name NCU_...
university=$(basename $(pwd) | cut -f 1 -d "_")

echo "I will build a integrated template for ${university}, which language you want?"
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

cp -r ../NCU_$lang ../${university}_$lang
cp -r ./* ../${university}_$lang
cd ../${university}_$lang

# change class name in every file
sed -i '/^\\documentclass/ s/NCU_thesis/'${university}'_thesis/g'  $(find -name "*.tex" -type f )

if [ "$lang" = "en" ] ; then
    # remove NCU only files. 
    rm titlepage_en.tex titlepage_zh.tex zh_hidden_warning.tex
    
    sed -i '/lang/ s/zh/en/' config.tex
    # Disable Chinese for en avoid no Chinese font
    sed -i '/disableChinese/ s/false/true/' config.tex
    echo "Default disable Chinese for English template avoid no Chinese font, change setting in config.tex if you need Chinese."
    sed -i '/baseFontSize/ s/14/12/' config.tex
    sed -i '/baseLineStretch/ s/1.5/1.3/' config.tex
    sed -i '/\\printbibliography/ s/title = .*,//' main.tex
    rm -rf compatibility
fi

rm build.sh build.bat
echo "Finish ! Enjoy ${university}_$lang LaTeX template by sppmg :D"
