function GA()
clc;
close all;
clear all;
lambdaB = 1553*1e-9;
n = 1.45;
delta_n = 4e-4;
L = 8e-3;
lamdaRange = [1550 1560];
lambda=(lamdaRange(1):0.001:lamdaRange(2))* 1e-9;

MaskLength = 100;
MaskBit = 7;
pop_size = 200;%总群大小、
chromo_size = MaskBit*MaskLength;%个体长度

M = randint(pop_size,chromo_size);
FitnessValue = GetALLFitness(M,MaskBit,lambdaB,n,delta_n,L,lambda);

for generation = 1 : 100
    



end


function FitnessValue = GetALLFitness(M,MaskBit,lambdaB,n,delta_n,L,lambda)
pop_size = size(M,1);
FitnessValue = zeros(1,pop_size);
for i = 1 : pop_size
     FitnessValue(i) = GetFitness(M(i,:),MaskBit,lambdaB,n,delta_n,L,lambda);
end    


%计算适应度
function SR = GetFitness(chromo,MaskBit,lambdaB,n,delta_n,L,lambda)
Mask = MaskDecode(chromo,MaskBit);
F = GetMaskMatrix(Mask,lambdaB,n,delta_n,L,lambda);
Res_Spectral = GetR(F);
SR = SMSR(Res_Spectral);


function Mask = MaskDecode(chromo,MaskBit)
bincode = reshape(chromo,MaskBit,length(chromo)/MaskBit)';
Mask = bin2dec(num2str(bincode))';