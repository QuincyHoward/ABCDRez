% M2FitZ
function [w03m,theta03m,L03m,M03m]= M2FitZ(lZ, wZ,lambda)

%% 拟合
[xData, yData] = prepareCurveData( lZ, wZ );
[wZmin,wZmin_n]=min(wZ);
[wZmax,wZmax_n]=max(wZ);
% 设置 fittype 和选项。
ft = fittype( 'sqrt(w^2+theta^2*(x-L0)^2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
% [L0 theta w]
opts.Lower = [-Inf 0 0];
opts.StartPoint = [lZ(wZmin_n), (wZmax-wZmin)/(lZ(wZmax_n)-lZ(wZmin_n)), wZmin];

% 对数据进行模型拟合。
[fitresult, ~] = fit( xData, yData, ft, opts );
w03m=fitresult.w;
theta03m=fitresult.theta;
L03m=fitresult.L0;
%默认在空气中折射率nn=1
nn=1;
M03m=(w03m*theta03m*pi*nn)/(lambda);
   
% % 绘制数据拟合图。
% figure( 'Name', 'fM2' );
% h = plot( fitresult, xData, yData );
% legend( h, 'wZ vs. lZ', 'fM2', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % 为坐标区加标签
% xlabel( '位置：lZ', 'Interpreter', 'none' );
% ylabel( '光斑大小：wZ', 'Interpreter', 'none' );
% title(sprintf('M2=%.3f',M03m));
% grid on

end



%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日