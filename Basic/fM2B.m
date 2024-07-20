%% 高阶模转基模
%% [w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda)
function [w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda)
    % w01m为高阶光束光腰 半径
    % theta01m为高阶光束  半角发散角
    % L01m为高阶光束光腰位置
    % M2为光束质量
    % w01为基模输出光腰 半径
    % theta01为基模光束  半角发散角
    % L01为基模光束光腰位置
    
    %默认使用1064nm
    % lambda=1064*10^-9;
    %默认在空气中折射率nn=1
    nn=1;
    
    M2=(w01m*theta01m*pi*nn)/(lambda);
    w01=(w01m)/sqrt(M2);
    theta01=(theta01m)/sqrt(M2);
    L01=L01m;
    
end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日