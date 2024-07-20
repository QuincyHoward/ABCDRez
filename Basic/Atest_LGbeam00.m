% 拉盖尔高斯
% LG Beam

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
syms z
nn=1;
lambda=(w02m*theta02m*pi*nn)/(M2);
k=(2*pi)/lambda;
%
getz=linspace(L02m-1.5*Z02m,L02m+1.5*Z02m,5);
p=0;l=0;
%%
num=128;
for ii=1:length(getz)

    [XX,YY,Eplrphiz,Phizz]=LGbeam(w02m,theta02m,L02m,lambda,getz(ii),p,l,num);
    Iz=(Eplrphiz .* (conj(Eplrphiz)) );

    figure(11);
    subplot(1,length(getz),ii);
    mesh(XX,YY,Iz);hold on;
    title(sprintf('getz=%.3f',getz(ii)));
    xlabel('X');ylabel('Y');zlabel('Z');
    view(2)

    figure(12);
    subplot(1,length(getz),ii);
    mesh(XX,YY,(Phizz));hold on;
    title(sprintf('getz=%.3f',getz(ii)));
    xlabel('X');ylabel('Y');zlabel('Z');
    view(2)



end



for ii=1:length(getz)

    syms r
    phir=0;
    [Eplrphiz,Phizz]=LGbeamr(w02m,theta02m,L02m,  lambda,getz(ii),p,l,  r,phir);
    Ir=(Eplrphiz .* (conj(Eplrphiz)) );

    figure(21);
    subplot(1,length(getz),ii);
    fplot(r,Ir,[0,4*w02m],'-');hold on;
    title(sprintf('getz=%.3f',getz(ii)));
    xlabel('r');ylabel('Ir');

    figure(22);
    subplot(1,length(getz),ii);
    fplot(r,Phizz,[0,4*w02m],'-');hold on;
    title(sprintf('getz=%.3f',getz(ii)));
    xlabel('r');ylabel('Phizz');



end


getz0=L02m;
i=1;
for p=0:2
    for l=0:3

        [XX,YY,Eplrphiz,Phizz]=LGbeam(w02m,theta02m,L02m,lambda,getz0,p,l,num);
        I=(Eplrphiz .* (conj(Eplrphiz)) );

        
        figure(31);subplot(3,4,i)
        mesh(XX,YY,I);hold on;
        title(sprintf('LG(%d,%d)',p,l));
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