function Test_SNR( filename )
clc;
close all;
y = read(filename);

%% fft params
Fs = 64e6;
NFFT = 512;

%% perform
filtered = perfect(y);
snr(filtered.data, Fs);

figure;
snr(y, Fs);
figure;
sfdr(y, Fs);

data = fft(y, NFFT)/NFFT;
sorted_data = sort(abs(data(2:NFFT/2+2)), 'descend');

fundamental = sum(sorted_data(min(1,3)));
noise = sum(sorted_data(4:NFFT/2+1)) - fundamental;
SNR = 20*log10(fundamental/sqrt(noise));
f = Fs/2*linspace(0,1,NFFT/2+1);
dbs = 20*log10(abs(data(1:NFFT/2+1)));

figure;plot(y)

figure;plot(f, dbs)
str=sprintf('Single-Sided Amplitude Spectrum of Data \n SNR = %g\n fundamental = %g\n noise = %g', SNR, 20*log10(fundamental), 20*log10(noise));
title(str);
xlabel('Frequency in Hz');
ylabel('|data(f)|');


end

function read = read(filename)

delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');
%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
%% Close the text file.
fclose(fileID);

out = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

read = out(:,2);

end