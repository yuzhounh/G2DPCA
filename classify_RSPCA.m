function classify_RSPCA(database,iLam)
% Calculate the classification accuracy of RSPCA. 

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

fprintf('classify_RSPCA_par(%s,%d)\n\n',database,iLam);

tic;
% database='ORL';

if strcmp(database,'ORL')
    nSub=40; % 40 subjects
    nPic=10; % each subject has 10 images
    nTest=5; % pick 5 images from each subject for test and rest images for training
elseif strcmp(database,'Feret')
    nSub=200;
    nPic=7;
    nTest=4;
end

load(sprintf('data/%s.mat',database));
[height,width,n]=size(x);
x=reshape(x,height*width,n);

sLam=10.^[-3:0.1:3];
nLam=length(sLam);

sPV=[1:30];
nPV=length(sPV);

nRep=10; % repeat the experiment for 10 times

accuracy=zeros(nPV,nRep);
for iRep=1:nRep
    load(sprintf('data/%s_r%d.mat',database,iRep));
    ix_train=1-ix_test;
    
    ix_train=find(ix_train);
    ix_test=find(ix_test);
    
    num_train=length(ix_train);
    num_test=length(ix_test);
    
    x_train=x(:,ix_train);
    x_test=x(:,ix_test);
    
    label_train=label(ix_train);
    label_test=label(ix_test);
    
    % subtract the mean
    x_mean=mean(x_train,2);
    x_train=x_train-repmat(x_mean,[1,num_train]);
    x_test=x_test-repmat(x_mean,[1,num_test]);
    
    lam=sLam(iLam);
        
    W=RSPCA(x_train,lam,nPV); % RSPCA
    
    % reserve the result after projection
    x_train_reserve=W'*x_train;
    x_test_reserve=W'*x_test;
    
    for iPV=1:nPV
        x_train_proj=x_train_reserve(1:iPV,:);
        x_test_proj=x_test_reserve(1:iPV,:);
        
        % nearest neighbor classifier
        dxx=pdist2(x_train_proj',x_test_proj');
        [~,ix]=min(dxx);
        label_predict=label_train(ix);
        
        accuracy(iPV,iRep)=mean(label_predict==label_test);
    end
    perct(toc,iRep,nRep);
end
time=toc/60;
accuracy=mean(accuracy,2);
save(sprintf('result/classify_RSPCA_%s_iLam%d.mat',database,iLam),'accuracy','time');