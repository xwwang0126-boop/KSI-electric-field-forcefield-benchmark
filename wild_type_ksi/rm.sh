#!/bin/bash

models=(model25 model50 model75 model100 model125 model150 model175 model200)
ffs=(fb15 ff14SB ff15ipq ff19SB RSFF2C)

# ========= 可调参数 =========
MAX_PDB_MB=10   # 超过多少 MB 认为是“过大”
# ===========================

echo "Current directory:"
pwd
echo "Deleting PDB files larger than ${MAX_PDB_MB} MB ..."
echo

for ff in "${ffs[@]}"; do
    for model in "${models[@]}"; do
        dir="$ff/$model"
        [[ -d "$dir" ]] || continue

        for pdb in "$dir"/*.pdb; do
            [[ -f "$pdb" ]] || continue

            size_mb=$(du -m "$pdb" | cut -f1)
            if (( size_mb > MAX_PDB_MB )); then
                echo "[DELETE] $pdb  (${size_mb} MB)"
                rm -f "$pdb"
            fi
        done
    done
done

echo
echo "PDB cleanup finished."

