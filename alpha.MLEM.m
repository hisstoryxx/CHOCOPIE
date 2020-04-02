%% MLEM ver 0.5 

% p : pixel_number
% d : detector_number

% n_p = n_xy X n_xy
% n_d = n_view X n_bin
% size(x) = ( n_p X 1 )
% size(y) = ( n_d X 1 )
% size(A) = (n_p X n_d)
% size(colum_n_d) = ( n_d X 1)
% size(X_n(1)) = ( n_p X 1
% 

% A = For_SRM, A' = Back_SRM

%  X_n = ( x_n ./ ( Back_SRM * colum_n_d) ) .* ( Back_SRM * ( sinogram ./ (For_SRM * x_n ) ) )  
% n_xy, n_view, n_bin, sinogram, iterative  SHOULD BE declared FIRST !! 

clc; 
clear all;
close all;

iterative = 5;
n_xy = 32;
n_view = 64;
n_bin = 64;

n_p = n_xy * n_xy;
n_d = n_view * n_bin;

Original_img = phantom( n_xy );
sinogram = For_proj( Original_img, n_view, n_bin ); 
sinogram_column = reshape( sinogram, n_d, 1 ); 


column_n_d = ones( n_d , 1);
X_n_column = ones( n_p, 1); 

A = For_SRM( n_xy, n_bin, n_view);      %  size (n_d X n_p)
A_T = A';      

 for ii = 1 : iterative 
    
% X_n_column( :, ii+1 ) = ( X_n_column( :, ii ) ./ ( A_T * column_n_d) ) ...
%            .* ( A_T * ( sinogram_column ./ ( A * X_n_column( : ,ii ) ) ) );
        
        y_est = A * X_n_column( : ,ii );
        y_AX = (sinogram_column ./ y_est); 
       
        y_AX(isnan(y_AX)) = 0 ; 
        y_AX(isinf(y_AX)) = 0 ; 
        
        x_A_T = X_n_column( :, ii ) ./ ( A_T * column_n_d);
        
        x_A_T(isnan(x_A_T)) = 0;
        x_A_T(isinf(x_A_T)) = 0;

X_n_column( :, ii+1 ) = ( x_A_T ) ...
            .* ( A_T * y_AX );
        

 X_column = X_n_column(:,ii + 1);
 
 X_j = reshape(X_column, n_xy, n_xy);
 
 figure;
 imshow(X_j, [ ]); 
 title ([num2str(ii) 'th iterative']);          
 end

