#! /bin/bash

# convert tex file in lammps-ro/doc/Eqs to jpg image

set -e
set -u

function befor() {
    awk '$0~/\\begin{document}/{exit} 1' "$1"
}

function after() {
    awk '$0~/\\begin{document}/{flag=1} flag' "$1"
}


inputfile=$1
textmp=$(mktemp /tmp/modXXXX.tex)


(
befor ${inputfile}
cat <<EOF
 \pagestyle{empty}

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-3cm}
\setlength{\oddsidemargin}{1.5cm}
\addtolength{\oddsidemargin}{-2.54cm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{-3cm}
\setlength{\topmargin}{1.5cm}
\addtolength{\topmargin}{-2.54cm}
EOF
after ${inputfile}
) >  $textmp

(cd /tmp; latex $textmp)
dvipng  -T tight ${textmp/.tex/.dvi} -o ${textmp/.tex/.png}
convert -quality 100 ${textmp/.tex/.png} ${inputfile/.tex/.jpg}

echo ${inputfile/.tex/.jpg}



