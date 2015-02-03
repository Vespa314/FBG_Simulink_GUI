%Chirp Unit nm/cm
function H = GetMaskMatrix(Mask,lambdaB,n,delta_n,L,lambda,Chirp)
H = [ones(1,length(lambda));
    zeros(1,length(lambda));
    zeros(1,length(lambda));
    ones(1,length(lambda))];

Mask_L = length(Mask);

% if (nargin == 8 & ShowInfo)
%     disp(['单位长度内最少含有布拉格周期数：' num2str(L/Mask_L/lambdaB)]);
% end

for i = 1 : Mask_L
    F = FBGTransMatrix(lambdaB+L/Mask_L*(i-1)*Chirp*1e-7,n,delta_n*Mask(i),L/Mask_L,lambda);
    H = MatrixProd(H,F);
end
