next

%%

lambda=1064e-9;

% rho1=-1500*10^-3;
d1=(10+0)*10^-3;
F1=500*10^-3;lenF1=30*10^-3;nF1=1.8;
d3=15*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
d2=(40+0)*10^-3;
% rho2=-2500*10^-3;

limR=5e-3;
LL=d1+lenF1+d3+lenF2+d2;
%% 暴力求解，耗时较短
tic
Rho=[5000,4500,4000,3500,3000,2500,2000,1500,1250,1000,800,600,500,450,400,350,300,250]*10^-3;
Rhoall=[inf,Rho,flip(-Rho),-inf];
www=zeros(length(Rhoall),length(Rhoall));
for ii=1:length(Rhoall)
    rho1=Rhoall(ii);
    for jj=1:length(Rhoall)
        rho2=Rhoall(jj);
        RezPara=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d2,rho2];
        [www(ii,jj),~,~]=Rez4mThick00(lambda,RezPara);
    end
end

toc
www( (www>limR) )=0;
[XX,YY]=meshgrid(Rhoall,Rhoall);
mesh(XX,YY,www);
xlabel('rho1');ylabel('rho2');zlabel('www');


















%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日