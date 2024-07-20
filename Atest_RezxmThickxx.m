next


%% 2m
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(1000+0)*10^-3;
rho2=2500*10^-3;
%
RezPara2m=[rho1,d1,rho2];
figure;
[www2m,wthetaL02m,FlagRez2m]=Rez2mThick(lambda,RezPara2m,'plot');

%% 3m
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(250+0)*10^-3;
F1=1500*10^-3;lenF1=150*10^-3;nF1=1.8;
d2=1-lenF1-d1;
rho2=2500*10^-3;
%
RezPara3m=[rho1,d1,F1,lenF1,nF1,d2,rho2];
figure;
[www3m,wthetaL03m,FlagRez3m]=Rez3mThick(lambda,RezPara3m,'plot');


%% 4m
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(250+0)*10^-3;
F1=1500*10^-3;lenF1=150*10^-3;nF1=1.8;
d3=150*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d2=(300+0)*10^-3;
rho2=-2500*10^-3;
%
RezPara4m=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d2,rho2];
figure;
[www4m,wthetaL04m,FlagRez4m]=Rez4mThick(lambda,RezPara4m,'plot');
[www4ms,wthetaL04ms,FlagRez4ms]=Rez4mThick(lambda,RezPara4m);
[www4mss,wthetaL04mss,FlagRez4mss]=Rez4mThick00(lambda,RezPara4m);

%{
%%
% 输出镜
% rho2
rho2Front=rho2;
rho2Back=2500*10^-3;
lenRho2=50*10^-3;
nRho2=1.6;n1=1;
MRho2Front=[1,0;(nRho2-n1)/(nRho2*rho2Front),n1/nRho2];
MRho2median=[1,lenRho2;0,1];
MRho2Back=[1,0;(n1-nRho2)/(n1*rho2Back),nRho2/n1];
MRho2=MRho2Back*MRho2median*MRho2Front;
%
w002=wthetaL0(1);
theta002=wthetaL0(2);
L002=wthetaL0(3);
[w002oc,theta002oc,L002oc]=fLRMm(w002,theta002,L002,lambda,MRho2Front,0,LL);
[wout001,thetaout001,L0out001]=fLRMm(w002oc,theta002oc,L002oc,lambda,MRho2Back,0,LL+lenRho2);
[wout001s,thetaout001s,L0out001s]=fLRMm(w002,theta002,L002,lambda,MRho2,lenRho2,LL);
figure;
w002_z=fwz(w002,theta002,L002);
w002oc_z=fwz(w002oc,theta002oc,L002oc);
wout001_z=fwz(wout001,thetaout001,L0out001);
wout001s_z=fwz(wout001s,thetaout001s,L0out001s);
xline(LL);xline(LL+lenRho2);
fplot(w002_z,[0,LL],'r');
fplot(w002oc_z,[LL,LL+lenRho2],'g');
fplot(wout001_z,[LL+lenRho2,LL+2],'b--');
fplot(wout001s_z,[LL+lenRho2,LL+2],'c-*');
axis([-0.2*LL 3*LL -inf inf])
title("腔内外束宽")

%}


%% 5m
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(250+0)*10^-3;
F1=1500*10^-3;lenF1=150*10^-3;nF1=1.8;
d3=50*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d4=50*10^-3;
F3=F1;lenF3=lenF1;nF3=nF1;
d2=1-(d1+lenF1+d3+lenF2+d4+lenF3);
rho2=-2500*10^-3;
%
RezPara5m=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d4,F3,lenF3,nF3,d2,rho2];
figure;
[www5m,wthetaL05m,FlagRez5m]=Rez5mThick(lambda,RezPara5m,'plot');



%% 6m
lambda=1064*10^-9;
%
rho1=-1500*10^-3;
d1=(100+0)*10^-3;
F1=1500*10^-3;lenF1=150*10^-3;nF1=1.8;
d3=50*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d4=50*10^-3;
F3=F1;lenF3=lenF1;nF3=nF1;
d5=50*10^-3;
F4=F1;lenF4=lenF1;nF4=nF1;
d2=1-(d1+lenF1+d3+lenF2+d4+lenF3+d5+lenF4);
rho2=-2500*10^-3;
%
RezPara6m=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d4,F3,lenF3,nF3,d5,F4,lenF4,nF4,d2,rho2];
figure;
[www6m,wthetaL06m,FlagRez6m]=Rez6mThick(lambda,RezPara6m,'plot');


%% 7m
lambda=1064*10^-9;
%
rho1=-1000*10^-3;
d1=50*10^-3;
F1=1500*10^-3;lenF1=125*10^-3;nF1=1.8;
d3=20*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d4=10*10^-3;
ff1=100*10^-3;lenff1=3*10^-3;nff1=1.5;
d5=70*10^-3-d4-lenff1;
d23=30*10^-3;
F3=700*10^-3;lenF3=70*10^-3;nF3=1.7;
d22=20*10^-3;
ff2=60*10^-3;lenff2=lenff1;nff2=nff1;
d21=50*10^-3;
rho2=inf;
%
RezPara7m=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d4,ff1,lenff1,nff1,d5,...
    d23,F3,lenF3,nF3,d22,ff2,lenff2,nff2,d21,rho2];
figure;
[www,wthetaL0,FlagRez]=Rez7mThick(lambda,RezPara7m,'plot');





%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日