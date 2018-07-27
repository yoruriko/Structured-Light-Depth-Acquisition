function [ w ] = compute_depth( uv_code,cam_intrinsic,cam_extrinsic,proj_intrinsic,proj_extrinsic )

    [m,n,~]=size(uv_code);
    
    w = zeros(m,n,3);
    
    % Rotation of camera extrinsic matrix
    R1 = cam_extrinsic(1:3,1:3);
    % Translation of camera extrinsic matrix
    T1 = cam_extrinsic(1:3,4);
    
    % Rotation of projector extrinsic matrix
    R2 = proj_extrinsic(1:3,1:3);
    % Translation of projector extrisic matrix
    T2 = proj_extrinsic(1:3,4);
    
    % Inferring 3D world points of each pixel
    for i=1:m
        for j=1:n
        
            % if the uv_code of that pixel is not uncertain
            if uv_code(i,j,1)~=-1 
                
                A = zeros(4,3);
                b = zeros(4,1);
                
                % convert image coordinate to normalize screen coordinates
                p1 = cam_intrinsic\[j;i;1];
                % convert uv position we calculated into screen coordinates
                p2 = proj_intrinsic\[uv_code(i,j,2);uv_code(i,j,1);1];
                
                % Stack Linear conststrains
                A(1,:) = [R1(3,1)*p1(1)-R1(1,1), R1(3,2)*p1(1)-R1(1,2), R1(3,3)*p1(1)-R1(1,3)];
                A(2,:) = [R1(3,1)*p1(2)-R1(2,1), R1(3,2)*p1(2)-R1(2,2), R1(3,3)*p1(2)-R1(2,3)];
            
                A(3,:) = [R2(3,1)*p2(1)-R2(1,1), R2(3,2)*p2(1)-R2(1,2), R2(3,3)*p2(1)-R2(1,3)];
                A(4,:) = [R2(3,1)*p2(2)-R2(2,1), R2(3,2)*p2(2)-R2(2,2), R2(3,3)*p2(2)-R2(2,3)];
                
                b(1:2) = [T1(1)-T1(3)*p1(1), T1(2)-T1(3)*p1(2)];
                b(3:4) = [T2(1)-T2(3)*p2(1), T2(2)-T2(3)*p2(2)];
                
                % obtain the world coordinate by computing the least square
                % slution of this linear system.
                x = A\b;
                
                % reporject the 3d world into camera space by applying the
                % camera extrinsic matrix
                %w_cam = cam_extrinsic * [x;1];
                
                % store the resulting w
                w(i,j,:) = x;
                
            end
            
        end
    end


end

