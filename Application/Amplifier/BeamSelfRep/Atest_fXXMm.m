next;


%% 模式转换
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2;
lambda=1064*10^-9;
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w02m,theta02m,L02m,M02]=fB2M(w01,theta01,L01,M2);
syms z
w01_z=fwz(w01,theta01,L01,z);
w01m_z=fwz(w01m,theta01m,L01m,z);
fplot(w01_z,'k--');
fplot(w01m_z,'k-');
%%
syms dcM
Rho=[5000,4500,4000,3500,3000,2500,2000,1500,1250,1000,800,600,500,300]*10^-3;
Rhoall=[Rho,flip(-Rho)];
lencM=300*10^-3;
dcMx=zeros(size(Rhoall));
for ii=1:length(Rhoall)
    rho=Rhoall(ii);
    cM=[1,0;-2/rho,1];
    [w02m,theta02m,L02m]=fLLMm(w01m,theta01m,L01m,lambda,cM,lencM,dcM);
    dcM01=roundn(double(vpasolve(L02m-L01m==0)),-6);
    dcM02=roundn(double(vpasolve(w02m-w01m==0)),-6);
    if (isempty(dcM02) || isempty(dcM01))
        dcMx(ii)=NaN;
    else
        dcMx(ii)=intersect(dcM01,dcM02);
        %
        yyaxis left;
        [w02mx,theta02mx,L02mx]=fLLMm(w01m,theta01m,L01m,lambda,cM,lencM,dcMx(ii));
        w02mx_z=fwz(w02mx,theta02mx,L02mx);
        colorcc=0.25+0.5*rand(1,3);
        fplot(w02mx_z,[dcMx(ii)-5,dcMx(ii)],Color=colorcc);
        xline(dcMx(ii),Color=colorcc);
        %
    end
end


xlabel('位置/m');
ylabel('束宽/m');



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日