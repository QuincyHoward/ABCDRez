

%% 模式转换
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w02m,theta02m,L02m,M02]=fB2M(w01,theta01,L01,M2);
syms z
w_1_z=fwz(w01,theta01,L01);
w_2m_z=fwz(w02m,theta02m,L02m);
%%
dcM=0.6;
lencM=100*10^-3;
limR=5*10^-3;
% 薄透镜个数
num=10;
% 介质折射率
n2=1.8;
len=lencM/(num-1);
xx=linspace(dcM,(dcM+lencM),num);
% 设总的有效焦距为
fall=1;












%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日