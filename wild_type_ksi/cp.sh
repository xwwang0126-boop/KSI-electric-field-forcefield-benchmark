#!/bin/bash

models=(model25 model50 model75 model100 model125 model150 model175 model200)
ffs=(fb15 ff14SB ff15ipq ff19SB RSFF2C)

# 当前目录应为 WT-KSI
pwd

for model in "${models[@]}"; do
    echo "Processing $model ..."

    for ff in "${ffs[@]}"; do
        mkdir -p "$ff/$model"

        # 源目录
        if [[ "$ff" == "RSFF2C" ]]; then
            src="../../$model/runRSFF"
        else
            src="../../$model/$ff"
        fi

        # 拷贝
        cp "$src"/19nt.*              "$ff/$model/" 2>/dev/null
        cp "$src"/*.pdb               "$ff/$model/" 2>/dev/null
        cp "$src"/electricfiledall.*  "$ff/$model/" 2>/dev/null
        cp "$src"/*in                 "$ff/$model/" 2>/dev/null
        cp "$src"/exe_r               "$ff/$model/" 2>/dev/null
        cp "$src"/p.*                 "$ff/$model/" 2>/dev/null
    done
done

echo "Copy finished."

