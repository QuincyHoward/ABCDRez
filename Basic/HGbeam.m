% 给出一个具体的位置后
% 输出厄米高斯光束的光强分布矩阵（直角坐标系）   


function [XX,YY,Eplrphiz,Phizz]=HGbeam(w02m,theta02m,L02m,lambda,getz,m,n,num)
    if nargin == 7
        num=128;
    end
    %% 光场
    % %定义符号
    syms z
    % nn=1;
    k=(2*pi)/lambda;
    Z02m=w02m/theta02m;
    % %适当选取Amn可使其归一化，方便起见这里直接
    Amn=1;
    w_2m_z=sqrt(w02m^2+theta02m^2*(z-L02m)^2);
    R_2m=(z-L02m)+Z02m^2/(z-L02m);
    if abs(getz-L02m)<eps
        getz=L02m+10^3*eps;
    end
    R_2mgetz=double(vpa(subs(R_2m,z,getz)));
    w_2m_getz=double(vpa(subs(w_2m_z,z,getz)));
    %
    x=linspace(-5*w_2m_getz,+5*w_2m_getz,num);
    y=linspace(-5*w_2m_getz,+5*w_2m_getz,num);
    [XX,YY]=meshgrid(x,y);
    %%
    w2=(XX.^2+YY.^2);
    phiz= k.*(getz+w2./(2.*R_2mgetz)) - (m+n+1).* (atan(getz/Z02m)) ;
    phiz0= k.*(getz) - (m+n+1).* (atan(getz/Z02m)) ;
    Phizz=phiz-phiz0;
    %
    Eplrphiz=Amn*w02m/w_2m_getz.*hermiteH(m,sqrt(2)/w_2m_getz.*XX).*hermiteH(n,sqrt(2)/w_2m_getz.*YY)...
        .*exp(-w2./(w_2m_getz.^2)).*exp(-1i*phiz).*exp(-1i*k*getz);

    % Iz=(Eplrphiz .* (conj(Eplrphiz)) );

    %%绘图
    % figure(21);
    % mesh(XX,YY,Iz);hold on;
    % title(sprintf('TEM(%d,%d)',m,n));
    % xlabel('X');ylabel('Y');zlabel('Z');
    % view(2)
    % 
    %  figure(22);
    % mesh(XX,YY,Phizz);hold on;
    % title(sprintf('TEM(%d,%d)',m,n));
    % xlabel('X');ylabel('Y');zlabel('Z');
    % view(2)

end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日