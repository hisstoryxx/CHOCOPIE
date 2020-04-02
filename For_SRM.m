function For_SRM = For_SRM(n_xy, n_bin, n_view)  
% System Response Matrix ( SRM )
% Forward projection with matrix multiplication
% Input parameter 
% n_xy = img_size, n_bin, n_view
% Output (Matrix A)
% size(A) = [n_bin * n_view, n_xy * n_xy]
% ver 0.3
% n_view πÊ«‚

for ii = 1: n_xy * n_xy
    
 img_buffer_Init = zeros(n_xy * n_xy, 1);
 img_buffer_Init(ii,1) = 1;
 
 img_buffer = reshape(img_buffer_Init, n_xy, n_xy);
 
 sinogram = For_proj(img_buffer, n_view, n_bin);
 
 sinogram = reshape(sinogram, n_view * n_bin, 1);
 
 For_SRM(:,ii) = sinogram;
    
    
end

end
