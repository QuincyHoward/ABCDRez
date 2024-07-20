%% 对称衰减薄透镜序列
%% y2=a* (exp(x)+exp(-x)) ;
figure
ffe=deRepFunFF(fall,xx,3,n2);
cM3=RepFunFF(len,ffe,n2);
fplot(w_2m_z,[0,dcM],'k-');
%
Cubecoloree=[1 0 0];
[w22mee,theta22mee,L22mee]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffe,n2,Cubecoloree);
w22mee_z=fwz(w22mee,theta22mee,L22mee);
fplot(w22mee_z,[dcM+lencM,dcM+lencM+0.5],'-',Color=Cubecoloree)
%
[w22meebar,theta22meebar,L22meebar]=fLRMm(w02m,theta02m,L02m,lambda,cM3,lencM,dcM);
w22meebar_z=fwz(w22meebar,theta22meebar,L22meebar);
fplot(w22meebar_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
%
yyaxis right;
plot(xx,ffe,'-*');
xlabel("位置");
ylabel("焦距");
yyaxis left;
ylabel("光束尺寸");
%



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日