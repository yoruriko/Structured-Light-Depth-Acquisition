function [ HEst ] = calcBestHomography( pts1Cart,pts2Cart )
    n = size(pts1Cart,2);
    hom_row = ones(1,n);
    
    pts1Hom = [pts1Cart;hom_row];
    pts2Hom = [pts2Cart;hom_row];
    
    A = zeros(2*n,9);
    for row = 1:2:n*2
        A(row,:) = [zeros(1,3),-pts1Hom(:,ceil(row/2),:)',(pts1Hom(:,ceil(row/2),:)').*pts2Hom(2,ceil(row/2),1)];
        A(row+1,:) = [pts1Hom(:,ceil(row/2),:)',zeros(1,3),(pts1Hom(:,ceil(row/2),:)').*-pts2Hom(1,ceil(row/2),1)];
    end
    h = solveAXEqualsZero(A);

    HEst = reshape(h,[3,3])';
    
end

function x = solveAXEqualsZero(A)
    [~,~,V] = svd(A);
    x = V(:,end);
end