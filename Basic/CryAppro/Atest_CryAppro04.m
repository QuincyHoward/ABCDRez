%% 等焦距薄透镜序列
% 每个薄透镜焦距
figure;
ffc=deRepFunFF(fall,xx,1,n2);
cM=RepFunFF(len,ffc,n2);
fplot(w_2m_z,[0,dcM],'k-');
%
Cubecolorcc=[0.8500 0.3250 0.0980];
[w22mcc,theta22mcc,L22mcc]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffc,n2,Cubecolorcc);
w22mcc_z=fwz(w22mcc,theta22mcc,L22mcc);
fplot(w22mcc_z,[dcM+lencM,dcM+lencM+0.5],'-',Color=Cubecolorcc)
%
[w22mccbar,theta22mccbar,L22mccbar]=fLRMm(w02m,theta02m,L02m,lambda,cM,lencM,dcM);
w22mccbar_z=fwz(w22mccbar,theta22mccbar,L22mccbar);
fplot(w22mccbar_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
%
yyaxis right;
plot(xx,ffc,'-*');
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