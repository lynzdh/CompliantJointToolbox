%COULOMB_ASYM Calculate asymetric Coulomb friction torques
%
% [tau] = jointObj.coulomb_asym(x)
%
% jointObj is the instance of the joint class object for which this
% function has been called.
%
%
% Inputs::
%   x:   state vector depending on the model type as
%     x = [q_m; q_g; q_b; q_m_dot; q_g_dot, q_b_dot'];  continuous_full
%     x = [q_g, q_b, q_g_dot, q_b_dot]'                 continuous_rigid_gearbox
%     x = [q_m, q_g, q_m_dot, q_g_dot]'                 continuous_output_fixed
%     x = [q_g, q_g_dot]'                               continuous_output_fixed_rigid_gearbox
%
% Outputs::
%   tau: friction torque
%
% Notes::
%
%
% Examples::
%
% Author::
%  Joern Malzahn
%  Wesley Roozing
%
% See also full_dyn, coulomb, viscous_asym.

% Copyright (C) 2016, by Joern Malzahn, Wesley Roozing
%
% This file is part of the Compliant Joint Toolbox (CJT).
%
% CJT is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% CJT is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
% License for more details.
%
% You should have received a copy of the GNU General Public License
% along with CJT. If not, see <http://www.gnu.org/licenses/>.
%
% For more information on the toolbox and contact to the authors visit
% <https://github.com/geez0x1/CompliantJointToolbox>

function [ tau ] = coulomb_asym(obj, x)
    
    % Preallocate coefficient vectors
    c       = zeros(size(x));
    c_neg	= zeros(size(x));
    cc      = zeros(size(x));
    
    % Build coefficient vector
    if (strcmp(obj.modelName, 'continuous_full'))
        c       = [0, 0, 0, obj.d_cm,	obj.d_cg,	obj.d_cb]';
        c_neg	= [0, 0, 0, obj.d_cm_n, obj.d_cg_n, obj.d_cb_n]';
        
    elseif (strcmp(obj.modelName, 'continuous_rigid_gearbox'))
        c       = [0, 0, obj.d_cm + obj.d_cg,       obj.d_cb]';
        c_neg   = [0, 0, obj.d_cm_n + obj.d_cg_n,	obj.d_cb_n]';
        
    elseif (strcmp(obj.modelName, 'continuous_output_fixed'))
        c       = [0, 0, obj.d_cm,      obj.d_cg]';
        c_neg   = [0, 0, obj.d_cm_n,    obj.d_cg_n]';
        
    elseif (strcmp(obj.modelName, 'continuous_output_fixed_rigid_gearbox'))
        c       = [0, obj.d_cm + obj.d_cg]';
        c_neg   = [0, obj.d_cm_n + obj.d_cg_n]';
        
    elseif (strcmp(obj.modelName, 'continuous_rigid'))
        c       = obj.d_cm + obj.d_cg + obj.d_cb;
        c_neg   = obj.d_cm_n + obj.d_cg_n + obj.d_cb_n;
        
    end
    
    % Build coefficients depending on signs of velocities
    cc(x>0) = c(x>0);
    cc(x<0) = c_neg(x<0);

    % If we have values over time per variable, pad the coefficients
    if (size(x,2) > 1)
        cc = padarray(cc, [1 size(x,2)-1], 'replicate', 'post');
    end
    
    % Calculate Coulomb friction torques
    tau = -cc .* atan(1000*x) / (pi/2);

end
