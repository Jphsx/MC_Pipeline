from WMCore.Configuration import Configuration
config = Configuration()

NAME='XXXX'


config.section_("General")
config.General.requestName = NAME+'_NANO'
config.General.workArea = 'crabsubmit'

config.section_("JobType")
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = NAME+'_5.py'
config.JobType.allowUndistributedCMSSW = True



config.section_("Data")
config.Data.outputPrimaryDataset = 'YYYY'


config.Data.userInputFiles = open('./MC_Pipeline/Projects/PPPP/XXXX/crab_mini4nano_list.txt').readlines()
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 1
config.Data.publication = False
config.Data.outputDatasetTag = NAME+'_NANO'

config.section_("Site")
config.Site.whitelist = ['T3_US_FNALLPC']
config.Site.whitelist = ['T2_*','T3_*']

