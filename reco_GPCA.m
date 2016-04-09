function reco_GPCA(database,iS,iP)
% Calculate the reconstruction error of GPCA. 

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

fprintf('reco_GPCA_par(%s,%d,%d)\n\n',database,iS,iP);

tic;
load(sprintf('data/%s_noise.mat',database));

[height,width,nSub]=size(x_noise);
x_noise=reshape(x_noise,[height*width,nSub]);
x_mean=mean(x_noise,2);
x_centered=x_noise-repmat(x_mean,1,nSub);

sS=[1:0.1:3];
nS=length(sS);

sP=[0.9:0.1:3];
nP=length(sP);

nPV=30; % the first 30 projection vectors are considered

s=sS(iS);
p=sP(iP);

W=GPCA(x_centered,s,p,nPV);

err=zeros(nPV,1);
for iPV=1:nPV
    w=W(:,1:iPV);
    
    x_reco=zeros(size(x_noise));
    for iSub=1:nSub
        x_reco(:,iSub)=w*w'*x_centered(:,iSub)+x_mean;
    end
    temp=x_noise-x_reco;
    
    rsd=0;
    for iSub=nSub/5+1:nSub
        rsd=rsd+norm(temp(:,ix_noise(iSub)));
    end
    err(iPV)=rsd/(nSub*4/5);
    
    perct(toc,iPV,nPV);
end
time=toc/60;

save(sprintf('result/reco_GPCA_%s_iS%d_iP%d.mat',database,iS,iP),'err','time');