from WMCore.Configuration import Configuration
config = Configuration()

#NAME='SMS-GlGl_mGl-2300_mN2-1300_mN1-1000_GZ_N2ctau-0p001'
NAME='XXXX'

config.section_("General")
config.General.requestName = NAME+'_AOD'
config.General.workArea = 'crabsubmit'

config.section_("JobType")
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = NAME+'_3_cfg.py'
config.JobType.allowUndistributedCMSSW = True
config.JobType.maxMemoryMB = 2800



config.section_("Data")
config.Data.outputPrimaryDataset = 'YYYY'
config.Data.userInputFiles = open('./MC_Pipeline/Projects/PPPP/XXXX/crab_digi4aod_list.txt').readlines()
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.publication = False
config.Data.outputDatasetTag = 'AOD'

config.section_("Site")
config.Site.storageSite = 'T3_US_FNALLPC'
config.Site.whitelist = ['T2_*','T3_*']

