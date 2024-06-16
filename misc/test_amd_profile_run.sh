AMDuProfCLI collect\
 -e event=PMCx076,umask=0x00\
 -e event=PMCx0C0,umask=0x00\
 -e event=PMCx060,umask=0xE8\
 -e event=PMCx064,umask=0x08\
 -e event=PMCx0C3,umask=0x00\
 -e event=PMCx044,umask=0x02\
 -e event=PMCx044,umask=0x04\
 -e event=PMCx044,umask=0x08\
 -e event=PMCx044,umask=0x10\
 -e event=PMCx044,umask=0x40\
 -e event=PMCx044,umask=0x14\
 -e event=PMCx084,umask=0x00\
 -e event=PMCx085,umask=0x07\
 -e event=PMCx045,umask=0xFF\
 -e event=PMCx045,umask=0xF0\
 -e event=PMCx078,umask=0xFF\
 -o ./output-directory\
  python code/image_classification/code/pytorch_main.py /data/imagenet/ -b 1024 --gpus 2 -j 28 --epochs 1 --val-loop 0 --train-loop 10

AMDuProfCLI collect -e event=PMCx087 -o ./output-directory python code/image_classification/code/pytorch_main.py /data/imagenet/ -b 1024 --gpus 2 -j 10 --epochs 1 --val-loop 0 --train-loop 10
#  -e event=PMCx076,umask=0x00\ # CYCLES_NOT_IN_HALT
#  -e event=PMCx0C0,umask=0x00\ # RETIRED_INST
#  -e event=PMCx087,umask=0x02\ # STALLED_CYCLES.FRONTEND (didn't work)
#  -e event=PMCx060,umask=0xE8\ # L2_CACHE_ACCESS.FROM_L1_DC_MISS
#  -e event=PMCx064,umask=0x08\ # L2_CACHE_MISS.FROM_L1_DC_MISS 
#  -e event=PMCx0C3,umask=0x00\ # RETIRED_BR_INST_MISP
#  -e event=PMCx044,umask=0x02\ # L1_DC_REFILLS.LOCAL_CACHE
#  -e event=PMCx044,umask=0x04\ # L1_DC_REFILLS.EXTERNAL_CACHE_LOCAL 
#  -e event=PMCx044,umask=0x08\ # L1_DC_REFILLS.LOCAL_DRAM
#  -e event=PMCx044,umask=0x10\ # L1_DC_REFILLS.EXTERNAL_CACHE_REMOTE 
#  -e event=PMCx044,umask=0x40\ # L1_DC_REFILLS.REMOTE_DRAM
#  -e event=PMCx044,umask=0x14\ # L1_DC_REFILLS.EXTENAL_CACHE 
#  -e event=PMCx084,umask=0x00\ # L1_ITLB_MISSES_L2_HITS  
#  -e event=PMCx085,umask=0x07\ # L2_ITLB_MISSES 
#  -e event=PMCx045,umask=0xFF\ # L1_DTLB_MISSES 
#  -e event=PMCx045,umask=0xF0\ # L2_DTLB_MISSES 
#  -e event=PMCx078,umask=0xFF\ # ALL_TLB_FLUSHES 

