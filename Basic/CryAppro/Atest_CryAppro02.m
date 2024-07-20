%% 薄透镜
figure;
ffa=fall;
cM=[1,0;-1/ffa,1];
%
fplot(w_2m_z,[0,dcM],'k-');
%
Cubecoloraa=[0.6350 0.0780 0.1840];
[w22maa,theta22maa,L22maa]=fLRMm(w02m,theta02m,L02m,lambda,cM,0,dcM+lencM/2);
w22maa_z=fwz(w22maa,theta22maa,L22maa);
fplot(w22maa_z,[dcM+lencM,dcM+lencM+0.5],'g-*')
%
fplot(w_2m_z,[dcM,dcM+lencM/2],'-',Color=Cubecoloraa);
fplot(w22maa_z,[dcM+lencM/2,dcM+lencM],'-',Color=Cubecoloraa)
%
xline(dcM);xline(dcM+lencM);
%
xlabel("位置");
ylabel("光束尺寸");



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日