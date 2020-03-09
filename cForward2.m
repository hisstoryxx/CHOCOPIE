%% Forward Projection : rotation-based V1
% Parameter Original_Image, number_of_theta, radial sampling
% n = number_of_theta, r = radial_sampling

function sinogram = cForward2(Original_Image, n, r)

%angles = [0:180];
%angles = angles(1:180/number_of_theta:180);                       % 인덱스 오류

angles = linspace(0,180-(180/n),n);                  % boundary condition

[x,y] = size(Original_Image);                                      % get image size

sinogram = zeros(n, r);                              % set sinogram

rotated_Image = zeros(x,y,n);                        % set initial size of rotated_Image 
sampled_Image = zeros(r,r,n);

for i = 1:length(angles)                                           % 직관적으로
                                                                   % shift 
                                                                   
    rotated_Image(:,:,i) = imrotate(Original_Image, angles(i),'bilinear','crop');
    sampled_Image(r/2-x/2:r/2+x/2-1, r/2-y/2:r/2+y/2-1,i) = rotated_Image(:,:,i);
    sinogram(i,:) = sum(sampled_Image(:,:,i),1); 
    
end
end 