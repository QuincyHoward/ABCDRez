%% SUMMARY
% 晶体内温度分布随光腰位置变化不明显，原因可能是随长度的指数项的影响
% 晶体内温度分布随泵浦光光腰大小变化明显
% 晶体内温度分布随泵浦功率变化明显
% 在降维时，需注意柱坐标和直角坐标求梯度、散度的系数不同
next
syms x y z


%% 相关参数
%热传导系数，20℃，设定不变
kappa=14;%W/m/K
%吸收系数，@808nm
alpha=2.7*100;
%发热效率
eta=1-808/1064;
%入射功率
Pin=30;%W
%晶体长度
lenL=30*10^-3;%m
%晶体半径
r0=1.5*10^-3;%m
%折射率,设定不变
n1=1;n2=1.82;
%泵浦束腰半径
w0bm=0.5*10^-3;%m
%泵浦光波长
lambda01=808e-9;%m


%% 设置泵浦光束时，需注意与晶体几何边界的关系
%泵浦光M2
M2=350;
%泵浦光焦点位置到晶体端面的距离
L0Offset=1/5*lenL;%m
%泵浦光发散角
theta0bm=(lambda01*M2)/(pi*w0bm);
%% 查看
figure
w0bm_z=fwz(w0bm,theta0bm,L0Offset);
% 简单考虑热透镜
F=1500*10^-3;
[RhoF,MFF,MFFront,MFBack]=deF2Rho(F,lenL,n2);
[w02m,theta02m,L02m]=fLRMm(w0bm,theta0bm,L0Offset,lambda01,MFFront,0,0);
w02m_z=fwz(w02m,theta02m,L02m);
fplot(w0bm_z,[-0.2*lenL,0],'r');
fplot(w0bm_z,[0,lenL],'r--');
fplot(w02m_z,[0,lenL],'k');
rectangle('Position',[0,0,lenL,r0]);

w03m=w0bm;theta03m=theta0bm;L03m=lenL-L0Offset;
[w04m,theta04m,L04m]=fRLMm(w03m,theta03m,L03m,lambda01,MFFront,0,lenL);
w03m_z=fwz(w03m,theta03m,L03m);
w04m_z=fwz(w04m,theta04m,L04m);

fplot(w03m_z,[lenL,1.2*lenL,],'r');
fplot(w03m_z,[0,lenL],'r--');
fplot(w04m_z,[0,lenL],'k');


%% 热源函数,不随时间变化,简单考虑热焦距
w_x1=sqrt(w02m.^2+theta02m.^2.*(x-L02m).^2);
AA1=(2*alpha*eta*Pin)/(pi*(1-exp(-alpha*lenL)));
q1=AA1./((w_x1).^2).*exp((-2.*(abs(y')).^2)./(w_x1.^2)).*exp(-alpha.*x);
% 假设另一端对称泵浦，则有
w_x2=sqrt(w04m.^2+theta04m.^2.*(x-L04m).^2);
AA2=(2*alpha*eta*Pin)/(pi*(1-exp(-alpha*lenL)));
q2=AA2./((w_x2).^2).*exp((-2.*(abs(y')).^2)./(w_x2.^2)).*exp(-alpha.*(lenL-x));
%
qq=q1+q2;
%
%
xx=linspace(0,lenL,400);
yy=linspace(-r0,r0,300);
[XX,YY]=meshgrid(xx,yy);
w_x1=sqrt(w02m.^2+theta02m.^2.*(xx-L02m).^2);
AA1=(2*alpha*eta*Pin)/(pi*(1-exp(-alpha*lenL)));
q1=AA1./((w_x1).^2).*exp((-2.*(abs(yy')).^2)./(w_x1.^2)).*exp(-alpha.*xx);
% 假设另一端对称泵浦，则有
w_x2=sqrt(w04m.^2+theta04m.^2.*(xx-L04m).^2);
AA2=(2*alpha*eta*Pin)/(pi*(1-exp(-alpha*lenL)));
q2=AA2./((w_x2).^2).*exp((-2.*(abs(yy')).^2)./(w_x2.^2)).*exp(-alpha.*(lenL-xx));
%
qq00=q1+q2;
qq00=double(qq00);
% mesh(XX,YY,qq00)
% 归一化qq00;
qq00min=min(min(qq00));qq00max=max(max(qq00));
qq00uni=(qq00-qq00min)/(qq00max-qq00min);
contour3(XX,YY,qq00uni,LineWidth=2);


%%
%% pde最终替换
rr=abs(y);
ff0x=qq/kappa.*rr;
ff0=replace(char(ff0x),["*","/","^"],[".*","./",".^"]);
% 边界温度
rrr=num2str(18+273.15);
ccc=char(rr);
aaa=num2str(0);
fff=ff0;
APDE_heat3d(lenL,r0,ccc,aaa,fff,rrr)

%%
%%
%% 结果u,网格p,e,t需要手动导出
umin=min(u);umax=max(u);
uuni=(u-umin)/(umax-umin);

figure;
fplot(w0bm_z,[-0.2*lenL,0],'r');
fplot(w0bm_z,[0,lenL],'r--');
fplot(w02m_z,[0,lenL],'k');
fplot(w03m_z,[lenL,1.2*lenL,],'r');
fplot(w03m_z,[0,lenL],'r--');
fplot(w04m_z,[0,lenL],'k');

contour3(XX,YY,qq00uni,LineWidth=2);
pdeplot(p,e,t,XYData=uuni,ZData=(uuni*0-eps))
view(2)
axis([-0.2*lenL,1.2*lenL,-inf,inf])





%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日