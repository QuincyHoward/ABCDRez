next;

%%
w01m=(1.241+1.459)/2*10^-3;
theta01m=(1.656+1.383)/2*10^-3;
L01m=(0.369+0.430)/2+0.9;
lambda=1064*10^-9;
[w01,theta01,L01,M2]=fM2B(w01m,theta01m,L01m,lambda);
[w01mbar,theta01mbar,L01mbar,M02]=fB2M(w01,theta01,L01,M2);
syms z
w01_z=fwz(w01,theta01,L01,z);
w01m_z=fwz(w01m,theta01m,L01m,z);
%
F3=700*10^-3;lenF3=70*10^-3;nF3=1.7;
[Rho3,MF3,MFront3,MBack3]=deF2Rho(F3,lenF3,nF3);
ffx=[60,80,100,120,125,150,160,175,180,200,225,250,300]*10^-3;
lenff=3*10^-3;nff=1.6;
%%
d1x=(4:3:100)*10^-3;
syms d2x
deltaw=0.3;
w0F3set=150*10^-6;
dcM=1;ParaSet=[];
tic
for jj=1:length(ffx)
    ff=ffx(jj);
    [~,Mff,~,~]=deF2Rho(ff,lenff,nff);

    for kk=1:length(d1x)
        d1=d1x(kk);
        %
        cMall=MFront3*[1,d2x;0,1]*Mff*[1,d1;0,1];
        lencMall=d2x+lenff+d1;
        [w0F3,theta0F3,L0F3]=fLRMm(w01,theta01,L01,lambda,cMall,lencMall,dcM);
        %
        d2xx=vpasolve(L0F3-(lencMall+dcM+lenF3/2)==0);
        [~,nn]=min(abs(d2xx));
        d2=double(d2xx(nn));
        if (d1+d2<200*10^-3)
            w0F3d2=double(subs(w0F3,d2x,d2));
            if (w0F3d2>(1-deltaw)*w0F3set && w0F3d2<(1+deltaw)*w0F3set)
                disp(string(sprintf('[d1,ff,d2,w0F3d2]=[%.3f,%.3f,%.3f,\t{%.3f um}]\n',...
                    d1,ff,d2,w0F3d2*10^6)));
                ParaSet=[ParaSet;d1,ff,d2,w0F3d2];
                %% 绘图
                [w02,theta02,L02]=fLRMm(w01,theta01,L01,lambda,Mff,lenff,dcM+d1);
                [w0F3,theta0F3,L0F3]=fLRMm(w02,theta02,L02,lambda,MFront3,0,dcM+d1+lenff+d2);
                [w03,theta03,L03]=fLRMm(w0F3,theta0F3,L0F3,lambda,MBack3,0,dcM+d1+lenff+d2+lenF3);
                [w04,theta04,L04]=fLRMm(w03,theta03,L03,lambda,Mff,lenff,dcM+d1+lenff+d2+lenF3+d2);
                w02_z=fwz(w02,theta02,L02,z);
                w0F3_z=fwz(w0F3,theta0F3,L0F3,z);
                w03_z=fwz(w03,theta03,L03,z);
                w04_z=fwz(w04,theta04,L04,z);
                fplot(w01_z,[0,dcM+d1]);
                fplot(w02_z,[dcM+d1+lenff,dcM+d1+lenff+d2]);
                fplot(w0F3_z,[dcM+d1+lenff+d2,dcM+d1+lenff+d2+lenF3]);
                fplot(w03_z,[dcM+d1+lenff+d2+lenF3,dcM+d1+lenff+d2+lenF3+d2+1]);
                xline(dcM);
                xline(dcM+d1+lenff+d2+lenF3+d2);
                rectangle('Position',[(dcM+d1+lenff+d2),0,lenF3,w0F3d2])
            end
        end
    end


end
toc
ParaSet=double(ParaSet);







%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日