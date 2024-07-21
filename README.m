%% 添加文件夹路径
addpath(genpath('.'));

%% 修改fplot函数
matlabrootpath=matlabroot;
path0='\toolbox\matlab\graphics\function\fplot.m';
filepathname=strcat(matlabrootpath,path0);
%%%%%%%%%%%%%%%%%%%%%%%%%%
% 自行在fplot主函数末尾添加（不是文件末尾）
% grid on;hold on;
data ='grid on;hold on;';
edit(filepathname);
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 打开说明书
winopen .\DOC\ABCD激光谐振腔仿真.pdf


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日
