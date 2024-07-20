%%
function [www,wthetaL0,FlagRez]=Rez4mThickRing(lambda, RezPara,str)
if nargin==2
    str='';
end
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
RezWidth=d11+lenff1+d12;
RezLength=d2;
LL=2*(RezLength+RezWidth);
syms z
%%
[~,MFff1,MFrontff1,~]=deF2Rho(ff1,lenff1,nff1);
[~,MFff2,MFrontff2,MBackff2]=deF2Rho(ff2,lenff2,nff2);
[~,MFF1,MFrontF1,MBackF1]=deF2Rho(F1,lenF1,nF1);
if (F1==F2 && lenF1==lenF2 && nF1==nF2)
    % Rho2=Rho1;
    MFF2=MFF1;
    MFrontF2=MFrontF1;
    MBackF2=MBackF1;
else
    [~,MFF2,MFrontF2,MBackF1]=deF2Rho(F2,lenF2,nF2);
end
%
MM4=[1,d43;0,1]*MFF2*[1,d42;0,1]*MFF1*[1,d41;0,1];
MM3=[1,d32;0,1]*MFff2*[1,d31;0,1];
MM2=[1,d2;0,1];
MM1=[1,d12;0,1]*MFff1*[1,d11;0,1];
MM=MM1*MM4*MM3*MM2;
a=MM(1,1);b=MM(1,2);c=MM(2,1);d=MM(2,2);
FlagRez(1)=0.5*abs(a+d);
%% 是否满足稳定条件 0.5*abs(a+d)<1
if FlagRez(1)>=1
    %不成立稳定性条件
    www=0;
    wthetaL0=zeros(1,3);
    if strcmp(str,'plot')
        xt = @(t) cos(3*t);
        yt = @(t) sin(2*t);
        fplot(xt,yt);
        title("腔内束宽-不稳")
    end
else
    %成立稳定性条件
    %% 计算
    %束腰宽度
    w002=abs(vpa(  sqrt(+(lambda/(2*pi*c))*sqrt(4-(a+d)*(a+d)))  ));
    %参考束腰位置
    L0002=-vpa((a-d)/(2*c));
    %发散角
    theta002=vpa(sqrt((lambda/(pi*w002))^2));

    %% 腔内束宽
    %特殊情况
    %平面反射
    [w0ff2,theta0ff2,L0ff2]=fLRMm(w002,theta002,L0002,lambda,MFrontff2,0,RezLength+d31);
    [w032,theta032,L0032]=fLRMm(w0ff2,theta0ff2,L0ff2,lambda,MBackff2,0,RezLength+d31+lenff2);
    [w0F1,theta0F1,L0F1]=fLRMm(w032,theta032,L0032,lambda,MFrontF1,0,RezWidth+RezLength+d41);
    [w042,theta042,L0042]=fLRMm(w0F1,theta0F1,L0F1,lambda,MBackF1,0,RezWidth+RezLength+d41+lenF1);
    [w0F2,theta0F2,L0F2]=fLRMm(w042,theta042,L0042,lambda,MFrontF2,0,RezWidth+RezLength+d41+lenF1+d42);
    [w043,theta043,L0043]=fLRMm(w0F2,theta0F2,L0F2,lambda,MBackF2,0,RezWidth+RezLength+d41+lenF1+d42+lenF2);
    [w0ff1,theta0ff1,L0ff1]=fLRMm(w043,theta043,L0043,lambda,MFrontff1,0,RezWidth+2*RezLength+d11);
    w012=w002;theta012=theta002;L0012=LL+L0002;
    %
    w002_z=fwz(w002,theta002,L0002);
    w0ff2_z=fwz(w0ff2,theta0ff2,L0ff2);
    w032_z=fwz(w032,theta032,L0032);
    w0F1_z=fwz(w0F1,theta0F1,L0F1);
    w042_z=fwz(w042,theta042,L0042);
    w0F2_z=fwz(w0F2,theta0F2,L0F2);
    w043_z=fwz(w043,theta043,L0043);
    w0ff1_z=fwz(w0ff1,theta0ff1,L0ff1);
    w012_z=fwz(w012,theta012,L0012);
    %
    www=1/4*double(subs(w0F2_z,z,(d2+d31+lenff2+d32+d41+lenF1+d42))+...
        subs(w0F2_z,z,(d2+d31+lenff2+d32+d41+lenF1+d42+lenF2))+...
        subs(w0F1_z,z,(d2+d31+lenff2+d32+d41))+...
        subs(w0F1_z,z,(d2+d31+lenff2+d32+d41+lenF1)));
    wthetaL0=double([w002,theta002,L0002]);
    if strcmp(str,'plot')
        fplot(w002_z,'r',[0,d2+d31]);
        fplot(w0ff2_z,'b',[d2+d31,d2+d31+lenff2]);
        fplot(w032_z,'m',[d2+d31+lenff2,d2+d31+lenff2+d32+d41]);
        fplot(w0F1_z,'c',[d2+d31+lenff2+d32+d41,d2+d31+lenff2+d32+d41+lenF1]);
        fplot(w042_z,'c',[d2+d31+lenff2+d32+d41+lenF1,d2+d31+lenff2+d32+d41+lenF1+d42]);
        fplot(w0F2_z,'b',[d2+d31+lenff2+d32+d41+lenF1+d42,d2+d31+lenff2+d32+d41+lenF1+d42+lenF2]);
        fplot(w043_z,'g',[d2+d31+lenff2+d32+d41+lenF1+d42+lenF2,d2+d31+lenff2+d32+d41+lenF1+d42+lenF2+d43+d11]);
        fplot(w0ff1_z,'r',[d2+d31+lenff2+d32+d41+lenF1+d42+lenF2+d43+d11,d2+d31+lenff2+d32+d41+lenF1+d42+lenF2+d43+d11+lenff1]);
        fplot(w012_z,'r',[d2+d31+lenff2+d32+d41+lenF1+d42+lenF2+d43+d11+lenff1,LL]);
        xline(0);xline(RezLength);
        xline(RezWidth+RezLength);
        xline(RezWidth+2*RezLength);
        xline(LL);
        axis([-0.2*LL,1.2*LL,-inf,inf])
        title("腔内束宽")

    end



end



end












%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日