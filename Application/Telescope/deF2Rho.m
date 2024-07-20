

function [Rho,MF,MFront,MBack]=deF2Rho(F,lenF,nF)
    % F 厚透镜有效焦距
    % lenF 厚透镜长度
    % nF 厚透镜介质折射率
    n1=1;
    % 曲率表示
    syms phox
    MFront=[1,0;(nF-n1)/(nF*-phox),n1/nF];
    Mmedian=[1,lenF;0,1];
    MBack=[1,0;(n1-nF)/(n1*phox),nF/n1];
    Mf1=MBack*Mmedian*MFront;
    %求解代换
    phoxx=vpasolve(Mf1(2,1)==-1/F);
    [~,nn]=max(abs(phoxx));
    Rho=phoxx(nn);
    % % % % % % % %
    % 多个解？？！！
    % % % % % % % %
    
    MFront=double([1,0;(nF-n1)/(nF*-Rho),n1/nF]);
    Mmedian=double([1,lenF;0,1]);
    MBack=double([1,0;(n1-nF)/(n1*Rho),nF/n1]);
    MF=MBack*Mmedian*MFront;



end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日