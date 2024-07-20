% 给出一个具体的位置后
% 输出拉盖尔高斯光束的光强分布矩阵（直角坐标系）   


function [Eplrphiz,Phizz]=LGbeamr(w02m,theta02m,L02m,  lambda,getz,p,l,  r,phir)
    if nargin == 8
        phir=0;
    end
    %% 光场
    % %定义符号
    syms z
    k=(2*pi)/lambda;
    Z02m=w02m/theta02m;
    % %适当选取Apl可使其归一化，方便起见这里直接
    Apl=1;
    w_2m_z=fwz(w02m,theta02m,L02m,z);
    R_2m=fRz(w02m,theta02m,L02m,z);
    if abs(getz-L02m)<eps
        getz=L02m+10^3*eps;
    end
    R_2mgetz=double(vpa(subs(R_2m,z,getz)));
    w_2m_getz=double(vpa(subs(w_2m_z,z,getz)));
    %%
    tempx=(r./w_2m_getz).^2;
    Eplrphiztemp=(Apl*w02m/w_2m_getz)    .*  exp(-tempx)   ;
    LL=laguerreL(p,l,2.*tempx);
    %
    phiz= k.*(getz+r.*r/(2.*R_2mgetz)) - (2*p+l+1).* (atan(getz/Z02m)) ;
    phiz0= k.*(getz) - (2*p+l+1).* (atan(getz/Z02m)) ;
    %
    Eplrphiz=Eplrphiztemp   .* LL   .* exp(-1i.*( phiz   ))   .*  (sqrt(2).*r./w_2m_getz).^l  .*   cos(l.*phir);
    Phizz=phiz-phiz0;

    % Iz=(Eplrphiz .* (conj(Eplrphiz)) );
    %% 绘图
    % figure(21);
    % mesh(XX,YY,Iz);hold on;
    % title(sprintf('TEM(%d,%d)',p,l));
    % xlabel('X');ylabel('Y');zlabel('Z');
    % view(2)
    % 
    %  figure(22);
    % mesh(XX,YY,Phizz);hold on;
    % title(sprintf('TEM(%d,%d)',p,l));
    % xlabel('X');ylabel('Y');zlabel('Z');
    % view(2)

end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日