

function [www,wthetaL0,FlagRez]=Rez3mThick(lambda,RezPara,str)
if nargin==2
    str='';
end
% RezPara=[rho1,d1,F1,lenF1,nF1,d2,rho2];
rho1=    RezPara(01);d1=    RezPara(02);
F1=     RezPara(03);lenF1=   RezPara(04);nF1=   RezPara(05);
d2=      RezPara(06);rho2=  RezPara(07);
%
syms z
%总腔长
LL=d1+lenF1+d2;
[~,MF1,MFront1,MBack1]=deF2Rho(F1,lenF1,nF1);
%
MM=[1,d2;0,1]*MF1*[1,d1;0,1];
a=MM(1,1);b=MM(1,2);c=MM(2,1);d=MM(2,2);
%令
G1=a-b/rho1;
G2=d-b/rho2;
FlagRez(1)=G1*G2;
%% 是否满足0<G1*G2<1稳定条件
% figure(22);
if ( FlagRez(1)<0  ||  FlagRez(1)>1 )
    www=0;
    wthetaL0=zeros(1,3);
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
    w001=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G1+a*a*G2-2*a*G1*G2))));
    % w002s=abs(sqrt(+(lambda*b/pi)*(sqrt(G1*G2*(1-G1*G2))/abs(G2+d*d*G1-2*d*G1*G2))));
    %束腰位置
    L001=(b*G2*(a-G1))/(G1+a*a*G2-2*a*G1*G2);
    % L002s=LL-( (b*G1*(d-G2))/(G2+d*d*G1-2*d*G1*G2) );
    %基模发散角
    theta001=sqrt((lambda/(pi*w001))^2);
    % theta002s=sqrt((lambda/(pi*w002s))^2);
    %% 腔内束宽
    %腔内的束宽变换
    %由镜1全反镜向输出镜变换
    [wf001,thetaf001,Lf001]=fLRMm(w001,theta001,L001,lambda,MFront1,0,d1);
    [w002,theta002,L002]=fLRMm(wf001,thetaf001,Lf001,lambda,MBack1,0,d1+lenF1);
    %
    w001_z=fwz(w001,theta001,L001);
    wf001_z=fwz(wf001,thetaf001,Lf001);
    w002_z=fwz(w002,theta002,L002);
    % w002s_z=fwz(w002s,theta002s,L002s);
    www=1/2*double(subs(w001_z,z,d1)+subs(w002_z,z,d1+lenF1));
    wthetaL0=double([w002,theta002,L002]);

    if strcmp(str,'plot')

        %% 绘图
        fplot(w001_z,'r',[0,d1]);
        fplot(wf001_z,'g',[d1,d1+lenF1]);
        fplot(w002_z,'m',[d1+lenF1,d1+lenF1+d2]);
        % fplot(w002s_z,'k*',[d1+lenF1,d1+lenF1+d2]);
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