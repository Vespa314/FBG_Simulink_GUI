function H = MatrixProd(F,G)
H = F;
H(1,:) = F(1,:).*G(1,:)+F(2,:).*G(3,:);
H(2,:) = F(1,:).*G(2,:)+F(2,:).*G(4,:);
H(3,:) = F(3,:).*G(1,:)+F(4,:).*G(3,:);
H(4,:) = F(3,:).*G(2,:)+F(4,:).*G(4,:);