#!/bin/bash
#
#    Converts a PDF to text and then checks for possible double blind violations
#    Copyright (C) 2017 Abram Hindle <hindle1@ualberta.ca>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
FILE="$1"
TXT="$1.txt"

# need pdftotext from poppler-utils
# 
if ! [ -x "$(command -v pdftotext)" ]; then
	echo "pdfotext from poppler-utils is needed in the path"
	exit 1
fi
if ! [ -x "$(command -v pdfinfo)" ]; then
	echo "pdfinfo from poppler-utils is needed in the path"
	exit 1
fi

if ! [ -x `echo 'our work' | grep -Pq '(our) (work)'`]; then
	echo "Please put GNU Grep into the path with Perl options"
	exit 1
fi

SEDPREFIX="s/^/${FILE}:\t/g"

echo "# processing $FILE"
# convert to pdf
pdftotext "$FILE" "$TXT"
echo "# $TXT is created"
# check for email
echo "# There should be no emails, unless from data"
grep -P "[\w\.]+@[\w\.]+(\.\w+)+"  "$TXT" | sed -e "$SEDPREFIX"

# check for acknowledgement
echo "# Acknowledgements should be omitted or blinded"
grep -i ACKNOWLEDGMENT "$TXT" | sed -e "$SEDPREFIX"

# check for self citation
echo "# self citation should not use the language of ownership (plausible deniability)"
echo "# Warning: Lots of false positives"
SELFCITE="(our|my) (previous|paper|prior work|work|study|publication)" 
grep -iP "$SELFCITE" "$TXT" | sed -e "$SEDPREFIX"
paste -s "$TXT" | grep -oiP "$SELFCITE" | sed -e "$SEDPREFIX"

# check letter size
if ! (pdfinfo "$FILE" | grep -i "Page size" | grep -oi 'letter' > /dev/null); then
	echo "Warning the page size is not letter size!"
	pdfinfo "$FILE" | grep -i "Page size" | sed -e "$SEDPREFIX"
fi

if (pdfinfo "$FILE" | grep -i "Author:" > /dev/null); then
	echo "Warning there is author information in the PDF"
	pdfinfo "$FILE" | grep -i "Author:"| sed -e "$SEDPREFIX"
fi
