GENSTEP=$1
SIMSTEP=$2
DIGISTEP=$3
HLTSTEP=$4
AODSTEP=$5
MINISTEP=$6
NANOSTEP=$7

NAME=XXXX
echo "modes" ${GENSTEP} ${DIGISTEP} ${AODSTEP}

if [ ${GENSTEP} -eq 1 ]
then
cp crab_stepGEN_UL.py ../../../crab_stepGEN_UL_TEMP.py
cp XXXX_1_cfg.py ../../../XXXX_1_cfg.py
pushd ../../../
crab submit crab_stepGEN_UL_TEMP.py
rm crab_stepGEN_UL_TEMP.py
rm XXXX_1_cfg.py
popd
fi

if [ ${SIMSTEP} -eq 1 ]
then
cp crab_stepSIM_UL.py ../../../crab_stepSIM_UL_TEMP.py
cp XXXX_2_cfg.py ../../../XXXX_2_cfg.py
pushd ../../../
crab submit crab_stepSIM_UL_TEMP.py
rm crab_stepSIM_UL_TEMP.py
rm XXXX_2_cfg.py
popd
fi


if [ ${DIGISTEP} -eq 1 ]
then
cp crab_stepDIGI_UL.py ../../../crab_stepDIGI_UL_TEMP.py
cp XXXX_3_cfg.py ../../../XXXX_3_cfg.py
pushd ../../../
crab submit crab_stepDIGI_UL_TEMP.py
rm crab_stepDIGI_UL_TEMP.py
rm XXXX_3_cfg.py
popd
fi

if [ ${HLTSTEP} -eq 1 ]
then
cp crab_stepHLT_UL.py ../../../crab_stepHLT_UL_TEMP.py
cp XXXX_4_cfg.py ../../../XXXX_4_cfg.py
pushd ../../../
crab submit crab_stepHLT_UL_TEMP.py
rm crab_stepHLT_UL_TEMP.py
rm XXXX_4_cfg.py
popd
fi


if [ ${AODSTEP} -eq 1 ]
then
cp crab_stepAOD_UL.py ../../../crab_stepAOD_UL_TEMP.py
cp XXXX_5_cfg.py ../../../XXXX_5_cfg.py
pushd ../../../
crab submit crab_stepAOD_UL_TEMP.py
rm crab_stepAOD_UL_TEMP.py
rm XXXX_5_cfg.py
popd
fi

if [ ${MINISTEP} -eq 1 ]
then
cp crab_stepMINI_UL.py ../../../crab_stepMINI_UL_TEMP.py
cp XXXX_6_cfg.py ../../../XXXX_6_cfg.py
pushd ../../../
crab submit crab_stepMINI_UL_TEMP.py
rm crab_stepMINI_UL_TEMP.py
rm XXXX_6_cfg.py
popd
fi

if [ ${NANOSTEP} -eq 1 ]
then
cp crab_stepNANO_UL.py ../../../crab_stepNANO_UL_TEMP.py
cp XXXX_7_cfg.py ../../../XXXX_7_cfg.py
pushd ../../../
crab submit crab_stepNANO_UL_TEMP.py
rm crab_stepNANO_UL_TEMP.py
rm XXXX_7_cfg.py
popd
fi

