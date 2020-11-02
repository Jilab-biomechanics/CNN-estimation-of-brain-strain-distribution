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
load('M:\Kia_Ghazi\Aim__2__Atlas_machine_learning\6__github\Kias_github\2__Strain_prediction\voxel_labels.mat')
h = figure;
h.Position = [208   173   844   722];
h.Color = 'w';
subplot(1,2,1)
mps_vis = nan(size(x));
mps_vis(~(isnan(x))) = predict_mps;
scatter3(x(:),y(:),z(:), 50, mps_vis(:), 'filled')
caxis([0 max(predict_mps)])
colormap jet
axis equal
view([40 30])
xlabel('x(m)')
ylabel('y(m)')
zlabel('z(m)')
title('Direct Simulation')

subplot(1,2,2)
pred_vis = nan(size(x));
pred_vis(~(isnan(x))) = voxel_strains;
scatter3(x(:),y(:),z(:), 50, pred_vis(:), 'filled')
caxis([0 max(predict_mps)])
axis equal
colormap jet
view([40 30])
xlabel('x(m)')
ylabel('y(m)')
zlabel('z(m)')
title('CNN Estimation')
cb = colorbar;
cb.Label.String = 'MPS';

