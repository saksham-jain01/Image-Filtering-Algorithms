%%frequency domain filtering
clear all;
close all;
clc;
A = imread('CAR.jpg');

%%RGB TO GRAY CONVERSION
r1 = A(:,:,1);
g1 = A(:,:,2);
b1 = A(:,:,3);

B = 0.21*r1 + 0.72*g1 + 0.07*b1;

[r,c] = size(B);

l = zeros(r,c);
 r1 = 2*r;
 c1 = 2*c;
d = zeros(r1,c1);
e = zeros(r1,c1);
g = zeros(r1,c1); 
%%padding
for i = 1:r
    for j = 1:c
    
 d(i,j) = B(i,j);
    end
end

%%origin shift
for i = 1:r1
    for j = 1:c1
e(i,j) = ((-1)^(i+j))*d(i,j);
    end
end

%%fourier transform 
g = fft2(e);


%%filter function
n = 1; %%order of butterworth filter
thresh = 100; %%threshold of the circle
%%high pass filters
h = bhp(g,thresh,n);
%h = ghp(g,thresh);

%%low pass filters
%h = blp(g,thresh,n);
h = glp(g,thresh);

%%inverse fourier calculation 
k = ifft2(h);
%%padding removal
for i = 1:r
    for j = 1:c
        l(i,j) = k(i,j);
    end
end
l = real(l);
l = uint8(l);
imshow(l); title('frequency filter');