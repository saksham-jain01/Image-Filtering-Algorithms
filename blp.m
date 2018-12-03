function a1 = blp(im,thresh,n)
 %%inputs
 %%im is the fourier transform of the image
 %%thresh is the cutoff circle radius
 
 %%a1 is the output image
  [r,c] = size(im);
  d0 = thresh;
  
  d1 = zeros(r,c);
  h1 = zeros(r,c);
   for i = 1:r
       for j = 1:c
           d1(i,j) = sqrt ((i-(r/2))^2+(j-(c/2))^2);
       end
   end
    
   for  i = 1:r
       for j = 1:c
           h1(i,j) = 1/(1+(d1(i,j)/d0)^(2*n));
       end
   end
   for i = 1:r
       for j = 1:c
            a1(i,j) = (h1(i,j))*im(i,j);
       end
   end
