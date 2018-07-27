function save_ply(w,filename)

[m,n,~] = size(w);
n_vertices = num2str(size(find(w(:,:,3)),1));

% write the header file
file_id=fopen(filename,'w');
fprintf(file_id, ['ply', '\n']);
fprintf(file_id, 'format ascii 1.0\n');
fprintf(file_id, ['element vertex ', n_vertices, '\n']);
fprintf(file_id, ['property float x', '\n']);
fprintf(file_id, ['property float y', '\n']);
fprintf(file_id, ['property float z', '\n']);
fprintf(file_id, ['end_header', '\n']);

for i=1:m
    for j=1:n
        
        if(w(i,j,3)~=0)
            % write the coordinate of each point
            fprintf(file_id, '%f %f %f\n', w(i,j,1),w(i,j,2), w(i,j,3));
        end
        
    end
end
end