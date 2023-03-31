% Copyright (C) 2017-2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later



% This is the demo for motion separation using robust subspace tracking.
% The data set is extracted from the Perception Test Image Sequences by:
% L. Li, W. Huang, I. Y. H. Gu, and Q. Tian. Statistical modeling of complex
% backgrounds for foreground object detection. TIP, 13(11):1459?1472, 2004.
%
% Written by Hassan Mansour
% Copyright MERL 2017

clear; %close all;

%% Input video sequence
datadir = 'data/';
datalist =  dir(datadir);

N = length(datalist)-2;

imfile = [datadir, 'image_1.jpg'];
im = imread(imfile);
dim = size(im);
p = prod(dim);


%% Choose a rank
r = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROSETA
%% initialize
clear Params

L_prev = rand(p,r); % no initialization (equals to a random initialization if all frames have sparse outliers)

Params.const = 10; % parameter for the adaptive stepsize update
Params.val = 10; % decides how fast the stepsize (\mu) can change
Params.temp = 10; % initial hyper parameter
Params.HIGH_TEMP = 500;
Params.mu = max(Params.const./(1+Params.temp), 1); % initial \mu
Params.mufloor = 0.03;
mu_adap = zeros(N,1); % save the computed adaptive \mu


% select sparse regularizer
lambda = 1/Params.HIGH_TEMP;
% estimate U and R
inner=[]; temp=[];
L = [];

troseta = tic;

B = zeros(p,N);
A = zeros(r,N);


fprintf('%10s %10s %10s\n', 'Frame #', 'mu', 'time');
for k = 1:N-1


    imfile = [datadir, 'image_', num2str(k), '.jpg'];
    b = imread(imfile);
    b = double(b(:))/255;
    meanb = mean(b(:));
    b = b - meanb;


    Mask = ones(p,1);
    tic
    if k<=r
        L(:,k) = b;
        R = L\b;
        S = b - L*R;
        L_prev = L;

        BG_roseta{k} = 128*ones(dim(1), dim(2),3);
        BG_roseta{k}(:,:,1) = reshape(255*(L*R+meanb),dim);
        FG_roseta{k} = 128*ones(dim(1), dim(2),3);
        FG_roseta{k}(:,:,1) = reshape(255*S, dim);
    else

        [L, R, S, ParamsNew] = ROSETA(Mask, b, L_prev, r, Params,lambda);
        mu_adap(k) = ParamsNew.mu;
        Params = ParamsNew;
        L_prev = L;
        A(:,k) = R';

        BG_roseta{k} = 128*ones(dim(1), dim(2),3);
        BG_roseta{k}(:,:,1) = reshape(255*(L*R'+meanb),dim);


        FG_roseta{k} = 128*ones(dim(1), dim(2),3);
        FG_roseta{k}(:,:,1) = 128+reshape(255*S, dim);

    end
    fprintf('%10d %10.4e %10.4e\n', k, mu_adap(k), toc);
    %%
    figure(2);
    subplot(1,2,1); imagesc(BG_roseta{k}(:,:,1), [0 255]); colormap(gray);title(num2str(k))
    subplot(1,2,2); imagesc(FG_roseta{k}(:,:,1), [0 255]); colormap(gray);
    drawnow;


    B(:,k) = b;


end
toc(troseta)


%% plot the computed adaptive \mu
figure(3); semilogy(mu_adap,'linewidth',2);
title('Value of Adaptive \mu','fontsize',16);
xlabel('Time index','fontsize',16);
ylabel('\mu','fontsize',16);
