%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\workspace\LTspice\2 MHz - Rx IN.CSV
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/10/13 11:44:16

%% Initialize variables.
filename = 'D:\workspace\LTspice\3V3D-off.CSV';
delimiter = ',';
startRow = 3;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
timeins = dataArray{:, 1};
CH1 = dataArray{:, 2};

%% Time specifications:
Fs = 350*10^6;              % samples per second
N = length(CH1);

%% Fourier Transform:
X = fftshift(fft(CH1));
%% Frequency specifications:
dF = Fs/N;                      % hertz
f = -Fs/2:dF:Fs/2-dF;           % hertz

amplitude = 20*log10(abs(X)/N);
size = N/2;
%% Plot the spectrum:
figure;
%plot(f,amplitude);
plot(f(size:end-1),amplitude(size:end-1));
xlim([0.0 180000000]);
set(gca, 'XTicklabel', num2str(get(gca, 'XTick')/1000000', '%d MHz\n'));
%set(gca, 'YTicklabel', num2str(get(gca, 'YTick')', '%d dBm\n'));
xlabel('Frequency');
title('Magnitude Response');

%% Plot graph
figure;
plot(timeins,CH1)

ylabel('Amplitude');
%ylim([-6 6]);
ylim([-0.02 0.02]);
xlim([-0.00000025 0.0000003]);
set(gca, 'XTicklabel', num2str(get(gca, 'XTick')*1000000', '%2.2f �s\n'));
set(gca, 'YTicklabel', num2str(get(gca, 'YTick')*1000', '%1.2f mV\n'));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;