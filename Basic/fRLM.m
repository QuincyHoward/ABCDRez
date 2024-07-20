%% 基模由右向左传输
%% [w01,theta01,L01]=fRLM(w02,theta02,L02,lambda,cM,lencM,dcM)
function [w01,theta01,L01]=fRLM(w02,theta02,L02,lambda,cM,lencM,dcM)
        % 转化成由左向右传输，相对变化，[cM,lencM,dcM]不变
        L02temp=2*dcM-lencM-L02;
        [w01,theta01,L01temp]=fLRM(w02,theta02,L02temp,lambda,cM,lencM,dcM-lencM);
        % 镜像对称，相对变化
        L01=2*dcM-lencM-L01temp;
       
end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日