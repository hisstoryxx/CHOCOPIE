%% Forward Projection : rotation-based 
% Parameter Original_Image, number_of_theta, number of radial sampling
% n_view = number_of_theta, n_bin = radial_sampling
% ver 0.1

function sinogram = For_proj(img_original, n_view, n_bin)

view_limit = 180;
view_step = view_limit / n_view;

[n_y,n_x] = size(img_original);                      

img_resized = zeros(2*n_y, 2*n_x);

img_resized((n_y / 2 + 1):(n_y * 3 / 2), (n_x / 2 + 1):(n_x * 3 / 2)) = img_original(:,:);

sinogram_wide = zeros(n_view, 2 * n_x);       


for ii = 1:n_view                                                                                           
    
    sinogram_wide(ii,:) = sum(imrotate(img_resized, - view_step * (ii - 1), 'bilinear', 'crop'), 1); 
                                                                                                     % clockwise
     

sinogram = zeros(n_view, n_bin);

sinogram(:,:) = sinogram_wide(:, (n_x - (n_bin / 2 ) + 1):(n_x + (n_bin / 2)));

end