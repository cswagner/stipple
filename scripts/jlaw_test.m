%----------------------------------------------------------------------
%   jlaw_test.m
%   
%   reads in a test image, converts it to grayscale, stipples the image,
%   saves the stipple image in a new .jpg, closes the image figure
%
%   Chris Wagner, 2.13.14
%----------------------------------------------------------------------
img = rgb2gray(im2double(imread('../images/jlaw.jpg')));
[pixelated, pat] = stipple(img, 12, 12);
print(gcf, '-djpeg', '../output/jlaw-stipple.jpg');
close all;