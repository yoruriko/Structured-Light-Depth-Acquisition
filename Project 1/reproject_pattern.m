function [ I_reproj ] = reproject_pattern( I_proj,I_cam,offset_x,offset_y,XData,YData,size_pattern)
    
    [~,~,d,n_frame] = size(I_proj);
    
    pts_cam = [offset_x,offset_x+size_pattern,offset_x+size_pattern,offset_x;
               offset_y,offset_y,offset_y+size_pattern,offset_y+size_pattern];
           
    I_reproj = zeros(YData,XData,d,n_frame);
    Ref_In = imref2d(size(I_cam(:,:,:,1)));
    Ref_Out = imref2d(size(I_reproj(:,:,:,1)));
           
    for i = 1:n_frame
        
        current_proj = I_proj(:,:,:,i);
        current_cam = I_cam(:,:,:,i);
        
        disp('Please select the corners of the image for reporjection');
        my_figure = figure;
        
        imshow(current_proj);
        
        [imX,imY] = getline(my_figure);
        close all;
        
        pts_proj = [imX';imY'];
        
        HEst = calcBestHomography(pts_proj,pts_cam);
        T = projective2d(HEst');
        
        I_reproj(:,:,:,i)=imwarp(current_cam,Ref_In,T,'OutputView',Ref_Out);
       
    end
    
end

