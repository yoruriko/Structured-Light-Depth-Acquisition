function result = filter_code(uv_code)
[m,n,~] = size(uv_code);
result = zeros(m,n,2);

for i = 1:m
    result(i,:,2) = medfilt1(uv_code(i,:,2),7);
end

for i = 1:n
    result(:,i,1) = medfilt1(uv_code(:,i,1),7);
end

end