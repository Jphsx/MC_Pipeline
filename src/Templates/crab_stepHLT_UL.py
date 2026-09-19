from WMCore.Configuration import Configuration
config = Configuration()

NAME='XXXX'


config.section_("General")
config.General.requestName = NAME+"_HLT"
config.General.workArea = 'crabsubmit'

config.section_("JobType")
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = NAME+'_4_cfg.py'
config.JobType.allowUndistributedCMSSW = True
config.JobType.maxMemoryMB = 2300

config.section_("Data")
config.Data.outputPrimaryDataset = 'YYYY'
config.Data.userInputFiles = open('./MCPipeline/Projects/PPPP/XXXX/crab_digi4hlt_list.txt').readlines()
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.publication = False
config.Data.outputDatasetTag = NAME+'_HLT'

config.section_("Site")
config.Site.storageSite = 'T3_US_FNALLPC'
config.Site.whitelist = ['T2_*','T3_*']

