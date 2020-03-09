%% Forward Projection : rotation-based V1
% Parameter Original_Image, number_of_theta, radial sampling
% n = number_of_theta, r = radial_sampling

function sinogram = cForward3(Original_Image, n, r)

%angles = [0:180];
%angles = angles(1:180/number_of_theta:180);                       % ÀÎµ¦½º ¿À·ù

angles = linspace(0,180-(180/n),n);                  % boundary condition

[y,x] = size(Original_Image);                                      % get image size

sinogram = zeros(n, r);                              % set sinogram

rotated_Image = zeros(r,r,n);                        % set initial size of rotated_Image 
sampled_Image = zeros(r,r);

sampled_Image(r/2-y/2+1:r/2+y/2, r/2-x/2+1:r/2+x/2) = Original_Image(:,:);    % shift 

for i = 1:length(angles)                                                                                           
    rotated_Image(:,:,i) = imrotate(sampled_Image, angles(i),'bilinear','crop');
    
    sinogram(i,:) = sum(rotated_Image(:,:,i),1); 
    
end
end 