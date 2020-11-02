% visualizes voxel-wise strains from CNN in 3D
%
% see also: 
% github_link
%
% Author: Kianoosh Ghazi, 10/06/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Workspace
clear; clc; close all;
%% 
load('M:\Kia_Ghazi\Aim__2__Atlas_machine_learning\6__github\Kias_github\2__Strain_prediction\voxel_location.mat')
load('M:\Kia_Ghazi\Aim__2__Atlas_machine_learning\6__github\Kias_github\2__Strain_prediction\Output.mat')
h = figure;
h.Position = [208   173   844   722];
mps_vis = nan(size(x));
mps_vis(~(isnan(x))) = predict_mps;
scatter3(x(:),y(:),z(:), 50, mps_vis(:), 'filled')
axis equal
