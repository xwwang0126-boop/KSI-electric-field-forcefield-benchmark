# KSI-electric-field-forcefield-benchmark
This repository contains input files, scripts, and analysis codes used in the molecular dynamics simulations and electric field calculations of wild-type and D103N mutant ketosteroid isomerase (KSI).

## Contents
- AMBER input files for MD simulations under different force fields
- cpptraj scripts for trajectory analysis
- Fortran code for electric field calculations
- Representative structural models used in this study

## Notes
Trajectory files are not included due to their large size. All input files necessary to reproduce the simulations are provided. 

### RSFF2C topology preparation

For molecular dynamics simulations using the RSFF2C force field, the topology file was generated through a two-step procedure. First, a standard AMBER topology file (e.g., ‘p.sd.top’) was constructed using the ff14SB force field. This topology was then converted into an RSFF2C-compatible topology by executing the Python script ‘a_mod_top_RSFF2C_strict.py’:
python a_mod_top_RSFF2C_strict.py p
which generates the modified topology file ‘p.run.top’ used in subsequent RSFF2C-based MD simulations.
Some auxiliary files required for RSFF2C simulations are not included in this repository due to licensing and distribution considerations associated with the RSFF2C force field. These files are available from the authors upon reasonable request (Wu, wuyd@pkusz.edu.cn; Jiang, jiangfan@pku.edu.cn). Alternatively, requests may be directed to xwang@zjut.edu.cn, who can assist in obtaining permission from the RSFF2C developers when appropriate.
