next;


%% 入射光束
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
%
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w02m,theta02m,L02m,M02]=fB2M(w01,theta01,L01,M2);
%
syms z
w01_z=fwz(w01,theta01,L01,z);
w01m_z=fwz(w01m,theta01m,L01m,z);
fplot(w01_z,'k--');
fplot(w01m_z,'k-');
%%
dcM=1;f=500e-3;
cM=[1,0;-1/f,1];
lencM=300*10^-3;


%% 基模
[w11,theta11,L11]=fLRMm(w01,theta01,L01,lambda,cM,lencM,dcM);
w_11_z=fwz(w11,theta11,L11);
fplot(w_11_z,[dcM+lencM,dcM+lencM+3],'r');
%
[w12,theta12,L12]=fLLMm(w01,theta01,L01,lambda,cM,lencM,dcM);
w_12_z=sqrt(w12^2+theta12^2*(z-L12)^2);
fplot(w_12_z,[-2,dcM],'g');
%
[w13,theta13,L13]=fRLMm(w11,theta11,L11,lambda,cM,lencM,dcM+lencM);
w_13_z=sqrt(w13^2+theta13^2*(z-L13)^2);
fplot(w_13_z,[-2,dcM],'b*');
%
[w14,theta14,L14]=fRRMm(w11,theta11,L11,lambda,cM,lencM,dcM+lencM);
w_14_z=sqrt(w14^2+theta14^2*(z-L14)^2);
fplot(w_14_z,[dcM+lencM,dcM+lencM+3],'c');
%
%% 高阶模
[w11m,theta11m,L11m]=fLRMm(w01m,theta01m,L01m,lambda,cM,lencM,dcM);
w_11m_z=fwz(w11m,theta11m,L11m);
fplot(w_11m_z,[dcM+lencM,dcM+lencM+3],'r.-');
%
[w12m,theta1m2,L1m2]=fLLMm(w01m,theta01m,L01m,lambda,cM,lencM,dcM);
w_12m_z=fwz(w12m,theta1m2,L1m2);
fplot(w_12m_z,[-2,dcM],'g.-');
%
[w13m,theta13m,L13m]=fRLMm(w11m,theta11m,L11m,lambda,cM,lencM,dcM+lencM);
w_13m_z=fwz(w13m,theta13m,L13m);
fplot(w_13m_z,[-2,dcM],'b>');
%
[w14m,theta14m,L14m]=fRRMm(w11m,theta11m,L11m,lambda,cM,lencM,dcM+lencM);
w_14m_z=fwz(w14m,theta14m,L14m);
fplot(w_14m_z,[dcM+lencM,dcM+lencM+3],'c.-');
%
%%
wdcM=double(subs(w01m_z,z,dcM));
wdcMplencM=double(subs(w01m_z,z,dcM+lencM));
wdcM0=double(subs(w01_z,z,dcM));
wdcMplencM0=double(subs(w01_z,z,dcM+lencM));
%
rectangle('Position',[dcM, 0, lencM, wdcM])
rectangle('Position',[dcM, 0, lencM, wdcM0])
rectangle('Position',[dcM, 0, lencM, wdcMplencM])
rectangle('Position',[dcM, 0, lencM, wdcMplencM0])
%
title('嵌入式光束描述四种传输')



%% 介质面
% 双凸厚透镜 晶体
lencM=0.5;
n2=1.82;n1=1;
% 曲率表示
phoxx=-5000*10^-3;
MBack=[1,0;(n1-n2)/(n1*-phoxx),n2/n1];
Mmedian=[1,lencM;0,1];
MFront=[1,0;(n2-n1)/(n2*phoxx),n1/n2];
Mf1=MBack*Mmedian*MFront;
f1=-1/Mf1(2,1);
%%
figure(2)
w01m_z=fwz(w01m,theta01m,L01m);
fplot(w01m_z,[0,dcM],'k-');
%%
[w002m,theta002m,L002m]=fLRMm(w01m,theta01m,L01m,lambda,MFront,0,dcM);
w002m_z=fwz(w002m,theta002m,L002m);
fplot(w002m_z,[dcM,dcM+lencM],'r-');
%
[w003m,theta003m,L003m]=fLRMm(w002m,theta002m,L002m,lambda,MBack,0,dcM+lencM);
w003m_z=fwz(w003m,theta003m,L003m);
fplot(w003m_z,[dcM+lencM,dcM+lencM+2],'g-');
%
[w003mbar,theta003mbar,L003mbar]=fLRMm(w01m,theta01m,L01m,lambda,Mf1,lencM,dcM);
w003mbar_z=fwz(w003mbar,theta003mbar,L003mbar);
fplot(w003mbar_z,[dcM+lencM,dcM+lencM+2],'g*');
%
title('介质面处理（厚透镜）');




%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日