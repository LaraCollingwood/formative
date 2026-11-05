rule all:
    input:
        "logs/1.txt",
        "logs/2.txt"

rule check_bmx:
    input:
        "data/original/BMX_D.csv",
        "code/01_checking_bmx_data.sh"
    output:
        "logs/1.txt"
    shell:
        """
        mkdir -p logs
        bash code/01_checking_bmx_data.sh > logs/1.txt
        """

rule check_accel:
    input:
        "data/original/accel/accel-31128.txt",
        "code/02_checking_accel_data.sh"
    output:
        "logs/2.txt"
    shell:
        """
        mkdir -p logs
        bash code/02_checking_accel_data.sh > logs/2.txt
        """


rule clean_logs:
    "Remove the logs directory"
    shell: 
        """
        if [ -d logs ]; then
        rm -r logs
        else
        echo directory logs does not exist
        fi
        """