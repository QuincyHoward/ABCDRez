%% 光束随距离变化
%% w_z = fwz(w0,theta0,L0,z)

function w_z = fwz(w0,theta0,L0,z)

    if nargin==3
        syms z;
    end
    
    w_z=sqrt(w0^2+theta0^2*(z-L0)^2);
end




%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日