%% 高阶高斯光束由右向右传输（反射）
%% [w02m,theta02m,L02m]=fRRMm(w01m,theta01m,L01m,lambda,cM,lencM,dcM)
function [w02m,theta02m,L02m]=fRRMm(w01m,theta01m,L01m,lambda,cM,lencM,dcM)
%         高阶转基模
        [w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
%         基模由右向右传输（反射）
        [w02,theta02,L02]=fRRM(w01,theta01,L01,lambda,cM,lencM,dcM);
%         基模转高阶
        [w02m,theta02m,L02m,~]=fB2M(w02,theta02,L02,M2);
end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日