%%spatial domain filtering
 I = imread('CAR.jpg');
 I = rgb2gray(I);
 imshow(I);
 
 [r,c] = size(I);
 I = double(I);

  Padded_image = padarray(I,[1 1]);
%  for i = 1:r
%      for j = 1:c
%          Padded_image(i+1,j+1) = I(i,j);
%      end
%  end
%   figure();
%   imshow(Padded_image);
%  filter_kernel = [1 1 1; 1 1 1; 1 1 1]; %here we have used an averaging filter
%  [m,n] = size(filter_kernel);
%  for i = 1:r+1-m
%      for j = 1:c+n-1
%          Temp =Padded_image(i:i+m-1,j:j+n-1).*filter_kernel;
%     output(i,j) = sum(Temp(:)); 
%      end
%  end%Initialize
 
 imshow(output_padded_image);
 figure();
Output=zeros(size(I));
%Pad the vector with zeros
sz = 1;
I = padarray(I,[sz sz]);
Kernel = (1/9)*[-1 -1 -1; 1 1 1; 0 0 0];
[M,N] =size(Kernel);
%Convolution
for i = 1:size(I,1)-M
    for j =1:size(I,2)-N
        Temp = I(i:i+M-1,j:j+N-1).*Kernel;
        Output(i,j)=sum(Temp(:));
    end
end
%Image without Noise after Gaussian blur
Output = uint8(Output);
figure,imshow(Output);

