NEVENT=10
NAME=XXXX
PROJECT=PPPP


#assume frags have been placed and scram b'd
#this will be run from directory of script, automatically do all 3

pushd ../../
cmsDriver.py Configuration/GenProduction/python/${NAME}-fragment.py \
    --python_filename ${NAME}_1_cfg.py \
    --eventcontent RAWSIM,LHE \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM,LHE \
    --fileout file:${NAME}_1.root \
    --conditions 124X_mcRun3_2022_realistic_v12 \
    --beamspot Realistic25ns13p6TeVEarly2022Collision \
    --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(123456)"\\nprocess.source.numberEventsInLuminosityBlock="cms.untracked.uint32(250)" \
    --step LHE,GEN,SIM \
    --geometry DB:Extended \
    --era Run3 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_1_cfg.py ./MCPipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_2_cfg.py \
    --eventcontent PREMIXRAW \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM-RAW \
    --fileout file:${NAME}_2.root \
    --pileup_input "dbs:/Neutrino_E-10_gun/Run3Summer21PrePremix-Summer22_124X_mcRun3_2022_realistic_v11-v2/PREMIX" \
    --conditions 124X_mcRun3_2022_realistic_v12 \
    --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2022v12 \
    --procModifiers premix_stage2,siPixelQualityRawToDigi \
    --geometry DB:Extended \
    --filein file:${NAME}_1.root \
    --datamix PreMix \
    --era Run3 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_2_cfg.py ./MCPipeline/Projects/${PROJECT}/${NAME}/

cmsDriver.py \
    --python_filename ${NAME}_3_cfg.py \
    --eventcontent AODSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier AODSIM \
    --fileout file:${NAME}_AOD.root \
    --conditions 124X_mcRun3_2022_realistic_v12 \
    --step RAW2DIGI,L1Reco,RECO,RECOSIM \
    --procModifiers siPixelQualityRawToDigi \
    --geometry DB:Extended \
    --filein file:${NAME}_2.root \
    --era Run3 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_3_cfg.py ./MCPipeline/Projects/${PROJECT}/${NAME}/


#also have mini and nano loaded up
cmsDriver.py  \
    --python_filename ${NAME}_4.py \
    --eventcontent MINIAODSIM \
    --fast \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier MINIAODSIM \
    --fileout file:${NAME}_MiniAODv4.root \
    --conditions 130X_mcRun3_2022_realistic_v5 \
    --step PAT \
    --geometry DB:Extended \
    --filein file:${NAME}_AOD.root \
    --era Run3,run3_miniAOD_12X \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_4_cfg.py ./MCPipeline/Projects/${PROJECT}/${NAME}/


cmsDriver.py \
    --python_filename ${NAME}_5.py \
    --eventcontent NANOAODSIM \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier NANOAODSIM \
    --fileout file:${NAME}_NanoAODv12.root \
    --conditions 130X_mcRun3_2022_realistic_v5 \
    --step NANO \
    --scenario pp \
    --filein file:${NAME}_MiniAODv4.root \
    --era Run3 \
    --no_exec \
    --mc \
    -n ${NEVENT}

mv ${NAME}_5_cfg.py ./MCPipeline/Projects/${PROJECT}/${NAME}/
popd

