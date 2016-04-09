function W=GPCA(x,s,p,nPV)
% GPCA
% each column is an obeservation and each row is a variable

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

% check
if s<1 || p<=0
    error('Please check s or p.');
end

x=x'; % so that the following lines could be consistent with the G2DPCA

x0=x;
d=size(x,2);

[~,~,W0]=svd(x,0); % SVD/PCA as the initialization
W=zeros(d,nPV);
for iPV=1:nPV
    w=W0(:,iPV);
    w=w/pnorm(w,p);
    
    rsd=1;
    while rsd>1e-4
        fp=pnorm(x*w,s);
        
        v=s*x'*((abs(x*w).^(s-1)).*sign(x*w));
        if 0<p && p<1
            w=diag(abs(w.*w).^(1-p/2))*v;
            w=w/pnorm(w,p);
        elseif p==1
            [~,j]=max(abs(v)); % index of the largest absolute value in v
            w=zeros(d,1);
            w(j)=sign(v(j));
        elseif p<Inf
            q=p/(p-1);
            w=(abs(v).^(q-1)).*sign(v);
            w=w/pnorm(w,p);
        elseif p==Inf
            w=sign(v);
        end
        
        f=pnorm(x*w,s);
        rsd=abs(f-fp)/fp;
    end
    W(:,iPV)=w;
    
    x=x0*(eye(d)-W*W'); % deflating
end