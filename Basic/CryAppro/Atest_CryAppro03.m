%% 厚透镜
figure;
%
[Rhof,MFf,MFrontf,MBackf]=deF2Rho(fall,lencM,n2);
%
fplot(w_2m_z,[0,dcM],'k-');
%
Cubecolorbb=[0 0 1];
%
[w22mbbbar,theta22mbbbar,L22mbbbar]=fLRMm(w02m,theta02m,L02m,lambda,MFrontf,0,dcM);
w22mbbbar_z=fwz(w22mbbbar,theta22mbbbar,L22mbbbar);
fplot(w22mbbbar_z,[dcM,dcM+lencM],'-',Color=Cubecolorbb)
%
[w22mbb,theta22mbb,L22mbb]=fLRMm(w02m,theta02m,L02m,lambda,MFf,lencM,dcM);
w22mbb_z=fwz(w22mbb,theta22mbb,L22mbb);
fplot(w22mbb_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
%
xline(dcM);xline(dcM+lencM);
xlabel("位置");
ylabel("光束尺寸");



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日