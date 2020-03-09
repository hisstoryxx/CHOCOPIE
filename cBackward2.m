%% Backward projection: rotation-based
     % parameter sinogram, a
     % reconstruction image size = a x a
     
    function laminogram = cBackward2(sinogram,a)
    
    [y,x] = size(sinogram);                                    % y = number_of-theta  x = radial sampling
   
    angles = linspace(0,180-(180/y),y);                        % boundary condition
    
    sinogram_buffer = zeros(y,a);
    sinogram_buffer(:,a/2-x/2+1:a/2+x/2) = sinogram(:,:);
    
    Backprojected_Image = zeros(a,a,length(angles));
    R2 = zeros(a,a,length(angles));
    laminogram = zeros(a,a);
    
    for i = 1:length(angles) 
         
        for j = 1:x
         Backprojected_Image(j,:,i) = sinogram_buffer(i,:);
        end
         
         R2(:,:,i) =imrotate(Backprojected_Image(:,:,i), -angles(i),'bilinear','crop');   % rotate Clockwise
         laminogram(:,:) = laminogram(:,:) +  R2(:,:,i);
         
    end
     laminogram = pi/y *laminogram;
     
    end
    
 
    % 0306 Feedback
    % input parameter로 픽셀 갯수(number of pixel) 추가 
    % 이미지 픽셀 디멘전이 결정될 수 있도록