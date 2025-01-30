clear
clc
close all

%% Заданные параметры

de = 20.4e-2; % расстояние между ушами
c = 340.29; % скорость звука м/с

%% Параметры

ds = 2; % расстояние до источника в метрах
rs = 0.1; % радиальная скорость в м/с
fd = 44100; % частота дискретизации (сэмплирования) в Гц
t = 10; % длительность звука в секундах
fs = 500; % частота звука в Гц 
tv = 0:(1/fd):t; % временной вектор с шагом 
theta = 2*pi*rs*tv/ds; % углы прихода сигнала 
s = sin(2*pi*fs*tv); % сигнал
out_signal = zeros(length(tv),2);

for i = 1:length(tv)
    itd(i) = (de/2) * sin(theta(i)) / c; % межушная временная разница
    delay(i) = round(itd(i)*fd); % дискретизация временной разности
end

a = (length(tv)-1)/4;
b = 3*a;
i = 1;

while a<b
    signal(i) = s(a) + delay(i);
    a = a+1;
    i = i+1;
end

signal = signal.';

% для правого канала 

r = length(signal)/2;

ch1 = signal(1:r);
ch2 = flip(ch1);

r1 = 1;
c = 2;
out_signal(r1:r1 + size(ch2, 1) - 1, c:c + size(ch2, 2) - 1) = ch2;

out_signal(r:r + size(ch1, 1) - 1, c:c + size(ch1, 2) - 1) = ch1;

rr = length(signal);
ch3 = signal(r:length(signal));
ch4 = flip(ch3);

r3 = r*2;
r4 = r*3;

out_signal(r3:r3 + size(ch3, 1) - 1, c:c + size(ch3, 2) - 1) = ch3;

out_signal(r4:r4 + size(ch4, 1) - 1, c:c + size(ch4, 2) - 1) = ch4;

% для левого канала

out_signal(:,1) = flip(out_signal(:,2));


out_signal = out_signal / (max(abs(out_signal(:)))); % нормировка

audiowrite ('sound.wav',out_signal,fd);