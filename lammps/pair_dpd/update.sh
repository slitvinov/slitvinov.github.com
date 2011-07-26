#! /bin/bash

set -e
set -u

lmp_srcroot=/scratch/work/lammps-ro
cp ${lmp_srcroot}/doc/pair_dpd.html index.html
cp ${lmp_srcroot}/doc/Eqs/pair_dpd*.jpg Eqs/
