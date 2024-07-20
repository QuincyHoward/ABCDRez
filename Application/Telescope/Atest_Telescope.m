next;


%%
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w01mbar,theta01mbar,L01mbar,M02]=fB2M(w01,theta01,L01,M2);
syms z
w01_z=fwz(w01,theta01,L01,z);
w02m_z=fwz(w01m,theta01m,L01m,z);

%%
fff1x=[400,300,250,200,175,150,125,110,100,90,80,75,60,50,30]*10^-3;
fff2x=flip(-fff1x);
FFFx=[inf,fff1x,fff2x];

fff1=[300,250,200,175,150,125,110,100]*10^-3;
fff2=flip(-fff1);

% fff1=fff1x;
% fff2=fff2x;

%%
dcM=1.2;
lenF=3*10^-3;
nF=1.5066;
%% 本文件用于描述设计是否符合设计要求
%   若符合则 FlagLogi==1,否则 FlagLogi==0;
%    w02 == (A ± deltaA)*w01
A=0.5;deltaA=0.2;
%    theta02 == (B ± deltaB)*theta01
B=2;deltaB=0.3;
%    L02 > (dcM+lencM)
%    abs(L02-(dcM+lencM)) < C*w02m/theta02m
C=0.8;
%    wout == (D ± deltaD)*win
D=0.5;deltaD=0.1;
%    lencM <lenLL
lenLL=160*10^-3;
%    w > wmin
wMin=0.5*10^-3;
%% 暴力求解，耗时较长
tic
%
lendelta=3*10^-3;
lenmin=6*10^-3;
lenLall=lenmin:lendelta:lenLL;
ResTele=[];

for ii=1:length(fff1)
    % ii=2;
    F1=fff1(ii);
    [~,MF01,~,~]=deF2Rho(F1,lenF,nF);
    for jj=1:length(fff2)
        % jj=28;
        F2=fff2(end-jj+1);
        [~,MF02,~,~]=deF2Rho(F2,lenF,nF);
        CubeColor=0.25+0.5*rand(3,1);
        for kk=1:length(lenLall)
            % kk=1001;
            lenL=lenLall(kk);
            FlagLogi=FunFlagLogi(w01m,theta01m,L01m,lambda,MF01,MF02,dcM,lenF,lenL,...
                A,deltaA,B,deltaB,C,D,deltaD,wMin,CubeColor);
            if FlagLogi
                ResTele=[ResTele;F1,F2,lenL];
            end
            if mod(kk,100)==1
                disp(string(sprintf('[F1,F2,lenL]=[%.3f,%.3f,%.3f]\n',F1,F2,lenL)));
            end

        end
    end
    clc
end


toc

%% 数据预处理
% 统计与计数
if ~isempty(ResTele)
    w01m_z=fwz(w01m,theta01m,L01m,z);
    fplot(w01m_z,[0,dcM],'r');
    yline(wMin);
    reslenL=ResTele(:,3);
    resFF = unique(ResTele(:,1:2),'rows');
    lenLmax=zeros(size(resFF(:,1)));
    lenLmin=lenLmax;
    numLFF=zeros(size(resFF(:,1)));
    for mm=1:length(resFF(:,1))
        [m,~]=find( ResTele(:,1)==resFF(mm,1) & ResTele(:,2)==resFF(mm,2));
        numLFF(mm,1)=length(m);
        lenLmax(mm,1)=max(  ResTele(m,3) );
        lenLmin(mm,1)=min(  ResTele(m,3) );
        % 标注
        if numLFF(mm,1)>3
            [~,MF01,~,~]=deF2Rho(resFF(mm,1),lenF,nF);
            [w02mres,theta02mres,L02mres]=fLRMm(w01m,theta01m,L01m,lambda,MF01,lenF,dcM);
            w02mres_z=fwz(w02mres,theta02mres,L02mres);
            ylenLmax=double(subs(w02mres_z,z,dcM+lenLmax(mm,1)));
            text(double(dcM+lenLmax(mm,1)),ylenLmax,sprintf('[%.3f,%.3f]\n',resFF(mm,1),resFF(mm,2)));
        end

    end
    % 总表
    resF1F2lenL=[resFF,lenLmin,lenLmax,numLFF];
    %% 确定与查看
    numF1F2lenF=max(resF1F2lenL(:,end));
    F1=resF1F2lenL(numF1F2lenF,1);
    F2=resF1F2lenL(numF1F2lenF,2);
    lenLx=linspace(resF1F2lenL(numF1F2lenF,3)-3*lendelta,resF1F2lenL(numF1F2lenF,1)+3*lendelta,500);
    %
    w03mres=zeros(size(lenLx));
    theta03mres=zeros(size(lenLx));
    L03mres=zeros(size(lenLx));
    for nn=1:length(lenLx)
        lenL=lenLx(nn);
        [~,MF01,~,~]=deF2Rho(F1,lenF,nF);
        [~,MF02,~,~]=deF2Rho(F2,lenF,nF);
        lencM=lenF+lenL+lenF;
        [w02m,theta02m,L02m]=fLRMm(w01m,theta01m,L01m,lambda,MF01,lenF,dcM);
        [w03m,theta03m,L03m]=fLRMm(w02m,theta02m,L02m,lambda,MF02,lenF,dcM+lenF+lenL);
        w03mres(nn)=w03m;
        theta03mres(nn)=theta03m;
        L03mres(nn)=L03m;
    end
    %
    figure;
    yyaxis left
    plot(lenLx,w03mres*1000);
    grid on;hold on;
    plot(lenLx,theta03mres*1000);
    grid on;hold on;
    yyaxis right
    plot(lenLx,L03mres-(dcM+lenF+lenL+lenF));
    legend('w03mres','theta03mres','L03mres');
    grid on;hold on;
    title(string(sprintf('[F1,F2,lenL]=[%.3f,%.3f,%.3f]\n',F1,F2,lenL)));

end















%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日