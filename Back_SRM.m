function Back_SRM = Back_SRM(n_xy, n_bin, n_view)
% System Response Matrix ( SRM^T )
% Backward projcetion with matrix multiplication
% Input parameter
% n_xy = img_size, n_bin, n_view
% Output ( Matrix A)
% size(A) = [n_xy * n_xy, n_bin * n_view]
% ver 0.1

for ii =  1: n_bin * n_view
    
    sinogram_buffer_Init = zeros(n_view * n_bin, 1);
    sinogram_buffer_Init(ii,1) = 1;
    
    sinogram_buffer = reshape(sinogram_buffer_Init, n_view, n_bin);
    
    img = Back_proj(sinogram_buffer, n_xy);
    
    img = reshape(img, n_xy * n_xy, 1);
    
    Back_SRM(:,ii) = img;
    
end
end
    
    