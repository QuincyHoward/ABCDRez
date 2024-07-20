

next;


%% 4f系统

%%
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w01mbar,theta01mbar,L01mbar,M02]=fB2M(w01,theta01,L01,M2);
syms z
w01_z=fwz(w01,theta01,L01,z);
w01m_z=fwz(w01m,theta01m,L01m,z);
%
f1=60*10^-3;
lendelta=f1;
Mf1=[1,0;-1/f1,1];
Mlen1=[1,lendelta;0,1];
%
cMall=Mlen1*Mf1*Mlen1*Mlen1*Mf1*Mlen1;
%
lencM=4*lendelta;
dcMall=1;
[w03ms,theta03ms,L03ms]=fLRMm(w01m,theta01m,L01m,lambda,cMall,lencM,dcMall);
%
cM1=Mf1;
dcM1=dcMall+lendelta;
[w02m,theta02m,L02m]=fLRMm(w01m,theta01m,L01m,lambda,cM1,0,dcM1);
dcM2=dcMall+3*lendelta;
[w03m,theta03m,L03m]=fLRMm(w02m,theta02m,L02m,lambda,cM1,0,dcM2);
%
w03ms_z=fwz(w03ms,theta03ms,L03ms,z);
w02m_z=fwz(w02m,theta02m,L02m,z);
w03m_z=fwz(w03m,theta03m,L03m,z);
%
figure;
fplot(w01m_z,[0,dcMall+lendelta],'k');
fplot(w02m_z,[dcM1,dcM1+lendelta*2],'g');
fplot(w03m_z,[dcM2,dcM2+lendelta+1],'r');
fplot(w03ms_z,[dcM2,dcM2+lendelta+1],'c*');
xline(dcMall);
xline(dcMall+1*lendelta,'--');xline(dcMall+2*lendelta);
xline(dcMall+3*lendelta,'--');xline(dcMall+4*lendelta);


double(w03m-w01m)
double(theta03m-theta01m)
double(L03m-L01m-4*lendelta)




%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日