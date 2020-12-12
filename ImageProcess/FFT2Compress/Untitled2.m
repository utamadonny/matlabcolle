clear all, close all, clc
A = imread('D:\DONNY\Documents\MATLAB\Pengolahan Citra\FFT2\Syifa.jpg');
B = rgb2gray(A);
figure
imagesc(256-A)
set(gcf,'Position',[100 100 600 800])
%% FFT Compression
Bt=fft2(B);    % B is grayscale image from above
Blog = log(abs(fftshift(Bt))+1); % put FFT on log-scale
imshow(256-mat2gray(Blog),[]);
set(gcf,'Position',[100 100 600 800])
%% Zero out all small coefficients and inverse transform
Btsort = sort(abs(Bt(:)));  % Sort by magnitude
counter = 1;
for keep=[.99 .05 .01 .002]
    subplot(2,2,counter)
    thresh = Btsort(floor((1-keep)*length(Btsort)));
    ind = abs(Bt)>thresh;      % Find small indices
    Atlow = Bt.*ind;           % Threshold small indices
    Alow=uint8(ifft2(Atlow));  % Compressed image
    imshow(Alow)      % Plot Reconstruction
    title(['', num2str(keep*100), '%'], 'FontSize',36)
    counter=counter+1;
end
set(gcf,'Position',[100 100 600 800])

%% Surface Print
surf(Alow(10:10:end,10:10:end))