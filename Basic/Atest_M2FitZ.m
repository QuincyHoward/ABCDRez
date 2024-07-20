next;

%% 入射光束
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
%
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
%
syms z
w01m_z=fwz(w01m,theta01m,L01m,z);
fplot(w01m_z,'k-');
%% 
lZ=linspace(-5,5,100);
wZ=double(subs(w01m_z,z,lZ))+1*10^-3*(rand(1,length(lZ))-0.5);
[w03m,theta03m,L03m,M03m]= M2FitZ(lZ, wZ,lambda);
w03m_z=fwz(w03m,theta03m,L03m);
fplot(w03m_z,'b');
plot(lZ,wZ,'r+');


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日