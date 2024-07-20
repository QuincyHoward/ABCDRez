

function [www,wthetaL0,FlagRez]=Rez7mThick00(lambda,RezPara)
%% 用于腔内聚焦光束
% RezPara=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d4,ff1,lenff1,nff1,d5,...
%     d23,F3,lenF3,nF3,d22,ff2,lenff2,nff2,d21,rho2];
rho1=    RezPara(01);d1=    RezPara(02);F1=     RezPara(03);
lenF1=   RezPara(04);nF1=   RezPara(05);d3=     RezPara(06);
F2=      RezPara(07);lenF2= RezPara(08);nF2=    RezPara(09);
d4=      RezPara(10);ff1=   RezPara(11);lenff1= RezPara(12);
nff1=    RezPara(13);d5=    RezPara(14);d23=    RezPara(15);
F3=      RezPara(16);lenF3= RezPara(17);nF3=    RezPara(18);
d22=     RezPara(19);ff2=   RezPara(20);lenff2= RezPara(21);
nff2=    RezPara(22);d21=   RezPara(23);rho2=   RezPara(24);
%
[~,MFff1,~,~]=deF2Rho(ff1,lenff1,nff1);
[~,MFff2,~,~]=deF2Rho(ff2,lenff2,nff2);
[~,MF3,MFront3,~]=deF2Rho(F3,lenF3,nF3);
[~,MF1,~,~]=deF2Rho(F1,lenF1,nF1);
if (F1==F2 && lenF1==lenF2 && nF1==nF2)
    MF2=MF1;
else
    [~,MF2,~,~]=deF2Rho(F2,lenF2,nF2);
end
%
MM1=[1,d1;0,1]*MF1*[1,d3;0,1]*MF2*[1,d4;0,1]*MFff1*[1,d5;0,1];
MM2=[1,d23;0,1]*MF3*[1,d22;0,1]*MFff2*[1,d21;0,1];
MM=MM1*MM2;
a=MM(1,1);b=MM(1,2);c=MM(2,1);d=MM(2,2);
%令
G1=a-b/rho1;
G2=d-b/rho2;
FlagRez(1)=G1*G2;
%% 是否满足0<G1*G2<1稳定条件
% figure(22);
www=zeros(1,2);
wthetaL0=zeros(1,3);
if ~( FlagRez(1)<0  ||  FlagRez(1)>1 )
    syms z
    LL1=d1+lenF1+d3+lenF2+d4+lenff1+d5;
    LL2=d23+lenF3+d22+lenff2+d21;
    LL=LL1+LL2;
    %成立稳定性条件
    %0<G1*G2<1
    %% 计算
    %靠近两腔镜束腰大小
    w021=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G1+a*a*G2-2*a*G1*G2))));
    w001=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G2+d*d*G1-2*d*G1*G2))));
    %束腰位置
    L021=(b*G2*(a-G1))/(G1+a*a*G2-2*a*G1*G2);
    L001=LL-(b*G1*(d-G2))/(G2+d*d*G1-2*d*G1*G2);
    %基模发散角
    theta021=sqrt((lambda/(pi*w021))^2);
    theta001=sqrt((lambda/(pi*w001))^2);
    %% 腔内束宽
    %腔内的束宽变换
    %晶体
    w001_z=fwz(w001,theta001,L001);
    [w003,theta003,L003]=fRLMm(w001,theta001,L001,lambda,MF1,lenF1,LL-d1);
    w003_z=fwz(w003,theta003,L003);
    cMM1=MF2*[1,d3;0,1]*MF1;
    [w004,theta004,L004]=fRLMm(w001,theta001,L001,lambda,cMM1,lenF1+d3+lenF2,LL-d1);
    w004_z=fwz(w004,theta004,L004);
    www(1,1)=1/4*double(subs(w001_z,z,LL-d1)+subs(w003_z,z,LL-(d1+lenF1))+...
        subs(w003_z,z,LL-(d1+lenF1+d3))+subs(w004_z,z,LL-(d1+lenF1+d3+lenF2)));
    %非线性晶体
    cMM2=MFront3*[1,d22;0,1]*MFff2;
    [w0F3,theta0F3,L0F3]=fLRMm(w021,theta021,L021,lambda,cMM2,lenff2+d22,d21);
    w0F3_z=fwz(w0F3,theta0F3,L0F3);
    www(1,2)=subs(w0F3_z,z,d21+lenff2+d22+lenF3/2);

    %输出
    cMM3=MF3*[1,d22;0,1]*MFff2;
    [w023,theta023,L023]=fLRMm(w021,theta021,L021,lambda,cMM3,lenff2+d22+lenF3,d21);
    wthetaL0=double([w023,theta023,L023-LL2]);

end

end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日