# Wild-Type KSI Simulation Data

This directory contains files related to the wild-type ketosteroid isomerase.

## Files

- `19nt.frcmod`, `19nt.mol2`: Parameter files for the small molecule 19-nortestosterone.
- `5kp4leap.pdb`: Crystal structure of wild-type KSI.
- `model1.pdb` – `model8.pdb`: Near-crystal structures extracted from molecular dynamics simulations of wild-type KSI.
- `aptraj.in`: Input file for **cpptraj**, used to calculate hydrogen-bond distances.
- `min1.in`, `min2.in`, `heat.in`, `md.in`: Input files for molecular dynamics simulations.
- `tleapfb15.in`, `tleapff14sb.in`, `tleapff15ipq.in`, `tleapff19sb.in`: Files for generating topologies using **tleap**.
- `ptrajcrd.in`: Input file for **cpptraj** to image the protein and water molecules into the simulation box.
- `electricfiledall.f90`, `electricfiledall.out`: Files for performing electric field calculations. 
