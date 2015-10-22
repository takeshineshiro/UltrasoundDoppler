%% import
m1 = importDAT2('D:\OneDrive\HS-USD\Messungen Analyzer\analyzer daten\File_002.DAT');

%%
% values in dB
thresholdDB = -67;
temp = (m1.value>thresholdDB);
value2 = temp.*m1.value;
value2(value2==0)=[];
freq2 = m1.freq(temp~=0);
close all;
figure;
hold on;
grid on;
plot(m1.freq, m1.value,'b');
plot(freq2,value2,'LineStyle','none','Marker','x','Color','r', 'linewidth', 2.0);
xlabel('Frequency');
ylabel('Amplitude');
ylim([-90 -20]);
set(gca, 'XTicklabel', num2str(get(gca, 'XTick')/1000000', '%d MHz\n'));
set(gca, 'YTicklabel', num2str(get(gca, 'YTick')', '%d dBm\n'));
textStart = 12*10e7;
for iter=21:length(freq2)
    str1=sprintf([num2str(value2(iter), '%2.2f'), ' dBm @']); 
    str2=sprintf([num2str(freq2(iter)/1000000, '%.2f\n'), ' MHz']); 
    text(freq2(iter),value2(iter),num2str(iter),'Color','r','FontSize',14,...
    'HorizontalAlignment','center','VerticalAlignment','Bottom'); 

    text(textStart,-23-4.5*(length(freq2)-iter),[num2str(iter) ': '],'Color','r','FontSize',14,...
    'HorizontalAlignment','right','VerticalAlignment','Bottom'); 

    text(textStart,-23-4.5*(length(freq2)-iter),[str1 str2],'Color','r','FontSize',14,...
    'HorizontalAlignment','left','VerticalAlignment','Bottom'); 
    
    %text(8.2*10e7,-20-6*iter,,'Color','r','FontSize',14,...
    %'HorizontalAlignment','right','VerticalAlignment','Bottom'); 
end