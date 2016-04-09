function W=RSPCA(x,lam,nPV)
% RSPCA

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


s=1; % set s as 1 since the script is adopted from GPCA

x=x'; % so that the following lines could be consistent with the 2DPCAL1-S

x0=x;
d=size(x,2);

[~,~,W0]=svd(x,0); % SVD/PCA as the initialization
W=zeros(d,nPV);
for iPV=1:nPV
    w=W0(:,iPV);
    rsd=1;
    while rsd>1e-4
        fp=pnorm(x*w,s);
        
        v=s*x'*((abs(x*w).^(s-1)).*sign(x*w));
        
        % update rule
        w=v.*abs(w)./(lam+abs(w));
        w=w/norm(w);
        
        f=pnorm(x*w,s);
        rsd=abs(f-fp)/fp;
    end
    W(:,iPV)=w;
    
    x=x0*(eye(d)-W*W'); % deflating
end