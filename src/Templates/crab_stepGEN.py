from WMCore.Configuration import Configuration
config = Configuration()

NAME='XXXX'


config.section_("General")
config.General.requestName = NAME+"_GEN"
config.General.workArea = 'crabsubmit'

config.section_("JobType")
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = NAME+'_1_cfg.py'
config.JobType.allowUndistributedCMSSW = True
config.JobType.maxMemoryMB = 2300

config.section_("Data")
config.Data.outputPrimaryDataset = 'YYYY'
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = UUUU
NJOBS = NNNN  # This is not a configuration parameter, but an auxiliary variable that we use in the next line.
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.publication = False
config.Data.outputDatasetTag ='GEN'

config.section_("Site")
config.Site.storageSite = 'T3_US_FNALLPC'
