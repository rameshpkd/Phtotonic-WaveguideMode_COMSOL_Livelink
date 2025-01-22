%% Author Ramesh Kudalippalliyalil (rameshpkd@gmail.com)


%%Open COMSOL Multiphysics with MATLAB
import com.comsol.model.*
import com.comsol.model.util.*
addpath(genpath('C:\<your directory of mph file>\SiN_waveguide.mph)
% Load the COMSOL model
model = mphload('SiN_waveguide.mph');
format long;
width_values = [0.5, 0.1, 16];
height_values = [0.2, 0.05, 0.6];

% Get the parameter sweep values (e.g., wgw values)
param_name1 = 'wgw'; % Replace with your parameter name
dataset_name = 'dset1'; % Replace with your dataset name
param_name2='wgh';

% Retrieve all parameter values (110 in total)
% all_param_values = mphglobal(model, param_name1, 'dataset', dataset_name);
%
% % Retrieve all parameter values (110 total values: 11 sweeps × 10 modes)
% % all_param_values = mphglobal(model, param_name1, 'dataset', dataset_name);
%
% % Identify unique parameter sweep values
% [sweep_values, ~, idx_map] = unique(all_param_values); % Unique values and mapping
% % num_sweeps = length(sweep_values); % Total unique sweeps
% num_modes = 10; % Number of modes per sweep

num_sweeps = length(width_values);
k_sweeps = length(height_values);
num_modes = 10;


% Get the spatial coordinates (x, y, z) from the solution mesh
% sol = model.sol('sol1');
% mesh_info = mphxmeshinfo(model, 'soltag','sol1');
% coords = mesh_info.nodes; % Get the actual coordinate matrix [3, num_nodes]
% crd = coords.coords;
% x_crd = unique(crd(1,:));
% y_crd = unique(crd(2,:));
% num_x = length(x_crd);
% num_y = length(y_crd);



% Initialize arrays to store fundamental TE and TM effective indices
fundamental_te_indices = NaN(num_sweeps, k_sweeps); % Fundamental TE indices for each sweep
fundamental_tm_indices = NaN(num_sweeps, k_sweeps); % Fundamental TM indices for each sweep


% Loop through each unique parameter value (sweep)
for sweep_w = 1:length(width_values)
    wgw = width_values(sweep_w);
    model.param.set(param_name1, wgw);
    for sweep_h = 1:length(height_values)
        % Set the global parameter
        wgh = height_values(sweep_h);
        model.param.set(param_name2, wgh);
        
        
%         
        % Run the study
        model.study('std1').run; % Replace 'std1' with the name of your study
		%% to know the study name use the model.study() in the command window
        
        te_modes = [];
        tm_modes = [];
        
        % Loop through the modes for the current parameter
        for mode_idx = 1:num_modes
            solnum = mode_idx;
            neff = mphglobal(model, 'emw.neff', 'solnum', solnum, 'dataset', dataset_name);
            num= mphint2(model, 'abs(emw.Ex)^2', 'surface', 'solnum', solnum);
            denom = mphint2(model, 'abs(emw.Ex)^2+abs(emw.Ey)^2', 'surface', 'solnum', solnum);
            te_fraction(mode_idx) = num/denom;
            
            % Classify mode as TE or TM based on dominant field component
            if te_fraction(mode_idx) > 0.5
                % TE mode
                te_modes = [te_modes; neff];
            else
                % TM mode
                tm_modes = [tm_modes; neff];
            end
        end
        
        % Identify fundamental TE and TM modes (largest Real part)
        if ~isempty(te_modes)
            [~, te_fund_idx] = max(real(te_modes)); % Index of fundamental TE mode
            fundamental_te_indices(sweep_w, sweep_h) = te_modes(te_fund_idx);
        end
        
        if ~isempty(tm_modes)
            [~, tm_fund_idx] = max(real(tm_modes)); % Index of fundamental TM mode
            fundamental_tm_indices(sweep_w, sweep_h) = tm_modes(tm_fund_idx);
        end

    end
end

%%%%% SAVE file (optional)
% mphsave(model);

% Display results
format long
disp('Unique Sweep Parameter Values:');
% disp(sweep_values);
disp('Fundamental TE Effective Indices:');
disp(fundamental_te_indices);
disp('Fundamental TM Effective Indices:');
disp(fundamental_tm_indices);

%% SAVE REAL AND IMAG index AS CSV FILES

csvwrite('fund_te_real.csv', real(fundamental_te_indices));
csvwrite('fund_te_imag.csv', imag(fundamental_te_indices));

csvwrite('fund_tm_real.csv', real(fundamental_tm_indices));
csvwrite('fund_tm_imag.csv', imag(fundamental_tm_indices));
nte0 = real(fundamental_te_indices);
kte0 = imag(fundamental_te_indices);
ntm0 = real(fundamental_tm_indices);
ktm0 = imag(fundamental_tm_indices);


