
%% 梯度透镜
figure
% % figure;
% n(r)=n2-nn22*r^2/2;
syms nn22x
gammax=sqrt(nn22x/n2);
cM0x=[cos(gammax*lencM),sin(gammax*lencM)/(n2*gammax);...
    -n2*gammax*sin(gammax*lencM),cos(gammax*lencM)];
% fxx=-1/cM0x(2,1);
% figure;fplot(fxx,[-10^-3,10^-3]);
%% 注意需要gamma*r^2<<1，有时候出现非物理解
nn22=double(vpasolve(-1/cM0x(2,1)-fall==0));
syms r
nr=n2-nn22*r^2/2;
% figure;fplot(nr,[-20*10^-3,20*10^-3]);
gamma=sqrt(nn22/n2);
cM=[cos(gamma*lencM),sin(gamma*lencM)/(n2*gamma);...
    -n2*gamma*sin(gamma*lencM),cos(gamma*lencM)];
%
fplot(w_2m_z,[0,dcM],'k-');
%
[w22mffbar,theta22mffbar,L22mffbar]=fLRMm(w02m,theta02m,L02m,lambda,cM,lencM,dcM);
w22mffbar_z=fwz(w22mffbar,theta22mffbar,L22mffbar);
fplot(w22mffbar_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
% % [w02ms,theta02ms,L02ms]=fRLMm(w22mffbar,theta22mffbar,L22mffbar,lambda,cM,lencM,dcM+lencM);
% % w02ms_z=fwz(w02ms,theta02ms,L02ms);
% % fplot(w02ms_z,[0,dcM],'bo')
%%
cMz=[cos(gamma*z),sin(gamma*z)/(n2*gamma);...
    -n2*gamma*sin(gamma*z),cos(gamma*z)];
zx=linspace(dcM,dcM+lencM,20);
w22mtemp_zx=zeros(size(zx));
for ii=1:(length(zx))
    cMtemp1=double(subs(cMz,z,(zx(ii)-dcM)));
    [w22mtemp,theta22mtemp,L22mtemp]=fLRMm(w02m,theta02m,L02m,...
        lambda,cMtemp1,(zx(ii)-dcM),dcM);
    w22mtemp_z=fwz(w22mtemp,theta22mtemp,L22mtemp);
    % fplot(w22mtemp_z,[zx(ii),zx(ii)+lencM/length(zx)]);
    w22mtemp_zx(ii)=double(subs(w22mtemp_z,z,zx(ii)));
    % % cMtemp2=double(subs(cMz,z,lencM-(zx(ii)-dcM)));
    % % [w22mffbars,theta22mffbar,L22mffbars]=fLRMm(w22mtemp,theta22mtemp,L22mtemp,...
    % %     lambda,cMtemp2,lencM-(zx(ii)-dcM),zx(ii));
    % % w22mffbars_z=fwz(w22mffbars,theta22mffbar,L22mffbars);
    % % yyaxis left;
    % % fplot(w22mffbars_z,[dcM+lencM,dcM+lencM+0.5],'b');

end
w22mff_z=w22mtemp_z;
Cubecolorff=[0 1 1];
plot(zx,w22mtemp_zx,Color=Cubecolorff);
fplot(w22mff_z,[dcM+lencM,dcM+lencM+0.5],'-',Color=Cubecolorff)
%
xline(dcM);xline(dcM+lencM);
%
xlabel("位置");
ylabel("光束尺寸");

% axis([-0.2,dcM+lencM+0.5,0,limR])


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日