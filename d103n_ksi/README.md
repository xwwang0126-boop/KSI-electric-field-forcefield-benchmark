# D103N KSI Simulation Data

This directory contains files related to the D103N mutant of ketosteroid isomerase.

## Files

- `d103nmodel01.pdb` – `d103nmodel10.pdb`: Near-crystal structures extracted from molecular dynamics simulations of the D103N mutant.
- `aptraj.in`: Input file for **cpptraj**, used to calculate hydrogen-bond distances.
- `min1.in`, `min2.in`, `heat.in`, `md.in`: Input files for molecular dynamics simulations.
- `tleapfb15.in`, `tleapff14sb.in`, `tleapff15ipq.in`, `tleapff19sb.in`: Files for generating topologies using **tleap**.
- `ptrajcrd.in`: Input file for **cpptraj** to image the protein and water molecules into the simulation box.
- `electricfiledall.f90`, `electricfiledall.out`: Files for performing electric field calculations.

