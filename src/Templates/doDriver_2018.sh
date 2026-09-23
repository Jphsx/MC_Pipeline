NEVENT=10
NAME=XXXX
PROJECT=PPPP
FRAGMENT=FFFF


pushd ../../../../
cmsDriver.py Configuration/GenProduction/python/${FRAGMENT} \
    --python_filename ${NAME}_1_cfg.py \
    --eventcontent RAWSIM,LHE \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier RAWSIM,LHE \
    --fileout file:${NAME}_1.root \
    --conditions 106X_upgrade2018_realistic_v4 \
    --beamspot Realistic25ns13TeVEarly2018Collision \
    --step LHE,GEN \
    --geometry DB:Extended \
    --era Run2_2018 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_1_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
        --python_filename ${NAME}_2_cfg.py \
        --eventcontent RAWSIM \
        --customise Configuration/DataProcessing/Utils.addMonitoring \
        --datatier GEN-SIM \
        --fileout file:${NAME}_2.root \
        --conditions 106X_upgrade2018_realistic_v11_L1v1 \
        --beamspot Realistic25ns13TeVEarly2018Collision \
        --step SIM \
        --geometry DB:Extended \
        --filein file:${NAME}_1.root \
        --era Run2_2018 \
        --runUnscheduled \
        --no_exec \
        --mc \
        -n ${NEVENT}

mv ${NAME}_2_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_3_cfg.py \
    --eventcontent PREMIXRAW \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM-DIGI \
    --fileout file:${NAME}_3.root \
    --pileup_input dbs:/Neutrino_E-10_gun/RunIISummer20ULPrePremix-UL18_106X_upgrade2018_realistic_v11_L1v1-v2/PREMIX \
    --conditions 106X_upgrade2018_realistic_v11_L1v1 \
    --step DIGI,DATAMIX,L1,DIGI2RAW \
    --procModifiers premix_stage2 \
    --geometry DB:Extended \
    --filein file:${NAME}_2.root \
    --datamix PreMix \
    --era Run2_2018 \
    --runUnscheduled \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_3_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_4_cfg.py \
    --eventcontent RAWSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM-RAW \
    --fileout file:${NAME}_4.root \
    --conditions 102X_upgrade2018_realistic_v15 \
    --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' \
    --step HLT:2018v32 \
    --geometry DB:Extended \
    --filein file:${NAME}_3.root \
    --era Run2_2018 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_4_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/
cmsDriver.py \
    --python_filename ${NAME}_5_cfg.py \
    --eventcontent AODSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier AODSIM \
    --fileout file:${NAME}_AOD.root \
    --conditions 106X_upgrade2018_realistic_v11_L1v1 \
    --step RAW2DIGI,L1Reco,RECO,RECOSIM,EI \
    --geometry DB:Extended \
    --filein file:${NAME}_4.root \
    --era Run2_2018 \
    --runUnscheduled \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_5_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_6_cfg.py \
    --eventcontent MINIAODSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier MINIAODSIM \
    --fileout file:${NAME}_MINI.root \
    --conditions 106X_upgrade2018_realistic_v16_L1v1 \
    --step PAT \
    --procModifiers run2_miniAOD_UL \
    --geometry DB:Extended \
    --filein file:${NAME}_5.root \
    --era Run2_2018 \
    --runUnscheduled \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_6_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_7_cfg.py \
    --eventcontent NANOAODSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier NANOAODSIM \
    --fileout file:${NAME}_NANO.root \
    --conditions 106X_upgrade2018_realistic_v16_L1v1 \
    --step NANO \
    --filein file:${NAME}_6.root \
    --era Run2_2018,run2_nanoAOD_106Xv2 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_7_cfg.py ./MC_Pipeline/Projects/${PROJECT}/${NAME}/

popd



