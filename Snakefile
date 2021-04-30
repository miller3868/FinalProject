#After setting working directory and loading weather file, run Snakefile. 

rule combine_columns:
  input: 
    script: "/Users/ACM/FinalProject/Scripts/CombineColumns.R"
    data: "/Users/ACM/FinalProject/Data/MasterWeatherStation_EmpireChestnut.csv"
  output:
    data: "/Users/ACM/FinalProject/Data/CombColumns.csv"
  shell: "Rscript {input.script} \
            --data {input.data} \
            --out {output.data}"

rule aggregate_rows:
  input: 
    script: "/Users/ACM/FinalProject/Scripts/AggRows.R"
    data: "/Users/ACM/FinalProject/Data/CombColumns.csv"
  output:
    data: "/Users/ACM/FinalProject/Data/MergeCSV"
  shell: "Rscript {input.script} \
            --data {input.data} \
            --out {output.data}"

rule merge_data:
  input: 
    script: "/Users/ACM/FinalProject/Scripts/MergeData.R"
    data: "/Users/ACM/FinalProject/Data/MergeCSV"
  output:
    data: "/Users/ACM/FinalProject/Results/WeatherSummary.csv"
  shell: "Rscript {input.script} \
            --data {input.data} \
            --out {output.data}"


