function add_noise(database)
% add noise on face images

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

% database='ORL'; % ORL, Feret
load(sprintf('../../data/%s.mat',database));
x_org=x;
[height,width,nSub]=size(x);
ix_noise=randperm(nSub);
p=nSub*20/100; % add noise to 20% of all faces locating at a random position
m=randi([20,height],p,1); % noise height >= 20
n=randi([20,width],p,1); % noise width >= 20
for i=1:p
    noise=255*randi([0,1],[m(i),n(i)]);
    posh=randi([1,height-m(i)+1]); % height, positon of noise in y axis
    posw=randi([1,width-n(i)+1]); % width, position of noise in x axis
    % ix_noise(i) is the index of a face which is merged with noise
    x(posh:posh+m(i)-1, posw:posw+n(i)-1, ix_noise(i))=noise;
end
x_noise=x;
save(sprintf('%s_noise',database),'x_noise','ix_noise');

% display
figure;
montage(reshape(x_org,height,width,1,nSub),'DisplayRange',[]);
figure;
montage(reshape(x,height,width,1,nSub),'DisplayRange',[]);