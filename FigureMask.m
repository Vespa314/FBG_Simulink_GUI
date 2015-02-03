function FigureMask()
clc;
close all;
clear all;
%%
%����
lamdaRange = [1550 1565];
lambda=(lamdaRange(1):0.001:lamdaRange(2))* 1e-9;

lambdaB=1553*1e-9;
n=1.45;
delta_n=12e-4;
L=3e-3;
Chirp=10;


%%
%��ֺ����

% % ��˹
a = 20;
z = -0.5:0.01:0.5;
Mask = exp(-a*z.^2);

% % ������
% t = 0:0.05:pi;
% Mask = (cos(t)+1)/2;

%%������
% t = 0:0.05:pi;
% a = 0.9;
% Mask = (a*cos(t)+1)/(1+a);


%%����
% a = 0.6;
% z = -0.5:0.01:0.5;
% Mask = (1-(2*z).^2)./(1-(2*a*z).^2);

%˫������:
% a = 0.4;
% z = -0.5:0.01:0.5;
% Mask = 1/tanh(a)*tanh(2*a*(0.5-z.*sign(z)));


Mask = Mask/max(Mask);
%%
%����
F = GetMaskMatrix(Mask,lambdaB,n,delta_n,L,lambda,Chirp);

logR = 10*log(GetR(F));
R = GetR(F);
SR = SMSR(logR);

%%
%%��ͼ
fig = figure;
set(fig,'outerposition',get(0,'screensize'),'color','w');
set(fig,'menubar','none');

subplot(20,1,1:7);
z = linspace(0,L,length(Mask));
plot(z*1e3,Mask,'k','linewidth',2);
set(gca,'xcolor','b','ycolor','b','xgrid','on')
set(get(gca,'xlabel'),'string','Length (mm)','FontSize',15) 
set(get(gca,'ylabel'),'string','ǿ��','FontSize',24) 
title('��ֺ����','FontSize',15);
text(0,0.5,['��λ������������' num2str(L/length(Mask)/lambdaB)],'FontSize',15,'color','r');


subplot(20,1,9:20);
[AX H1 H2]=plotyy(lambda*1e6,logR,lambda*1e6,R);
set(AX(1),'xcolor','b','ycolor','b','xlim',[lambda(1),lambda(end)]*1e6,...
   'xgrid','on','ygrid','on');
set(AX(2),'xlim',[lambda(1),lambda(end)]*1e6);
set(get(AX(1),'xlabel'),'string','Wavelength/\mum','FontSize',24) 
set(get(AX(1),'ylabel'),'string','������ dB','FontSize',24) 
set(get(AX(2),'ylabel'),'string','������','FontSize',24) 
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
                        ['��n=' sprintf('%.1f',delta_n*1e4) '��10^{4}'],...
                        ['��դ����L=' sprintf('%.1f mm',L*1e3)],...
                        ['���ϵ��C=' sprintf('%.1f nm/cm',Chirp)]},'FontSize',15,'color','r');
%��Ǵ���
if(SR>3)
    thred = 0.5;
    [pos1 pos2] = Get3dBWidth(R,thred);%3dB����
    bw = lambda(pos2)-lambda(pos1);
    y_as2 = get(AX(2),'ylim');
    maxH = max(R);
    x_pos1 = rect(1)+pos1/length(lambda)*rect(3);
    x_pos2 = rect(1)+pos2/length(lambda)*rect(3);
    y_pos = rect(2)+(maxH-maxH*(1-thred)-y_as2(1))/(y_as2(2)-y_as2(1))*rect(4);
    annotation('doublearrow',[x_pos1 x_pos2],[y_pos y_pos],'color','r','linewidth',2);
    text(lambda(pos1)*1e6,(maxH*thred-y_as2(1)+(y_as2(2)-y_as2(1))/30)/(y_as2(2)-y_as2(1))...
        *(y_as(2)-y_as(1))+y_as(1),['3dB����=' num2str(bw*1e9) 'nm'],'FontSize',15,'color','k')
end