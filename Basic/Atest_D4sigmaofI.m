
next;

%% 入射光束
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064e-9;
%
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w02m,theta02m,L02m,M02]=fB2M(w01,theta01,L01,M2);
Z02m=w02m/theta02m;
%
syms z
w02m_z=fwz(w02m,theta02m,L02m,z);
%
p=0;
l=0;
num=15;
lz=linspace(L02m-3*Z02m,L02m+3*Z02m,num);
getz=lz(ceil(length(lz)*rand()));
[XX,YY,Eplrphiz,Phizz]=LGbeam(w02m,theta02m,L02m,lambda,getz,p,l,128);
Iz=(Eplrphiz .* (conj(Eplrphiz)) );
%
[wx,wy]=D4sigmaofI(XX,YY,Iz)
wbar=double(subs(w02m_z,z,getz))
%
syms r;
phir=0;
[Eplrphizr,Phizzr]=LGbeamr(w02m,theta02m,L02m,  lambda,getz,p,l,  r,phir);
Ir=(Eplrphizr .* (conj(Eplrphizr)) );
%
wr=double(D4sigmaofIr(Ir))




%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日