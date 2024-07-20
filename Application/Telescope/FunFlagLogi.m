

function FlagLogi=FunFlagLogi(w01m,theta01m,L01m,lambda,MF01,MF02,dcM,lenF,lenL,...
    A,deltaA,B,deltaB,C,D,deltaD,wMin,CubeColor)
syms z;
% 传输
[w02m,theta02m,L02m]=fLRMm(w01m,theta01m,L01m,lambda,MF01,lenF,dcM);
w02m_z=fwz(w02m,theta02m,L02m,z);
win=double(subs(w02m_z,z,dcM+lenF));
wout=double(subs(w02m_z,z,dcM+lenF+lenL));
logiOmigaoutin=( logical((D-deltaD)*win < wout) &&  logical((D+deltaD)*win > wout ));
%% 判断
if logiOmigaoutin
    % 传输
    [w03m,theta03m,L03m]=fLRMm(w02m,theta02m,L02m,lambda,MF02,lenF,dcM+lenF+lenL);
    logiOmiga=( logical((A-deltaA)*w01m < w03m) &&  logical((A+deltaA)*w01m > w03m ));
    if logiOmiga
        logiTheta=( logical((B-deltaB)*theta01m < theta03m) &&  logical((B+deltaB)*theta01m > theta03m ));
        if logiTheta
            logiLoc=( logical(L03m > (dcM+lenF+lenL+lenF))  &&  logical(abs(L03m-(dcM+lenF+lenL+lenF)) < C*w03m/theta03m  ));
            if logiLoc
                logiwmin=Funlogiwmin(w01m,theta01m,L01m, w02m,theta02m,L02m,...
                    w03m,theta03m,L03m, dcM,lenF,lenL,wMin,C);
                if logiwmin
                    %
                    figw=gcf;
                    figure(figw.Number);
                    fplot(w02m_z,[dcM+lenF,dcM+lenF+lenL],Color=CubeColor);
                    L1=dcM+lenF+lenL+lenF;
                    L2=double(dcM+lenF+lenL+lenF+C*w03m/theta03m);
                    w03m_z=fwz(w03m,theta03m,L03m,z);
                    fplot(w03m_z,[L1,L2],Color=CubeColor);
                    %
                    FlagLogi=1;
                    return;
                end
                FlagLogi=0;
                return;
            end
            FlagLogi=0;
            return;
        end
        FlagLogi=0;
        return;
    end
    FlagLogi=0;
    return;
else
    FlagLogi=0;
end
% clc

end




%%
function logiwmin=Funlogiwmin(w01m,theta01m,L01m, w02m,theta02m,L02m,...
    w03m,theta03m,L03m, dcM,lenF,lenL,wMin,C)

syms z;
w01m_z=fwz(w01m,theta01m,L01m,z);
assume(z>(dcM-w01m/theta01m) & z<dcM)
Flogi01=isAlways(w01m_z> wMin);
if Flogi01
    w02m_z=fwz(w02m,theta02m,L02m,z);
    assume(z>(dcM+lenF) & z<(dcM+lenF+lenL))
    Flogi02=isAlways(w02m_z> wMin);
    if  Flogi02
        w03m_z=fwz(w03m,theta03m,L03m,z);
        assume(z>(dcM+lenF+lenL+lenF) & z<(dcM+lenF+lenL+lenF + C*w03m/theta03m))
        Flogi03=isAlways(w03m_z> wMin);
        if  Flogi03
            logiwmin=1;
            return;
        end
        logiwmin=0;
        return;
    end
    logiwmin=0;
    return;
else
    logiwmin=0;
end


end


%% 版本信息
% 作者:                Quincy Howard
% 联系方式：           quincy.hd@qq.com
% 文件信息更新平台为   matlab云文件、GitHub、CSDN博客、知乎
% 若使用请注明来源
% 最后编辑于           2024 年 07 月 10 日