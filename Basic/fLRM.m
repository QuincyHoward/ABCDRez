
%% 基模由左向右传输
%% [w02,theta02,L02]=fLRM(w01,theta01,L01,lambda,cM,lencM,dcM)
function [w02,theta02,L02]=fLRM(w01,theta01,L01,lambda,cM,lencM,dcM)
% 默认使用基模计算,由左向右传输
% w01,theta01,L01 为入射光束参数
% lambda 为波长
% cM 为光学系统的传输矩阵
% lencM 为光学系统长度
% dcM 为 入射光束与光学系统的第一接触面 相对于 原点所处位置
% w02,theta02,L02 为出射光束参数

%% 物方光束
Z0=w01/theta01;
syms z;
w_1_z=w01*sqrt(1+((z-L01)/Z0)^2);
R_z1=Z0*((z-L01)/Z0+Z0/(z-L01));
R01=subs(R_z1,z,eps);
w_001=subs(w_1_z,z,0);

%% 传输矩阵相关定义及计算
syms X1 Y1 z
% syms R_1
% q参数定义
% syms s1 s2 a b c d

% 取n1=n2=1;
n1=1;n2=1;


%传输矩阵元素
s2=z;
a=cM(1,1);b=cM(1,2);c=cM(2,1);d=cM(2,2);
s1=dcM;
%其他特征参量
M=[1 s2;0,1]*[a b;c d]*[1,s1;0,1];
A=M(1,1);B=M(1,2);
% C=M(2,1);D=M(2,2);
Y2=(n1/n2)*Y1/...
    (A^2+2*X1*A*B+(X1^2+Y1^2)*B^2);

%% 像方光束
w_2=sqrt(lambda/(pi*Y2));
w_2=subs(w_2,[X1 Y1],[1/R01 lambda/(pi*w_001^2)]);
%光腰参考点平移
w_2=subs(w_2,(z),(z-s1));

%% 输出参数
% disp('w_2*w_2=');pretty(w_2*w_2);
T1=vpa((taylor((w_2*w_2),z,'Order',1)));
T2=vpa((taylor((w_2*w_2),z,'Order',2)));
T3=vpa((taylor((w_2*w_2),z,'Order',3)));
C=T1;
B=(T2-T1)/z;
A=(T3-T2)/(z*z);
w02=vpa(sqrt(C-B*B/(4*A)));
theta02=vpa(sqrt(A));
L02=vpa(-B/(2*A));

L02=L02+lencM;

end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日