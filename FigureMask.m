function FigureMask()
clc;
close all;
clear all;
%%
%参数
lamdaRange = [1550 1565];
lambda=(lamdaRange(1):0.001:lamdaRange(2))* 1e-9;

lambdaB=1553*1e-9;
n=1.45;
delta_n=12e-4;
L=3e-3;
Chirp=10;


%%
%切趾函数

% % 高斯
a = 20;
z = -0.5:0.01:0.5;
Mask = exp(-a*z.^2);

% % 升余弦
% t = 0:0.05:pi;
% Mask = (cos(t)+1)/2;

%%汉明窗
% t = 0:0.05:pi;
% a = 0.9;
% Mask = (a*cos(t)+1)/(1+a);


%%柯西
% a = 0.6;
% z = -0.5:0.01:0.5;
% Mask = (1-(2*z).^2)./(1-(2*a*z).^2);

%双曲正切:
% a = 0.4;
% z = -0.5:0.01:0.5;
% Mask = 1/tanh(a)*tanh(2*a*(0.5-z.*sign(z)));


Mask = Mask/max(Mask);
%%
%计算
F = GetMaskMatrix(Mask,lambdaB,n,delta_n,L,lambda,Chirp);

logR = 10*log(GetR(F));
R = GetR(F);
SR = SMSR(logR);

%%
%%作图
fig = figure;
set(fig,'outerposition',get(0,'screensize'),'color','w');
set(fig,'menubar','none');

subplot(20,1,1:7);
z = linspace(0,L,length(Mask));
plot(z*1e3,Mask,'k','linewidth',2);
set(gca,'xcolor','b','ycolor','b','xgrid','on')
set(get(gca,'xlabel'),'string','Length (mm)','FontSize',15) 
set(get(gca,'ylabel'),'string','强度','FontSize',24) 
title('切趾函数','FontSize',15);
text(0,0.5,['单位长度周期数：' num2str(L/length(Mask)/lambdaB)],'FontSize',15,'color','r');


subplot(20,1,9:20);
[AX H1 H2]=plotyy(lambda*1e6,logR,lambda*1e6,R);
set(AX(1),'xcolor','b','ycolor','b','xlim',[lambda(1),lambda(end)]*1e6,...
   'xgrid','on','ygrid','on');
set(AX(2),'xlim',[lambda(1),lambda(end)]*1e6);
set(get(AX(1),'xlabel'),'string','Wavelength/\mum','FontSize',24) 
set(get(AX(1),'ylabel'),'string','反射率 dB','FontSize',24) 
set(get(AX(2),'ylabel'),'string','反射率','FontSize',24) 
set(H1,'linewidth',2);
set(H2,'linewidth',2);
y_as = get(AX(1),'ylim');
x_as = get(AX(1),'xlim');
rect = get(AX(1),'position');
[maxH pos] = max(logR);
x_pos = rect(1)+pos/length(lambda)*rect(3);
y_pos = rect(2)+(maxH-y_as(1))/(y_as(2)-y_as(1))*rect(4);
y_pos2 = rect(2)+(maxH-SR-y_as(1))/(y_as(2)-y_as(1))*rect(4);

annotation('doublearrow',[x_pos x_pos],[y_pos y_pos2],'color','r','linewidth',2);
annotation('line',[x_pos-0.05 x_pos+0.05],[y_pos y_pos],'linewidth',2);
annotation('line',[x_pos-0.05 x_pos+0.05],[y_pos2 y_pos2],'linewidth',2);
text(lambda(pos)*1e6,maxH-SR/2,['\leftarrow SMSR=' sprintf('%.0f',SR) ' dB'],'FontSize',15)
text(x_as(1)+(x_as(2)-x_as(1))*0.8,y_as(2)-(y_as(2)-y_as(1))/5,{...
                        ['n_{neff}=' sprintf('%.2f',n)],...
                        ['Δn=' sprintf('%.1f',delta_n*1e4) '×10^{4}'],...
                        ['光栅长度L=' sprintf('%.1f mm',L*1e3)],...
                        ['啁啾系数C=' sprintf('%.1f nm/cm',Chirp)]},'FontSize',15,'color','r');
%标记带宽
if(SR>3)
    thred = 0.5;
    [pos1 pos2] = Get3dBWidth(R,thred);%3dB带宽
    bw = lambda(pos2)-lambda(pos1);
    y_as2 = get(AX(2),'ylim');
    maxH = max(R);
    x_pos1 = rect(1)+pos1/length(lambda)*rect(3);
    x_pos2 = rect(1)+pos2/length(lambda)*rect(3);
    y_pos = rect(2)+(maxH-maxH*(1-thred)-y_as2(1))/(y_as2(2)-y_as2(1))*rect(4);
    annotation('doublearrow',[x_pos1 x_pos2],[y_pos y_pos],'color','r','linewidth',2);
    text(lambda(pos1)*1e6,(maxH*thred-y_as2(1)+(y_as2(2)-y_as2(1))/30)/(y_as2(2)-y_as2(1))...
        *(y_as(2)-y_as(1))+y_as(1),['3dB带宽=' num2str(bw*1e9) 'nm'],'FontSize',15,'color','k')
end