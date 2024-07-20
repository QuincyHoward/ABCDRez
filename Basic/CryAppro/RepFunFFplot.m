
function [w02m,theta02m,L02m]=RepFunFFplot(w00m,theta00m,L00m,lambda,dcM,len,ff,n2,Cubecolor)
% w00m,theta00m,L00m 为入射光束参数
% lambda 为波长
% dcM 为 入射光束与光学系统的第一接触面 相对于 原点所处位置
% w02m,theta02m,L02m 为出射光束参数
% len 间隔
% ff 薄透镜焦距 序列
syms z;
%
MFront=[1,0;0,1/n2];
MBack=[1,0;0,n2];
%
[w01m,theta01m,L01m]=fLRMm(w00m,theta00m,L00m,lambda,MFront,0,dcM);
%
for ii=1:(length(ff))
    Mftemp=[1,0;-1/ff(ii),1];
    [w02mtemp,theta02mtemp,L02mtemp]=fLRMm(w01m,theta01m,L01m,lambda,Mftemp,0,dcM+(ii-1)*len);
    if ii<length(ff)
        w02mtemp_z=fwz(w02mtemp,theta02mtemp,L02mtemp);
        % yyaxis left;
        fplot(w02mtemp_z,[dcM+(ii-1)*len,dcM+(ii)*len],Color=Cubecolor);
        % fplot(w02mtemp_z,[dcM+(ii-1)*len,dcM+(ii+1)*len],Color=0.25+0.5*rand(1,3));
    end
    w01m=w02mtemp;
    theta01m=theta02mtemp;
    L01m=L02mtemp;

end

[w02m,theta02m,L02m]=fLRMm(w02mtemp,theta02mtemp,L02mtemp,lambda,MBack,0,dcM+len*(length(ff)-1));
xline(dcM);xline(dcM+len*(length(ff)-1));

end






%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日