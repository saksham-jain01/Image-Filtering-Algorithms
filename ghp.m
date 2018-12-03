function a1 = ghp(im,thresh);
%%inputs im- fourier transformed image
%thresh - threshold value for the circle
[r,c] = size(im);
d = zeros(r,c);
e = zeros(r,c);
d0 = thresh;
%%computing the distance 
for i = 1:r
    for j = 1:c
        d(i,j) = sqrt((i-r/2)^2 + (j-c/2)^2);
    end
end

for i = 1:r
    for j = 1:c
 H(i,j) =1- exp ( -( (d(i,j)^2)/(2*(d0^2)) ) );;
    end
end
 
for i = 1:r
    for j = 1:c
        a1(i,j) = im(i,j)*H(i,j);
    end
end

        


