# !/bin/bash

# Run the AMD experiment with varying dataloaders

# !/bin/bash

uprof_custom_collect_result_dir="/data/rbachkaniwala3/amd_logs/pytorch_amd_logs/amd_custom_collect_vary_dataloader"
custom_log_result_dir_="/data/rbachkaniwala3/pytorch_custom_log_and_uprof_one_epoch_imagenet_dataset"
uprof_csv_dir="/data/rbachkaniwala3/amd_logs/pytorch_amd_logs/amd_csv_vary_dataloader"

python_path="/home/rbachkaniwala3/work/anaconda3/envs/torch2/bin/python"
program_path="/home/rbachkaniwala3/work/quick_ml_pipeline/code/image_classification/code/pytorch_main.py"
dataset_path="/data/imagenet"

batch_size="1024"
num_gpu="2"
num_dataloaders=("6" "4" "2" "1")
cutoff=10000

num_epochs=1

# check if result directory exists
if [ ! -d ${uprof_custom_collect_result_dir} ]; then
    mkdir -p ${uprof_custom_collect_result_dir}
fi

if [ ! -d ${uprof_csv_dir} ]; then
    mkdir -p ${uprof_csv_dir}
fi

# set below env variable to pin data loader threads to cores
# export TORCH_DATALOADER_PIN_CORE=1

for num_dataloader in "${num_dataloaders[@]}"
do
        custom_log_result_dir="${custom_log_result_dir_}/b${batch_size}_gpu${num_gpu}_dataloader${num_dataloader}"

        # check if result directory exists
        if [ ! -d ${custom_log_result_dir} ]; then
            mkdir -p ${custom_log_result_dir}
        fi
        amduprof_result_dir=${uprof_custom_collect_result_dir}/b${batch_size}_gpu${num_gpu}_dataloader${num_dataloader}
        vmtouch -e ${dataset_path}
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
        -o ${amduprof_result_dir}\
        taskset -c 12-127 ${python_path} ${program_path} ${dataset_path} -b ${batch_size} --gpus ${num_gpu} -j ${num_dataloader} --epochs ${num_epochs} --log-train-file ${custom_log_result_dir}/custom_log --val-loop 0;
        
        for outputdir in $(ls $amduprof_result_dir) 
        do
            csv_file="${uprof_csv_dir}/b${batch_size}_gpu${num_gpu}_dataloader${num_dataloader}.csv"
            AMDuProfCLI report --input-dir $amduprof_result_dir/$outputdir --report-output $csv_file --cutoff ${cutoff} -f csv
        done
done
chmod 777 -R $csv_dir
echo "Done running all programs"