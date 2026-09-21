GENSTEP=$1
DIGISTEP=$2
AODSTEP=$3
MINISTEP=$4
NANOSTEP=$5

NAME=XXXX
echo "modes" ${GENSTEP} ${DIGISTEP} ${AODSTEP}

if [ ${GENSTEP} -eq 1 ]
then
cp crab_stepGEN.py ../../../../crab_stepGEN_TEMP.py
cp XXXX_1_cfg.py ../../../../XXXX_1_cfg.py
pushd ../../../../
crab submit crab_stepGEN_TEMP.py
rm crab_stepGEN_TEMP.py
rm XXXX_1_cfg.py
popd
fi

if [ ${DIGISTEP} -eq 1 ]
then
cp crab_stepDIGI.py ../../../../crab_stepDIGI_TEMP.py
cp XXXX_2_cfg.py ../../../../XXXX_2_cfg.py
pushd ../../../../
crab submit crab_stepDIGI_TEMP.py
rm crab_stepDIGI_TEMP.py
rm XXXX_2_cfg.py
popd
fi

if [ ${AODSTEP} -eq 1 ]
then
cp crab_stepAOD.py ../../../../crab_stepAOD_TEMP.py
cp XXXX_3_cfg.py ../../../../XXXX_3_cfg.py
pushd ../../../../
crab submit crab_stepAOD_TEMP.py
rm crab_stepAOD_TEMP.py
rm XXXX_3_cfg.py
popd
fi

if [ ${MINISTEP} -eq 1 ]
then
cp crab_stepMINI.py ../../../../crab_stepMINI_TEMP.py
cp XXXX_4_cfg.py ../../../../XXXX_4_cfg.py
pushd ../../../../
crab submit crab_stepMINI_TEMP.py
rm crab_stepMINI_TEMP.py
rm XXXX_4_cfg.py
popd
fi

if [ ${NANOSTEP} -eq 1 ]
then
cp crab_stepNANO.py ../../../../crab_stepNANO_TEMP.py
cp XXXX_5_cfg.py ../../../../XXXX_5_cfg.py
pushd ../../../../
crab submit crab_stepNANO_TEMP.py
rm crab_stepNANO_TEMP.py
rm XXXX_5_cfg.py
popd
fi

