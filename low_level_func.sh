# !/bin/bash

program_path_prefix="/home/rbachkaniwala3/work/rajveerb_AMDProfileControl-python/low_level_func"
python_path="/home/rbachkaniwala3/work/anaconda3/envs/amduprof/bin/python"
programs=("Collation.py")
# programs=("Loader.py" "Normalize.py" "RandomHorizontalFlip.py" "RandomResizedCrop.py" "ToTensor.py" "Collation.py")
amduprof_record="AMDuProfCLI collect --config tbp --start-paused"
amduprof_report="AMDuProfCLI report"
csv_dir="/home/rbachkaniwala3/work/rajveerb_AMDProfileControl-python/low_level_func/logs"

# check if all the above directories exist
if [ ! -d "$program_path_prefix" ]; then
    echo "Program path prefix does not exist"
    exit 1
fi

if [ ! -d "$csv_dir" ]; then
    echo "CSV directory does not exist"
    exit 1
fi

for program_ in "${programs[@]}"
do
    program=$program_path_prefix/$program_
    if [ ! -f "$program" ]; then
        echo "$program does not exist"
        exit 1
    fi
done


amduprof_result_dir="/home/rbachkaniwala3/low_level_func"

# Running multiple times and taking "AND" operation of the reported function
total_runs=2

for run in $(seq 1 $total_runs)
do
    for program_ in "${programs[@]}"
    do
        program=$program_path_prefix/$program_
        # remove .py from program_
        result_dir=$csv_dir/${program_::-3}
        # check if result_dir exists
        if [ ! -d "$result_dir" ]; then
            mkdir $result_dir
        fi
        csv_file=$result_dir/$run.csv
        echo "Running $program for run $run"
        $amduprof_record --output-dir $amduprof_result_dir $python_path $program
        for outputdir in $(ls $amduprof_result_dir) 
        do
            $amduprof_report --input-dir $amduprof_result_dir/$outputdir --report-output $csv_file --cutoff 100 -f csv
            rm -rf $amduprof_result_dir/$outputdir
        done
    done
done
chmod 777 -R $csv_dir
echo "Done running all programs"

# vtune -collect hotspots -start-paused -result-dir ~/collation_tester_v2 -- /proj/prismgt-PG0/anaconda3/envs/torch2/bin/python rbachkaniwala3/code/collation_tester.py
# chmod 777 -R /proj/prismgt-PG0/rbachkaniwala3/code/low_level_func/
# vtune -report hotspots -result-dir /root/collation_tester_v2/ -format csv -csv-delimiter comma -report-output ./low_level_func_v2.csv