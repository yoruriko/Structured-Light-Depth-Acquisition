function [ result ] = decode_uv(image_u,image_v,T)
    
    [m,n,d,uframes]=size(image_u);
    pattern_U = zeros(m,n,1,uframes);
    
    [~,~,~,vframes]=size(image_v);
    pattern_V = zeros(m,n,1,vframes);
    
    % convert color image into grayscale if t
    if d~=1
       for i=1:uframes
        pattern_U(:,:,i)=rgb2gray(image_u(:,:,:,i));
       end
       
       for i=1:vframes
        pattern_V(:,:,i)=rgb2gray(image_v(:,:,:,i));
       end
       
    else
        pattern_U = image_u;
        pattern_V = image_v;
    end
    
    result = zeros(m,n,2);
    result(:,:,1) = pattern2UVcode(pattern_U,T);
    result(:,:,2) = pattern2UVcode(pattern_V,T);
  
end

function [code] = pattern2UVcode(pattern,T)
    [col,row,~,n_pattern]=size(pattern);
    n_set = floor(n_pattern/2);
    
    code = zeros(col,row);
    
    binary_code = zeros(col,row,n_set);
    dist = zeros(col,row);
    
    code_index = 1;
    for idx = 1:2:n_pattern
        % get the projection pattern and its inverse
        project = pattern(:,:,idx);
        inv_project = pattern(:,:,idx+1);
        
        % assign each element to 1 if its project image have higher
        % intensity than its inver projection, otherwise assign 0.
        binary_code(:,:,code_index) = project > inv_project;
        
        % record the total unsign change in distance
        dist = dist + abs(project-inv_project);
        
        code_index=code_index+1;
    end
    
    for i=1:col
        for j=1:row
            
            % if the distance difference is smaller than threshold then
            % assign it to -1, label as uncertain.
            if dist(i,j)<T
                code(i,j)= -1;
            else
                % convert the binary sequence into unsigned integer
                % coordinate.
                code(i,j)=bi2de(reshape(binary_code(i,j,:),[1,n_set]));
            end
            
        end
    end
        
end

