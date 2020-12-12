clc; clear; close all;
 
Img = imread('ga.png');
grayImage = double(rgb2gray(Img));
 
subplot(2, 2, 1);
imshow(Img, []);
title('Original Image');
 
subplot(2, 2, 2);
imshow(grayImage, []);
title('Grayscale Image');
 
numberOfClasses = 2;
indexes = kmeans(grayImage(:), numberOfClasses);
classImage = reshape(indexes, size(grayImage));
 
%h = subplot(2, 2, 3);
figure, imshow(classImage, []);
%title('Classified Image');
%colormap(h,parula);
 
class = zeros(size(grayImage));
area = zeros(numberOfClasses,1);
 
for n = 1:numberOfClasses
    class(:,:,n) = classImage==n;
    area(n) = sum(sum(class(:,:,n)));
end
 
[~,min_area] = min(area);
 
object = classImage==min_area;
bw = medfilt2(object,[5 5]);
bw = bwareaopen(bw,5000);
s = regionprops(bw,'BoundingBox');
bbox = cat(1, s.BoundingBox);
RGB = insertShape(Img, 'FilledRectangle', bbox, 'Color', 'yellow', 'Opacity', 0.3);
RGB = insertObjectAnnotation(RGB,'rectangle',bbox,'Object','TextBoxOpacity',0.9,'FontSize',18);
subplot(2, 2, 4);
imshow(RGB,[]);
title('Detected Object');

