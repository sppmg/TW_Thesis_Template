#!/bon/bash
# Compress pdf 

echo This is simple script for compress PDF file.
echo WARNING ! Compress PDF may decrease quality of image.

if [ -z "$@" ] ; then
	if [ -f "main.pdf" ] ; then
		pdf="main.pdf"
	else
		echo Error! Please specify PDF for Compress.
		echo Usage: $0 "your_pdf.pdf"
		exit 0
	fi
else
	pdf="$1"
fi

new_pdf="$(basename $pdf .pdf)_compressed.pdf"
bookmark="$(basename $pdf .pdf)_bookmark.txt"
tmp_pdf="$(basename $pdf .pdf)_tmp.pdf"


pdftk "$pdf" dump_data output "$bookmark"

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$tmp_pdf" "$pdf"
pdftk "$tmp_pdf" update_info "$bookmark" output "$new_pdf"

rm "$tmp_pdf" "$bookmark"

echo Finish !
