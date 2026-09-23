from WMCore.Configuration import Configuration
config = Configuration()

NAME='XXXX'
config.section_("General")
config.General.requestName = NAME+'_digi'
config.General.workArea = 'crabsubmit'

config.section_("JobType")
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = NAME+'_3_cfg.py'
config.JobType.allowUndistributedCMSSW = True
config.JobType.maxMemoryMB = 2800


config.section_("Data")
config.Data.outputPrimaryDataset = 'YYYY'
config.Data.userInputFiles = open('./MC_Pipeline/Projects/PPPP/XXXX/crab_sim4digi_list.txt').readlines()
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.publication = False
config.Data.outputDatasetTag = 'digi'

config.section_("Site")
config.Site.storageSite = 'T3_US_FNALLPC'
config.Site.whitelist = ['T2_*','T3_*']

