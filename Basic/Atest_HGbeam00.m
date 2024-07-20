% 厄米高斯
% HG Beam

next;
%% 入射光束
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064e-9;
%
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w02m,theta02m,L02m,M02]=fB2M(w01,theta01,L01,M2);
% 基模
% w02m=w01;
% theta02m=theta01;
% L02m=L01;
Z02m=w02m/theta02m;
%% 定义符号
% syms phir z phi
syms z
nn=1;
lambda=(w02m*theta02m*pi*nn)/(M2);
k=(2*pi)/lambda;
%%
num=128;
getz=L02m;
i=1;
for m=0:2
    for n=0:3
        [XX,YY,Eplrphiz,Phizz]=HGbeam(w02m,theta02m,L02m,lambda,getz,m,n,num);
        I=(Eplrphiz .* (conj(Eplrphiz)) );

        
        figure(31);subplot(3,4,i)
        mesh(XX,YY,I);hold on;
        title(sprintf('HG(%d,%d)',m,n));
        xlabel('X');ylabel('Y');zlabel('Z');
        view(2)



        i=i+1;
    end

end







%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日