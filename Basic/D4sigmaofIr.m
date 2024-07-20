% 在柱坐标系下
% 输入光强函数
% 输出光腰


function wr=D4sigmaofIr(Iz)

    P=int(Iz*(symvar(Iz)),[0,inf]);

    sigma2=1/P*int( Iz* (symvar(Iz))^3 ,[0,inf]);
    
    wr=sqrt(2)*sqrt(sigma2);

end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日