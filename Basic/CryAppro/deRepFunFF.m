function ffx=deRepFunFF(fall,xx,flagcase,n2)
% f0 总的有效焦距
% xx 采样位置
% flagcase 薄透镜模式
% fun 符号函数
syms fx 
lenf=xx(end)-xx(1);
lenl=lenf/(length(xx)-1);
%%
switch flagcase
    case 1
        %% 等焦距薄透镜序列
        ff1=fx*ones(size(xx));
        cM1_fx=RepFunFF(lenl,ff1,n2);
        f01=vpasolve(-1/(cM1_fx(2,1))-fall==0,fx,[fall,sign(fall)*inf]);
        [~,nn]=max(abs(f01));
        f01=f01(nn);
        ffx=f01*ones(size(xx));
    case 2
        %% 单边衰减薄透镜序列
        ff2=fx*(2-cosh( xx-(xx(end)) ));
        cM2_fx=RepFunFF(lenl,ff2,n2);
        f02=vpasolve(-1/(cM2_fx(2,1))-fall==0,fx,[fall,sign(fall)*inf]);
        [~,nn]=max(abs(f02));
        f02=f02(nn);
        ffx=f02*exp((xx-xx(1)));
    case 3
        %% 对称衰减薄透镜序列
        ff3=fx*(2-cosh( xx-(xx(1)+lenf/2) ));
        cM3_fx=RepFunFF(lenl,ff3,n2);
        f03=vpasolve(-1/(cM3_fx(2,1))-fall==0,fx,[fall,sign(fall)*inf]);
        [~,nn]=max(abs(f03));
        f03=f03(nn);
        ffx=f03*(2-cosh( xx-(xx(1)+lenf/2) ));

    otherwise
        dbstop;
end



end














%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日