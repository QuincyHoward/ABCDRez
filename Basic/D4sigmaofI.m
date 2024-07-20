% 在直角坐标系下
% 输入一个光强矩阵
% 输出两个方向上的光腰


function [wx,wy]=D4sigmaofI(XX,YY,Iz)
    P=sum(sum(Iz));
    sigmax2=1/P*sum(sum(XX.^2.*Iz));
    sigmay2=1/P*sum(sum(YY.^2.*Iz));
    % sigmaxy2=1/P*sum(sum(XX.*YY.*Iz));
    
    wx=sqrt(sigmax2*4);
    wy=sqrt(sigmay2*4);


end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日