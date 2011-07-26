#! /bin/bash

set -e
set -u

lmp_srcroot=/scratch/work/lammps-ro
msg='<H2><font color="red">proposed patch (not implemented in mainstream version)</font> </H2>'
gawk --lint=fatal -v fl=0 -v msg="${msg}" '{print} (!fl)&&$0~/<HR>/{print $0; print msg; fl=1}' ${lmp_srcroot}/doc/pair_dpd.html > index.html
cp ${lmp_srcroot}/doc/Eqs/pair_dpd*.jpg Eqs/
