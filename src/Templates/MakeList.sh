
PREFIX=root://cmseos.fnal.gov/
GEN4DIGI=$1
DIGI4AOD=$2
AOD4MINI=$3
MINI4NANO=$4
NAME=$5
YEAR=$6
PD=${NAME}_${YEAR}



if [ ${GEN4DIGI} -eq 1 ]
then
POSTFIX=_GEN
NAME=${NAME}${POSTFIX}
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_gen4digi_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
sed -i '/\inLHE/d' ${outfile}
fi

if [ ${DIGI4AOD} -eq 1 ]
then
POSTFIX=_digi
NAME=${NAME}${POSTFIX}
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_digi4aod_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

if [ ${AOD4MINI} -eq 1 ]
then
POSTFIX=_AOD
NAME=${NAME}${POSTFIX}
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
#echo "The last directory is: $last_dir"
outfile=crab_aod4mini_list.txt
STAMP=${last_dir}
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi


if [ ${MINI4NANO} -eq 1 ]
then
POSTFIX=_MINI
NAME=${NAME}${POSTFIX}
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
#echo "The last directory is: $last_dir"
outfile=crab_mini4nano_list.txt
STAMP=${last_dir}
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

