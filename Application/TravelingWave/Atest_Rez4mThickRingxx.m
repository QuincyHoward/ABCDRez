%% 矩形环形腔
 next
%%

lambda=1064*10^-9;
% 设所有反射镜为平面反射镜
% 因此，不会引起子午面及弧矢面的像散
RezWidth=150*10^-3;
RezLength=500*10^-3;
%
d11=75*10^-3;
ff1=-500*10^-3;lenff1=3*10^-3;nff1=1.6;
d12=RezWidth-d11-lenff1;
d2=RezLength;
d31=80*10^-3;
ff2=500*10^-3;lenff2=lenff1;nff2=nff1;
d32=RezWidth-d31-lenff2;
d41=20*10^-3;
F1=2000*10^-3;lenF1=125*10^-3;nF1=1.8;
d42=50*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d43=RezLength-(d41+lenF1+d42+lenF2);
%
rlim=5e-3;
LL=2*(RezWidth+RezLength);
%
[Rhoff1,MFff1,MFrontff1,MBackff1]=deF2Rho(ff1,lenff1,nff1);
[Rhoff2,MFff2,MFrontff2,MBackff2]=deF2Rho(ff2,lenff2,nff2);
[RhoF1,MFF1,MFrontF1,MBackF1]=deF2Rho(F1,lenF1,nF1);
[RhoF2,MFF2,MFrontF2,MBackF2]=deF2Rho(F2,lenF2,nF2);
%%

RezPara=[d11,ff1,lenff1,nff1,d12,d2,d31,ff2,lenff2,nff2,d32,...
            d41,F1,lenF1,nF1,d42,F2,lenF2,nF2,d43];


figure;
[www,wthetaL0,FlagRez]=Rez4mThickRing(lambda, RezPara,'plot');

[wwws,wthetaL0s,FlagRezs]=Rez4mThickRing(lambda, RezPara);

[wwwss,wthetaL0ss,FlagRezss]=Rez4mThickRing00(lambda, RezPara);










%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日