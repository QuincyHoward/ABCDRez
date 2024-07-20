
%% 单边衰减薄透镜序列
%% y1=a*exp(-x);
% 每个薄透镜焦距
figure
ffd=deRepFunFF(fall,xx,2,n2);
cM2=RepFunFF(len,ffd,n2);
fplot(w_2m_z,[0,dcM],'k-');
%
Cubecolordd=[0 1 0];
[w22mdd,theta22mdd,L22mdd]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffd,n2,Cubecolordd);
w22mdd_z=fwz(w22mdd,theta22mdd,L22mdd);
fplot(w22mdd_z,[dcM+lencM,dcM+lencM+0.5],'--',Color=Cubecolordd)
%
[w22mddbar,theta22mddbar,L22mddbar]=fLRMm(w02m,theta02m,L02m,lambda,cM2,lencM,dcM);
w22mddbar_z=fwz(w22mddbar,theta22mddbar,L22mddbar);
fplot(w22mddbar_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
%
yyaxis right;
plot(xx,ffd,'-*');
xlabel("位置");
ylabel("焦距");
yyaxis left;
ylabel("光束尺寸");



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日