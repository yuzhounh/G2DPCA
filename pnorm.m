function y=pnorm(x,p)
% Lp-norm
% x, a vector
% p, a scalar

%     Generalized two dimensional principal component analysis by Lp-norm for image analysis
%     Copyright (C) 2015 Jing Wang
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

if p==0
    y=sum(x~=0);
elseif p==Inf
    y=max(abs(x));
else
    y=sum(abs(x).^p)^(1/p);
end