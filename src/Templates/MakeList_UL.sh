
PREFIX=root://cmseos.fnal.gov/
GEN4SIM=$1
SIM4DIGI=$2
DIGI4HLT=$3
HLT4AOD=$4
AOD4MINI=$5
MINI4NANO=$6
NAME=$7
PD=$8



if [ ${GEN4SIM} -eq 1 ]
then
POSTFIX=_GEN
NAME=${NAME}${POSTFIX}
NAME=GEN
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_gen4sim_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
sed -i '/\inLHE/d' ${outfile}
fi

if [ ${SIM4DIGI} -eq 1 ]
then
POSTFIX=_SIM
NAME=${NAME}${POSTFIX}
NAME=SIM
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_sim4digi_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

if [ ${DIGI4HLT} -eq 1 ]
then
POSTFIX=_digi
NAME=${NAME}${POSTFIX}
NAME=digi
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_digi4hlt_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

if [ ${HLT4AOD} -eq 1 ]
then
POSTFIX=_HLT
NAME=${NAME}${POSTFIX}
NAME=HLT
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
STAMP=${last_dir}
outfile=crab_hlt4aod_list.txt
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

if [ ${AOD4MINI} -eq 1 ]
then
POSTFIX=_AOD
NAME=${NAME}${POSTFIX}
NAME=AOD
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
NAME=MINI
last_dir=$(basename "$(xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/)")
#echo "The last directory is: $last_dir"
outfile=crab_mini4nano_list.txt
STAMP=${last_dir}
xrdfs ${PREFIX} ls /store/user/janguian/${PD}/${NAME}/${STAMP}/0000/ > ${outfile}
sed -i 's/^/root:\/\/cmseos.fnal.gov\//' ${outfile}
fi

