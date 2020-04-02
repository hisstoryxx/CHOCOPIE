%% Backward projection: rotation-based
     % parameter sinogram, a
     % reconstruction image size = a x a
     % ver 0.2
     
     % size(sinogram) = [n_view, n_bin]
     % 0 < n_xy =< n_bin                                    !!! 
     
    function true_laminogram = Back_proj(sinogram,img_size)
    
   [n_y,n_x] = size(sinogram);         
    
    n_view = n_y; 
    n_bin = n_x;  
    
    view_limit = 180;
    view_step = view_limit / n_view;
 
    Backprojected_Image = zeros(n_bin,n_bin,n_view);
   
    laminogram = zeros(n_bin,n_bin);
    
    for ii = 1:n_view 
         
        for jj = 1:n_bin
            Backprojected_Image(jj,:,ii) = sinogram(ii,:);
        end
        
        
        laminogram(:,:) = laminogram(:,:) + ...
            imrotate(Backprojected_Image(:,:,ii), view_step * (ii-1), 'bilinear', 'crop');
         
    end
     laminogram = pi/n_y *laminogram;
     
     true_laminogram = laminogram(n_bin/2 - img_size/2+1: n_bin/2 + img_size/2 , n_bin/2 - img_size/2+1: n_bin/2 + img_size/2);
     
    end