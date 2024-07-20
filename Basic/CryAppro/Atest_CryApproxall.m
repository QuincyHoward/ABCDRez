figure;

%% 出射
pa=fplot(w22maa_z,[dcM+lencM,dcM+lencM+0.5],'-',Color=Cubecoloraa);
pb=fplot(w22mbb_z,[dcM+lencM,dcM+lencM+0.5],'-<',Color=Cubecolorbb);
pc=fplot(w22mcc_z,[dcM+lencM,dcM+lencM+0.5],'+',Color=Cubecolorcc);
pd=fplot(w22mdd_z,[dcM+lencM,dcM+lencM+0.5],'-o',Color=Cubecolordd);
pe=fplot(w22mee_z,[dcM+lencM,dcM+lencM+0.5],'-',Color=Cubecoloree);
pf=fplot(w22mff_z,[dcM+lencM,dcM+lencM+0.5],'--',Color=Cubecolorff);

%% 晶体内部
fplot(w_2m_z,[dcM,dcM+lencM/2],'--',Color=Cubecoloraa);
fplot(w22maa_z,[dcM+lencM/2,dcM+lencM],'--',Color=Cubecoloraa);
fplot(w22mbbbar_z,[dcM,dcM+lencM],'-',Color=Cubecolorbb);
[w22mcc,theta22mcc,L22mcc]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffc,n2,Cubecolorcc);
[w22mdd,theta22mdd,L22mdd]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffd,n2,Cubecolordd);
[w22mee,theta22mee,L22mee]=RepFunFFplot(w02m,theta02m,L02m,lambda,dcM,len,ffe,n2,Cubecoloree);
plot(zx,w22mtemp_zx,Color=Cubecolorff);

%% 入射
fplot(w_2m_z,[0,dcM],'k-');

xlabel("位置");
ylabel("光束尺寸");
legend([pa,pb,pc,pd,pe,pf],{'单个薄透镜','厚透镜','等焦距薄透镜序列','单边衰减薄透镜序列','对称衰减薄透镜序列','热透镜'})



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日