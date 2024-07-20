

function [www,wthetaL0,FlagRez]=Rez4mThickRing00(lambda, RezPara)
% if nargin==2
%     str='';
% end
% if strcmp(str,'plot')
%     [www,wthetaL0,FlagRez(1)]=Rez4mThickRing(lambda, RezPara,str);
%     return;
% end

% RezPara=[d11,ff1,lenff1,nff1,d12,d2,d31,ff2,lenff2,nff2,d32,...
%             d41,F1,lenF1,nF1,d42,F2,lenF2,nF2,d43];
d11=    RezPara(01);ff1=    RezPara(02);lenff1= RezPara(03);
nff1=   RezPara(04);d12=    RezPara(05);d2=     RezPara(06);
d31=    RezPara(07);ff2=    RezPara(08);lenff2= RezPara(09);
nff2=   RezPara(10);d32=    RezPara(11);d41=    RezPara(12);
F1=     RezPara(13);lenF1=  RezPara(14);nF1=    RezPara(15);
d42=    RezPara(16);F2=     RezPara(17);lenF2=  RezPara(18);
nF2=    RezPara(19);d43=    RezPara(20);
%
syms z
%%
[~,MFff1,~,~]=deF2Rho(ff1,lenff1,nff1);
[~,MFff2,~,~]=deF2Rho(ff2,lenff2,nff2);
[~,MFF1,MFrontF1,MBackF1]=deF2Rho(F1,lenF1,nF1);
if (F1==F2 && lenF1==lenF2 && nF1==nF2)
    % Rho2=Rho1;
    MFF2=MFF1;
    MFrontF2=MFrontF1;
    MBackF2=MBackF1;
else
    [~,MFF2,MFrontF2,MBackF2]=deF2Rho(F2,lenF2,nF2);
end

%%
MMA4=[1,d43;0,1]*MFF2*[1,d42;0,1]*MFF1*[1,d41;0,1];
MM3=[1,d32;0,1]*MFff2*[1,d31;0,1];
MM2=[1,d2;0,1];
MM1=[1,d12;0,1]*MFff1*[1,d11;0,1];
MMA=MM1*MMA4*MM3*MM2;
aA=MMA(1,1);bA=MMA(1,2);cA=MMA(2,1);dA=MMA(2,2);
FlagRez(1)=0.5*abs(aA+dA);
%% 是否满足稳定条件 0.5*abs(a+d)<1
if FlagRez(1)>=1
    %不成立稳定性条件
    www=0;
    wthetaL0=zeros(1,3);
else
    %% 计算wthetaL0
    w002=abs(vpa(  sqrt(+(lambda/(2*pi*cA))*sqrt(4-(aA+dA)*(aA+dA)))  ));
    L0002=-vpa((aA-dA)/(2*cA));
    theta002=vpa(sqrt((lambda/(pi*w002))^2));
    wthetaL0=double([w002,theta002,L0002]);
    %% 计算 w041_z
    MMB=MM3*MM2*MM1*MMA4;
    aB=MMB(1,1);%bB=MMB(1,2);
    cB=MMB(2,1);dB=MMB(2,2);
    w041=abs(vpa(  sqrt(+(lambda/(2*pi*cB))*sqrt(4-(aB+dB)*(aB+dB)))  ));
    L041=-vpa((aB-dB)/(2*cB));
    theta041=vpa(sqrt((lambda/(pi*w041))^2));
    w041_z=fwz(w041,theta041,L041);
    %% 计算 w011_z
    MMC=MMA4*MM3*MM2*MM1;
    aC=MMC(1,1);%bC=MMC(1,2);
    cC=MMC(2,1);dC=MMC(2,2);
    w011=abs(vpa(  sqrt(+(lambda/(2*pi*cC))*sqrt(4-(aC+dC)*(aC+dC)))  ));
    L011=-vpa((aC-dC)/(2*cC));
    theta011=vpa(sqrt((lambda/(pi*w011))^2));
    w011_z=fwz(w011,theta011,L011);
    %% 计算 w042_z
    MMD41=MBackF1*[1,lenF1;0,1]*MFrontF1*[1,d41;0,1];
    MMD42=[1,d43;0,1]*MBackF2*[1,lenF2;0,1]*MFrontF2*[1,d42;0,1];
    MMD=MMD41*MM3*MM2*MM1*MMD42;
    aD=MMD(1,1);%bD=MMD(1,2);
    cD=MMD(2,1);dD=MMD(2,2);
    w042=abs(vpa(  sqrt(+(lambda/(2*pi*cD))*sqrt(4-(aD+dD)*(aD+dD)))  ));
    L042=-vpa((aD-dD)/(2*cD));
    theta042=vpa(sqrt((lambda/(pi*w042))^2));
    w042_z=fwz(w042,theta042,L042);
    %%
    www=1/4*double(subs(w041_z,z,d41)+       subs(w011_z,z,-d43)+...
                       subs(w042_z,z,0)  +       subs(w042_z,z,d42));
end

end









%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日