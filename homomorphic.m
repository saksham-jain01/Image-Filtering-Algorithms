I = imread('5.jpg');
I = colorCorrect(I);
imshow(I);
figure();
for i = 1:3
    
I(:,:,i) =adapthisteq(I(:,:,i));
end
imshow(I);
figure();

clear all;
I = imread('8.jpg'); %Try with 1-8 PNG for underwater images. Try with dark 1-3 .BMP for lowlight images
K = 0.075; %Adjust this to change results
%j = 8.8;
% for x = 1:3
%     img = I(:,:,x);         %Taking each layer R,G,B one at a time
%     iMean = mean(img(:));   %Mean of the image
%     varMat = double(img) - iMean;  %Variance Matrix
%     varMat = varMat.^2;            
%     var = sum(varMat(:))/numel(varMat);  % Variance
%     std = sqrt(var);
%     if(x==1)
%        newI(:,:,x) = uint8(0.7*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
%         elseif(x==2)
%        newI(:,:,x) = uint8(0.76*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
%         elseif(x==3)
%        newI(:,:,x) = uint8(0.83*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
%     end  
% end
% 
% red=newI(:,:,1);
% newmeanred = mean(red(:));
% green = newI(:,:,2);
% newmeangreen = mean(green(:));
% blue = newI(:,:,3);
% newmeanblue = mean(blue(:));
% mean_arr = [newmeanred , newmeangreen,newmeanblue];
% 
% varNewred = double(newI) - newmeanred;
% varNewred = varNewred.^2;
% stdNewred = sqrt(sum(varNewred(:))/numel(varNewred));
% varNewgreen = double(newI) - newmeangreen;
% varNewgreen = varNewgreen.^2;
% stdNewgreen = sqrt(sum(varNewgreen(:))/numel(varNewgreen));
% varNewblue = double(newI) - newmeanblue;
% varNewblue = varNewblue.^2;
% stdNewblue = sqrt(sum(varNewblue(:))/numel(varNewblue));
% 
% % for y=1:3
% % if(y==1)
% %        newI(:,:,y) = uint8(1.48*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
% %         elseif(y==2)
% %        newI(:,:,y) = uint8(0.76*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
% %         elseif(y==3)
% %        newI(:,:,y) = uint8(0.83*(0.65*(255-255*cos(pi*double(img)/510)) + 0.35*255*(1 - exp(-abs((double(img) - (iMean/100))/(2.55*std))))));
% % end
% [r  c] = size(newI(:,:,1));
% for i = 1:r
%     for j = 1:c
%         for k = 1:3
%             if newI(i,j,k)>mean_arr(k)
%                 newI(i,j,k) = newI(i,j,k) + 0.01*mean_arr(k);
%             elseif newI(i,j,k)<mean_arr(k)
%                 newI(i,j,k) = newI(i,j,k) - 0.01*mean_arr(k);
%             end
%         end
%     end
% end
% 
% 
% 
% 
figure();
I_hsv = rgb2hsv(I);
v = I_hsv(:,:,3);
v = im2double(v);
v = log(1 + v);
M = 2*size(v,1) + 1;
N = 2*size(v,2) + 1;
sigma = 10;
[X, Y] = meshgrid(1:N,1:M);
centerX = ceil(N/2); 
centerY = ceil(M/2); 
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H1 = 1 - H; 
%imshow(H,'InitialMagnification',25)
H = fftshift(H);
H1 = fftshift(H1);
If = fft2(v, M, N);
Iout_ill = real(ifft2(H.*If));
Iout_ref = real(ifft2(H1.*If));
Iout_ill = Iout_ill(1:size(v,1),1:size(v,2));
Iout_ref = Iout_ref(1:size(v,1),1:size(v,2));
Ihmf_ill = atan((exp(Iout_ill) - 1));
figure();
imshow(Ihmf_ill);
Ihmf_ref = adapthisteq((exp(Iout_ref) - 1));
I_hsv(:,:,3) =(Ihmf_ill.*Ihmf_ref);
I_hsv(:,:,1) = adapthisteq(I_hsv(:,:,1));
I_hsv(:,:,2) = adapthisteq(I_hsv(:,:,2));
I_final = hsv2rgb(I_hsv);
figure();
imshow(I_final);
% 
% function nImage = colorCorrect(I)
% J = 0.08;
% for k = 1:3
%     im = I(:,:,k);
%     iMean = mean(im(:));
%     varMat = double(im) - iMean;
%     varMat = varMat.^2;
%     var = sum(varMat(:))/numel(varMat);
%     sCmax = iMean + (J * var);
%     sCmin = iMean - (J * var);
%     nImage(:,:,k) = uint8(((double(im) - sCmin)/(sCmax - sCmin)) * 255);
% end
% end