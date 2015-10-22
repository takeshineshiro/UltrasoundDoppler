%% Import
%load('andi.mat');
raw_data = LTspice2Matlab('Draft1.RAW');
u_in = raw_data.variable_mat(2,:);
i_rm = raw_data.variable_mat(16,:);%9
f = raw_data.freq_vect;
 %a = value >= -50;

%% plot resistance and angle
figure('Name','Impedanceverlauf','NumberTitle','off');
r = u_in./i_rm; % elementwise 
ang = angle(u_in(1:end-1).*conj(i_rm(2:end)))/(2*pi)*360;
[hAx,hLine1,hLine2]= plotyy(f,abs(r),f(1:end-1),ang);
hLine2.LineStyle = '--';
title('impedance-diagram 2 MHz crystal with 2 x 2.7 µH inductance'); %
xlabel('frequency [Hz]')
ylabel(hAx(1),'resistance [Ohm]') % left y-axis
ylabel(hAx(2),'angle [°]') % right y-axis
hAx(2).YTick = -90:10:60;
hAx(2).YLim = [-90 60];
hAx(1).YTick = 0:20:260;
hAx(1).YLim = [0 260];
% Create title
