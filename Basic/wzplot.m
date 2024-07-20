function wzplot(w02m,theta02m,L02m,lambda,A,B)
%% 基本信息
[w01,theta01,L01,M2]=fM2B(w02m,theta02m,L02m,lambda);
syms z
w_1_z=fwz(w01,theta01,L01,z);
w_2m_z=fwz(w02m,theta02m,L02m,z);
Z02m=w02m/theta02m;
Lmin=L02m-10*Z02m;Lmax=L02m+10*Z02m;
%% 绘制光斑轮廓
figure;
if nargin == 4
    fplot(w_1_z,[Lmin,Lmax],'k--');
    grid on;hold on;
    fplot(w_2m_z,[Lmin,Lmax],'k-');

elseif nargin == 5
    fr=ischar(A);
    if fr==0
        fplot(w_1_z,A,'k--');
        grid on;hold on;
        fplot(w_2m_z,A,'k-');
    else
        fplot(w_1_z,[Lmin,Lmax],A);
        grid on;hold on;
        fplot(w_2m_z,[Lmin,Lmax],A);
    end

elseif  nargin == 6
    fplot(w_1_z,A,B);
    grid on;hold on;
    fplot(w_2m_z,A,B);

end
    title(sprintf('M2=%.3f光束随位置分布',M2));
    xlabel("位置");
    ylabel("光束尺寸")
end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日