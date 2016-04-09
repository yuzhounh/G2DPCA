function W=G2DPCA(x,s,p,nPV)
% G2DPCA

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

if s<1 || p<=0
    error('Please check s or p.');
end

x0=x;
[~,d,n]=size(x);

% initialization by the results of 2DPCA
cov=zeros(d);
for i=1:n
    cov=cov+x(:,:,i)'*x(:,:,i);
end
[V,D]=eig(cov);
[~,indx]=sort(diag(D),'descend');
V=V(:,indx);
W0=V;

% calculate multiple projection vectors
W=zeros(d,nPV);
for iPV=1:nPV
    w=W0(:,iPV);
    w=w/pnorm(w,p);
    
    % the value of objective function
    f=0;
    for i=1:n
        f=f+pnorm(x(:,:,i)*w,s)^s;
    end
    
    rsd=1;
    while rsd>1e-4
        fp=f;
        
        % a key vector in G2DPCA problem
        v=zeros(d,1);
        for i=1:n
            z=x(:,:,i);
            v=v+z'*(abs(z*w).^(s-1).*sign(z*w));
        end
        
        % update rule for different p values
        if 0<p && p<1
            w=diag((w.*w).^(1-p/2))*v;
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
        
        % the value of objective function
        f=0;
        for i=1:n
            f=f+pnorm(x(:,:,i)*w,s)^s;
        end
        rsd=abs(f-fp)/fp;
    end
    W(:,iPV)=w;
    
    % deflation
    for i=1:n
        x(:,:,i)=x0(:,:,i)*(eye(d)-W*W');
    end
end