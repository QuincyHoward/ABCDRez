next

%%

lambda=1064e-9;

% rho1=-1500*10^-3;
% d1=(10+0)*10^-3;
F1=500*10^-3;lenF1=30*10^-3;nF1=1.8;
d3=15*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
% d2=(40+0)*10^-3;
% rho2=-2500*10^-3;
limLL=380*10^-3;
limR=5e-3;
%% 暴力求解，耗时长
tic
Rho=-1*[inf,5000,4500,4000,3500,3000,2500,2000,1500,1250,1000,750,500,350]*10^-3;
Rhoall=[Rho,flip(-Rho)];
d1min=10*10^-3;d1max=160*10^-3;
d2min=40*10^-3;d2max=200*10^-3;
% 一般有效的束宽随距离呈线性变换，且变化不大
% 若变化大，则腔很可能介于稳定腔与非稳定腔边缘
d1x=linspace(d1min,d1max,6);
d2x=linspace(d2min,d2max,7);
www=zeros(length(d2x),length(d1x),length(Rho),length(Rho));
wwwmax=zeros(length(Rho),length(Rho));
% 一般选择两个凸面镜
for ii=1:length(Rho)
    rho1=Rho(ii);
    for jj=1:length(Rho)
        rho2=Rho(jj);
        for kk=1:length(d1x)
            d1=d1x(kk);
            for ll=1:length(d2x)
                d2=d2x(ll);
                LL=d1+lenF1+d3+lenF2+d2;
                if LL<limLL
                    RezPara=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d2,rho2];
                    [www(ll,kk,jj,ii),~,~]=Rez4mThick00(lambda,RezPara);
                else
                    www(ll,kk,jj,ii)=0;
                end
            end
        end
        wwwmax(ii,jj)=max(max(www(:,:,jj,ii)));
        disp(string(sprintf('[rho1,rho2,wwwmax]=[%.3f,%.3f,%.3f]\n',rho1,rho2,(wwwmax(ii,jj)*1000) )));
    end
end
clc;
toc
wwwmax( (wwwmax>limR) )=0;
[XX,YY]=meshgrid(Rho,Rho);
mesh(XX,YY,wwwmax);
xlabel('rho1');ylabel('rho2');zlabel('wwwmax');















%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日