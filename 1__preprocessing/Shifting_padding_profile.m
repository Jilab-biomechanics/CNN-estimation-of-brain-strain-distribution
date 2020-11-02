function [Pad_curves] = Shifting_padding_profile(profile, length_times)
    %
    % Function shifting the profile to the padded profile center based on  
    % the resultant peak location and padding profile with replicated 
    % padding method (along the temporal borders).
    %
    % Input:  profile = profile with x,y,z three anatomical directions
    %         length_times = length of the profile
    %
    % Output: Pad_curves = padded profiles
    %
    % Note that "center_loc = 101" corresponds to 100 ms (on line 26)
    % length of 201 points. Please check the following website. 
    % https://github.com/Jilab-biomechanics/CNN-brain-strains
    %
    % Author: Shaoju Wu 10/24/2019
    %% Determine the shifting location
    curRes_rotated = zeros(size(profile,1),1);
    % Compute the resultant profile
    curRes_rotated(:,1) = resultant_val(profile(:,1:3));
    shift_curves = zeros(length_times, 3);
    [Input_length,Channel] = size(profile);
    
    % Determine the peak location of the resultant profile
    [~, peak_loc] = max(abs(curRes_rotated(:,1)));
%     % wei's peak finding 
% 
%     t = time;
%     vrot = profile{i};
%     arot = diff_curve_nd([t', vrot]);
%     dt = diff(time(1:2));
% 
%     t_acc = arot;
%     res_acc = resultant_val(t_acc);
%     res_acc(:,2) = smooth(res_acc(:,2),7);
%     t_vel = [t', vrot];
%     res_vel = resultant_val(t_vel);
%     res_vel_initial(i,:) = res_vel(1,2);
%         
%     delta_v = max(t_vel(:,2:end)) - min(t_vel(:,2:end));
%     delta_v_max(i,:) = sqrt(sum(delta_v.^2));
%    
%     [~, vrotpk] = max(res_vel(:,2));
%     [PKS,LOCS]= findpeaks([res_acc(:,2); 0]);
%     [~, i_pk1] = max(PKS);
%     if (length(PKS) > i_pk1 && PKS(i_pk1+1)<max(PKS)*0.5) || vrotpk>400% use a thresh
%         i_pk2 = LOCS(i_pk1+1);
%         i_pk1 = LOCS(i_pk1);
%         tmp_acc = ones(size(res_acc));
%         tmp_acc(:,1) = res_acc(:,1);
%         tmp_acc(:,2) = tmp_acc(:,2)*max(res_acc(:,2));
%         tmp_acc(i_pk1:i_pk2,2) = res_acc(i_pk1:i_pk2, 2);
%         [~, i_trough] = min(tmp_acc(:,2));
%         i_trough2(i,:)= round(i_trough/10);
%     else
%         [~, iPeak] = max(res_vel(:,2));
%         i_trough = iPeak;
%     end
%     if length(res_vel) < i_trough+20
%         [t_max, vrotpk2] = max(res_vel(1:end,2));
%     else
%         [t_max, vrotpk2] = max(res_vel(1:i_trough+20,2));
%     end
%     arot = 2*t_max/0.01;
%   
%     ax = t_vel(vrotpk2,2:end)/norm(t_vel(vrotpk2,2:end));
%     
%     [theta, alpha ] = vec2ang(ax);
%     if theta<-90 || theta>90
%         [ theta, alpha ] = conjugate_rotational_axis( theta, alpha );
%         ind_mirror(i,:) = 1;
%     end
%     input_param(i,:) = [arot, dt*1000, theta, alpha];
%     max_res_vel(i,:) = max(res_vel(:,2));
%     max_res_acc(i,:) = max(res_acc(:,2));
%     I = vrotpk2;
    
    center_loc = 100; 
    shift_step = center_loc - peak_loc;
    % Determine whether the padded profile is out of the require time
    % length (200 ms). 
    
    if(shift_step<0)
        error('Error. \the input profile is too long')
    end
    Left_loc = Input_length+shift_step;
    
    %% shift the input profile and pad the profile with replicated padding
    for i = 1:Channel
        shift_curves((1+shift_step):(Left_loc),i) = profile(:,i);
        shift_curves(1:shift_step,i) = profile(1,i)*ones(shift_step,1);
        shift_curves(Left_loc:end,i) = profile(end,i)*ones(1+length_times-Left_loc,1);
        
    end
    Pad_curves = shift_curves;
          
end