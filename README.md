# SiN Waveguide Mode Simulation with COMSOL LiveLink

This repository contains MATLAB code for simulating waveguide modes and calculating the effective index of a Silicon Nitride (SiN) waveguide using COMSOL LiveLink. The code performs mode analysis, separates TE and TM modes, and sweeps the waveguide height and width to save results in a CSV file.

## Features

- Calculates modes and effective index of SiN waveguides.
- Separates TE and TM modes based on TE fraction.
- Sweeps waveguide height and width for parameterized analysis.
- Outputs results in CSV format.

## Prerequisites

1. **MATLAB**: Ensure MATLAB is installed with the COMSOL LiveLink for MATLAB.
2. **COMSOL Multiphysics**: A COMSOL simulation file defining the waveguide structure is required.
3. **COMSOL LiveLink**: The LiveLink package must be properly configured with MATLAB.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rameshpkd/Phtotonic-WaveguideMode_COMSOL_Livelink.git

2. Open the project directory in MATLAB.

Usage
1. Set Up COMSOL File (use the attached SiN_waveguide.mph file as a reference):
• Create the SiN waveguide structure in COMSOL and save it as waveguide_model.mph.
• Place the .mph file in the same directory as the MATLAB code.
2. Run the Simulation:
• Open waveguide_mode_simulation.m in MATLAB.
• Configure the parameters (waveguide dimensions, TE fraction threshold, sweep range) as needed.
• Run the script:

waveguide_mode_simulation_comsol.m


4. Outputs:
• The effective index and TE/TM modes for each parameter combination are saved in results.csv in the project directory.

File Structure

├── SiN_waveguide.mph                      # COMSOL model file defining the waveguide structure

├── waveguide_mode_simulation_comsol.m     # Main MATLAB script for mode simulation

├── nte0, ntm0, kte0, ktm0.csv             # Output files with simulation results

├── README.md                  # Project documentation


Notes
• TE Fraction : The TE/TM separation is determined by comaring the TE_fraction. TE_frac >= 0.5 is TE mode, TE_fract < 0.5 is TM mode (modify accordingly).
• Sweep Range: Modify the height and width ranges in the script for different parameter sweeps.

Contributions

Contributions are welcome! Feel free to fork this repository and submit a pull request.

Contact

For questions or support, please contact rameshpkd@gmail.com.

Happy simulating!
