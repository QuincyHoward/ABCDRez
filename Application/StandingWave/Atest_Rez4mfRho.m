next

%% 强参数
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(10+0)*10^-3;
% F1=500*10^-3;
lenF1=30*10^-3;nF1=1.8;
d3=15*10^-3;
% F2=F1;
lenF2=lenF1;nF2=nF1;
d2=(40+0)*10^-3;
rho2=-2500*10^-3;
%
limR=5e-3;
LL=d1+lenF1+d3+lenF2+d2;
%% 暴力求解，耗时短
F1x=linspace(250,2500,250).*10^-3;
www=zeros(size(F1x));
for ii=1:length(F1x)
    F1=F1x(ii);
    F2=F1;
    RezPara=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d2,rho2];
    [www(ii),~,~]=Rez4mThick00(lambda,RezPara);

end
% 剔除超过边界的数据
www( (www>limR) )=0;
%% 绘图
plot(F1x,www.*10^3);
grid on;hold on;
xlabel('焦距/m');
ylabel('有效束宽/mm')
title('有效束宽随热焦距变化情况')




%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日