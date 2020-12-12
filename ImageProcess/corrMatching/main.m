% --------------------------------------------------------
% Demo: Template Matching using Correlation Coefficients
% By Yue Wu (Rex)
% Department of Electrical and Computer Engineering
% Tufts University
% Medford, MA
% 08/30/2012
% --------------------------------------------------------

clear all
close all

%% Prepare the image for analysis
F = imread('master.jpg'); % master file
T = imread('na.jpg'); % read in template image

figure, imshow(F);
G = im2bw(F, 0.4); % tresholding 
figure, imshow(G);
%% display frame and template
figure, subplot(121),imshow(F),title('Gray Coins Image');
subplot(122),imshow(T),title('Coin Template');
%% correlation matching
[corrScore, boundingBox] = corrMatching(F,T);
%% show results
figure,imagesc(abs(corrScore)),axis image, axis off, colorbar, 
title('Corr Measurement Space')

bY = [boundingBox(1),boundingBox(1)+boundingBox(3),boundingBox(1)+boundingBox(3),boundingBox(1),boundingBox(1)];
bX = [boundingBox(2),boundingBox(2),boundingBox(2)+boundingBox(4),boundingBox(2)+boundingBox(4),boundingBox(2)];
figure,imshow(F),line(bX,bY),title('Detected Area');