next
%
lambda=1064*10^-9;
%
% rho1=-1500*10^-3;
d1=50*10^-3;
F1=1500*10^-3;lenF1=125*10^-3;nF1=1.8;
d3=20*10^-3;
F2=F1;lenF2=lenF1;nF2=nF1;
% d4=35*10^-3;
% ff1=180*10^-3;
lenff1=3*10^-3;nff1=1.5;
d23=30*10^-3;
F3=700*10^-3;lenF3=70*10^-3;nF3=1.7;
d22=20*10^-3;
ff2=60*10^-3;
lenff2=lenff1;nff2=nff1;
d21=15*10^-3;
rho2=inf;
%
limR=2*10^-3;
limRF3=150*10^-6;
% LL=d1+lenF1+d3+lenF2+d4+lenff1+d5+d23+lenF3+d22+lenff2+d22+d21;

%%
d4x=(10:3:60)*10^-3;
ffx=[60,80,100,125,150,160,175,180,200]*10^-3;
rho1x=flip(-1*[inf,5000,4500,4000,3500,3000,2500,2000,1500,1250,1000,500]*10^-3);

wwwFF=zeros(length(d4x),length(ffx),length(ffx),length(rho1x));
wwwF3=zeros(length(d4x),length(ffx),length(ffx),length(rho1x));
wwwFFmax=zeros(length(ffx),length(ffx),length(rho1x));
wwwF3max=zeros(length(ffx),length(ffx),length(rho1x));
ParaRezs=[];
%% 暴力求解，耗时长
tic
for ii=1:length(rho1x)
    rho1=rho1x(ii);
        % rho1=-inf;

    for jj=1:length(ffx)
        ff1=ffx(jj);
        for kk=1:length(d4x)
            d4=d4x(kk);
            d5=70*10^-3-d4-lenff1;
            for ll=1:length(ffx)
                ff2=ffx(ll);

                RezPara=[rho1,d1,F1,lenF1,nF1,d3,F2,lenF2,nF2,d4,ff1,lenff1,nff1,d5,...
                    d23,F3,lenF3,nF3,d22,ff2,lenff2,nff2,d21,rho2];
                [www,~,~]=Rez7mThick00(lambda,RezPara);
                wwwFF(ll,kk,jj,ii)=www(1);
                wwwF3(ll,kk,jj,ii)=www(2);

                Flagwww=FunFlagwww(www,limR,limRF3);
                if Flagwww
                    ParaRezs=[ParaRezs;rho1,ff1,ff2,d4,www(1),www(2)];
                    disp(string(sprintf('[rho1,ff1,d4,ff2,www]=[%.3f,%.3f,%.3f,%.3f,\t{%.3f,%.3f}]\n',...
                        rho1,ff1,d4,ff2,www(1)*10^6,www(2)*10^6)));

                end


            end
            [wwwFFmax(kk,jj,ii),numll]=(max(wwwFF(:,kk,jj,ii)));
            wwwF3max(kk,jj,ii)=(wwwF3(numll,kk,jj,ii));

            disp(string(sprintf('\t\t\t[rho1,ff1,d4,wwwmax]=[%.3f,%.3f,%.3f,\t{%.3f,%.3f}]\n',...
                rho1,ff1,d4,10^6*wwwFFmax(kk,jj,ii),10^6*wwwF3max(kk,jj,ii))));



        end
    end
    clc
end
toc























%% SUMMARY
% Atest_Rez7mThickxxFocusFDRho001.mat
% 选择ff2=60mm，主要是晶体中心距ff2的距离约为60mm，
% wwwFF与ff1、rho1、d4有关
% 这样就尽可能使光腰位于非线性晶体内
% 运行文件后发现，达到要求的腔很少，
% 即使有给出的结果，腔也敏感
%%%
% 具体操作时，可以调节ff1的相对位置d4
% 但整个谐振腔镜片数量较多
% 离轴、倾斜、热透镜等等因素会影响最终结果








%%
function Flagwww=FunFlagwww(www,limR,limRF3)

deltaRmin=0.5;deltaRmax=0.8;
if (www(1)>deltaRmin*limR && www(1)<deltaRmax*limR)
    deltaRF2=0.5;
    if (www(2)>(1-deltaRF2)*limRF3 && www(2)<(1+deltaRF2)*limRF3)
        Flagwww=1;
    else
        Flagwww=0;
    end
else
    Flagwww=0;
end
end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日