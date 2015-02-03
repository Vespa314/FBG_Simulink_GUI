function [F] = FBGTransMatrix(lambdaB,n,delta_n,L,lambda)

omega=pi*delta_n./lambda;%交流耦合系数
delta_k=2*pi*n*(1./lambda-1/lambdaB)+2*pi./lambda*delta_n;%直流耦合系数  精确
s = sqrt(omega.^2-delta_k.^2);

s11 = cosh(s*L)+1i*delta_k./s.*sinh(s*L);
s12 = -1i*omega./s.*sinh(s*L);
s21 = 1i*omega./s.*sinh(s*L);
s22 = cosh(s*L)-1i*delta_k./s.*sinh(s*L);


F = [s11; s12;s21; s22];