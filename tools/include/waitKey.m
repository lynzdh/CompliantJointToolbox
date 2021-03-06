% WAITKEY Function that blocks the console and asks user to press any key.
%
%   waitKey()
%
% This function is helpful during exmaples. It prints two empty lines and
% asks the user to press a key to proceed with program execution.
%
% Author::
%  Joern Malzahn
%  Wesley Roozing
%
% See also cjtExamples.

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
function waitKey()

disp(' ')
disp('Press any key to continue.')
pause();
disp(' ')

end