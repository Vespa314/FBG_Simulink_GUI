function [lambda R]=GetFBG2(lambdaB,n,delta_n,L)
syms x
omega=pi*delta_n/x;%交流耦合系数


delta_k=2*pi*n*(1/x-1/lambdaB)+2*pi/x*delta_n;%直流耦合系数  精确

s = sqrt(omega^2-delta_k^2);



% p=-K*sinh(s*L)/[D*sinh(s*L)+i*s*cosh(s*L)];%反射系数
% r=(abs(p))^2;%反射率
% r = omega^2*sinh(s*L)^2 / (delta_k^2*sinh(s*L)^2 + s^2*cosh(s*L)^2);
r = abs(((j*omega/s*sinh(s*L))/(cosh(s*L)+j*delta_k/s*sinh(s*L)))^2);

lamdaRange = [1550 1560];
% lamdaRange = [(lambdaB+delta_n*lambdaB/n)*1e9*(1-2*delta_n/n) (lambdaB+delta_n*lambdaB/n)*1e9*(1+2*delta_n/n)];
lambda=(lamdaRange(1):0.0001:lamdaRange(2))* 1e-9;
R=subs(r,x,lambda);
