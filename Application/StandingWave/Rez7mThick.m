

function [www,wthetaL0,FlagRez]=Rez7mThick(lambda,RezPara,str)
%% 用于腔内聚焦光束
if nargin==2
    str='';
end

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
syms z
%

LL1=d1+lenF1+d3+lenF2+d4+lenff1+d5;
LL2=d23+lenF3+d22+lenff2+d21;
LL=LL1+LL2;
[~,MFff1,MFrontff1,MBackff1]=deF2Rho(ff1,lenff1,nff1);
[~,MFff2,MFrontff2,MBackff2]=deF2Rho(ff2,lenff2,nff2);
[~,MF3,MFront3,MBack3]=deF2Rho(F3,lenF3,nF3);
[~,MF1,MFront1,MBack1]=deF2Rho(F1,lenF1,nF1);
if (F1==F2 && lenF1==lenF2 && nF1==nF2)
    MF2=MF1;
    MFront2=MFront1;
    MBack2=MBack1;
else
    [~,MF2,MFront2,MBack2]=deF2Rho(F2,lenF2,nF2);
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
www=zeros(1,2);
wthetaL0=zeros(1,3);
if ( FlagRez(1)<0  ||  FlagRez(1)>1 )
    if strcmp(str,'plot')
        xt = @(t) cos(3*t);
        yt = @(t) sin(2*t);
        fplot(xt,yt);
        title("腔内束宽-不稳");
    end
else
    %成立稳定性条件
    %0<G1*G2<1
    %% 计算
    %靠近两腔镜束腰大小
    w021=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G1+a*a*G2-2*a*G1*G2))));
    % w001s=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G2+d*d*G1-2*d*G1*G2))));
    %束腰位置
    L021=(b*G2*(a-G1))/(G1+a*a*G2-2*a*G1*G2);
    % L001s=LL-( (b*G1*(d-G2))/(G2+d*d*G1-2*d*G1*G2) );
    %基模发散角
    theta021=sqrt((lambda/(pi*w021))^2);
    % theta001s=sqrt((lambda/(pi*w001s))^2);
    %% 腔内束宽
    %腔内的束宽变换
    %由镜2全反镜向输出镜变换
    [w0ff2,theta0ff2,L0ff2]=fLRMm(w021,theta021,L021,lambda,MFrontff2,0,d21);
    [w022,theta022,L022]=fLRMm(w0ff2,theta0ff2,L0ff2,lambda,MBackff2,0,d21+lenff2);
    [w0F3,theta0F3,L0F3]=fLRMm(w022,theta022,L022,lambda,MFront3,0,d21+lenff2+d22);
    [w023,theta023,L023]=fLRMm(w0F3,theta0F3,L0F3,lambda,MBack3,0,d21+lenff2+d22+lenF3);
    [w0ff1,theta0ff1,L0ff1]=fLRMm(w023,theta023,L023,lambda,MFrontff1,0,LL2+d5);
    [w004,theta004,L004]=fLRMm(w0ff1,theta0ff1,L0ff1,lambda,MBackff1,0,LL2+d5+lenff1);
    [w0F2,theta0F2,L0F2]=fLRMm(w004,theta004,L004,lambda,MFront2,0,LL2+d5+lenff1+d4);
    [w003,theta003,L003]=fLRMm(w0F2,theta0F2,L0F2,lambda,MBack2,0,LL2+d5+lenff1+d4+lenF2);
    [w0F1,theta0F1,L0F1]=fLRMm(w003,theta003,L003,lambda,MFront1,0,LL2+d5+lenff1+d4+lenF2+d3);
    [w001,theta001,L001]=fLRMm(w0F1,theta0F1,L0F1,lambda,MBack1,0,LL2+d5+lenff1+d4+lenF2+d3+lenF1);
    w021_z=fwz(w021,theta021,L021);
    w0ff2_z=fwz(w0ff2,theta0ff2,L0ff2);
    w022_z=fwz(w022,theta022,L022);
    w0F3_z=fwz(w0F3,theta0F3,L0F3);
    w023_z=fwz(w023,theta023,L023);
    w0ff1_z=fwz(w0ff1,theta0ff1,L0ff1);
    w004_z=fwz(w004,theta004,L004);
    w0F2_z=fwz(w0F2,theta0F2,L0F2);
    w003_z=fwz(w003,theta003,L003);
    w0F1_z=fwz(w0F1,theta0F1,L0F1);
    w001_z=fwz(w001,theta001,L001);
    % w002s_z=fwz(w002s,theta002s,L002s);
    www(1,1)=1/4*double(subs(w001_z,z,LL-d1)+subs(w003_z,z,LL-(d1+lenF1))+...
        subs(w003_z,z,LL-(d1+lenF1+d3))+subs(w004_z,z,LL-(d1+lenF1+d3+lenF2)));
    www(1,2)=subs(w0F3_z,z,d21+lenff2+d22+lenF3/2);
    wthetaL0=double([w023,theta023,L023-LL2]);
    if strcmp(str,'plot')
        %% 绘图
        fplot(w021_z,'r',[0,d21]);
        fplot(w0ff2_z,'g',[d21,d21+lenff2]);
        fplot(w022_z,'b',[d21+lenff2,d21+lenff2+d22]);
        fplot(w0F3_z,'c',[d21+lenff2+d22,d21+lenff2+d22+lenF3]);
        fplot(w023_z,'r',[d21+lenff2+d22+lenF3,d21+lenff2+d22+lenF3+d23+d5]);
        fplot(w0ff1_z,'k',[LL2+d5,LL2+d5+lenff1]);
        fplot(w004_z,'m',[LL2+d5+lenff1,LL2+d5+lenff1+d4]);
        fplot(w0F2_z,'c',[LL2+d5+lenff1+d4,LL2+d5+lenff1+d4+lenF2]);
        fplot(w003_z,'b',[LL2+d5+lenff1+d4+lenF2,LL2+d5+lenff1+d4+lenF2+d3]);
        fplot(w0F1_z,'g',[LL2+d5+lenff1+d4+lenF2+d3,LL2+d5+lenff1+d4+lenF2+d3+lenF1]);
        fplot(w001_z,'r',[LL2+d5+lenff1+d4+lenF2+d3+lenF1,LL]);
        xline(LL2,'r');
        axis([-0.2*LL 1.2*LL -inf inf])
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