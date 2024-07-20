function cMM=RepFunFF(len,ff,n2)
% len 间隔
% f 薄透镜焦距 序列
% cM 等效矩阵
% n2 介质折射率
MFront=[1,0;0,1/n2];
MBack=[1,0;0,n2];
Ml=[1,len;0,1];
cM=[1,0;0,1];
%
for ii=1:(length(ff)-1)
    Mftemp=[1,0;-1/ff(length(ff)-ii+1),1];
    cM=cM*Mftemp*Ml;
end
%
Mffirst=[1,0;-1/ff(1),1];
cMM=MBack*cM*Mffirst*MFront;
end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日