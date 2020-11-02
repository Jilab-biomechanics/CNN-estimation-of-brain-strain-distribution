% Demo of data preprocessing for rotational velocity and acceleration 
% (Rot. Vel.) profile using conjugate axis transformation, peak shifting 
% and replicated padding   
%  
% Example input profile: 101*4, where 101 is the temporal length of the 
% profile(from 0 to 100 ms, 1 sample per ms). First culumn corresponds to 
% the time labels of the profile. The next 3 culumns are the time-varying 
% rotational velocity components along the three (X,Y,Z) anatomical 
% directions.
% 
% pad_profile (Output): N*7*201, where N is the number of input profiles, 
% the first culumn corresponds to the time labels of the profile. The 6
% remaining culumns are the time-varying velocity and acceleration 
% components along the three (X,Y,Z)anatomical directions, 201 is the 
% temporal length for CNN training/testing. 
%
% Notice: The Input profile temporal resolution must be 1 ms and the 
% temporal length should not longer than 100 ms (101 points).
%
% see also: 
% github_link
%
% Author: Kianoosh Ghazi, 10/06/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear workspace
clc; close all; clear;

%% 1) Loading the input rotational velocity profile
load(['profile']);
%% 2) Differentiating in each direction to find acceleration
for i=1:3
    acc(:,i) = [0;diff(profile(:,i))/0.001];
end
acc = acc.*0.001;
profile = [profile,acc];
%% Visualize input profile
figure 

subplot(1,2,1)
hold on;
plot(profile(:,1),'r', 'linewidth', 3);
plot(profile(:,2),'g', 'linewidth', 3);
plot(profile(:,3),'b', 'linewidth', 3); 
res_profile = resultant_val(profile(:,1:3));
plot(res_profile,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 101])
xlabel('Time (ms)');
ylabel('Rot. Vel. (rad/s)');
title('Input profile')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;

subplot(1,2,2)
hold on;
plot(profile(:,4),'r', 'linewidth', 3);
plot(profile(:,5),'g', 'linewidth', 3);
plot(profile(:,6),'b', 'linewidth', 3); 
res_profile_acc = resultant_val(profile(:,4:end));
plot(res_profile_acc,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 101])
xlabel('Time (ms)');
title('Input profile Acc./100')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;
%% 2) Conjugate axis transformation 
conjugate_profile_example = conjugate_vrot_arot_transform(profile);

%% Visualize the profile with conjugate axis
figure
subplot(1,2,1)
hold on;
plot(conjugate_profile_example(:,1),'r', 'linewidth', 3);
plot(conjugate_profile_example(:,2),'g', 'linewidth', 3);
plot(conjugate_profile_example(:,3),'b', 'linewidth', 3); 
res_profile = resultant_val(conjugate_profile_example(:,1:3));
plot(res_profile,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 100])
xlabel('Time (ms)');
ylabel('Rot. Vel. (rad/s)');
title('Profile with conjugate axis')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;

subplot(1,2,2)
hold on;
plot(conjugate_profile_example(:,4),'r', 'linewidth', 3);
plot(conjugate_profile_example(:,5),'g', 'linewidth', 3);
plot(conjugate_profile_example(:,6),'b', 'linewidth', 3); 
res_profile_acc = resultant_val(conjugate_profile_example(:,4:end));
plot(res_profile_acc,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 100])
xlabel('Time (ms)');
title('Input profile Acc./100 with conjugate axis')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;

%% 3) Profile Shifting and padding 
Padded_length = 201;
Pad_curves = Shifting_padding_profile(conjugate_profile_example, Padded_length);

%% Visualize the padded profile
figure
subplot(1,2,1)
hold on;
plot(Pad_curves(:,1),'r', 'linewidth', 3);
plot(Pad_curves(:,2),'g', 'linewidth', 3);
plot(Pad_curves(:,3),'b', 'linewidth', 3); 
res_profile = resultant_val(Pad_curves(:,1:3));
plot(res_profile,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 200])
xlabel('Time (ms)');
ylabel('Rot. Vel. (rad/s)');
title('Padded profile')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;

subplot(1,2,2)
hold on;
plot(Pad_curves(:,4),'r', 'linewidth', 3);
plot(Pad_curves(:,5),'g', 'linewidth', 3);
plot(Pad_curves(:,6),'b', 'linewidth', 3); 
res_profile_acc = resultant_val(Pad_curves(:,4:end));
plot(res_profile_acc,'k', 'linewidth', 3); 
legend('X', 'Y', 'Z', 'Res');
xlim([0 200])
xlabel('Time (ms)');
title('Padded profile Acc/100')
h = gca;
h.FontName = 'arial';
h.FontSize = 15;
h.LineWidth = 1;
hold off;
%% 4) Reshape the profile (N*6*201) for CNN training
N = 1;
pad_profile = Pad_curves;
pad_profile = reshape(pad_profile, [N, 201, 6]);
pad_profile = permute(pad_profile,[1 3 2]);
%% put in 2D image shape
figure; 
imagesc(squeeze(pad_profile(1,:,:)))
xlabel('Time (ms)');
ylabel('Channels');
h = gca;
yticklabels({'VX_{rot}','VY_{rot}','VZ_{rot}','AX_{rot}/100','AX_{rot}/100','AX_{rot}/100'})
title('Padded profile')
colormap jet
%%
save('Input.mat','pad_profile')

%% Note:
% The variable "pad_profile" is now ready to be used as a testing case 
% in the deep learning framework.

