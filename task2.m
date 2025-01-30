clc
clear all
close all

%% Параметры
fs = 44100; % Частота дискретизации
t = 10; % Длительность в секундах
num_samples = round(t * fs); % Общее количество сэмплов
out_signal = zeros(num_samples, 1); % выходной сигнал

%%Запрос у пользователя частоты и коэфициента затухания
alfa = input ('Введите коэфициент затухания:'); % Коэффициент затухания
f = input('Введите частоту в Гц :'); % Частота

%% Генерация звука

delay = round(fs / f); % задержка

tv = 0:(1/fs):t; % временной вектор с шагом 
x = sin(2*pi*f*tv); % сигнал

x((delay+1):end) = 0;


for n = 1:num_samples
    
    % Уравнение описывающее алгоритм Карплуса-Стронга

    if n > delay
        out_signal(n) = x(n) + alfa*out_signal(n - delay);
    else
        out_signal(n) = x(n);
    end
end

% Нормализация выходного сигнала
out_signal = out_signal / max(abs(out_signal));

% Запись в файл .wav
audiowrite('output.wav', out_signal, fs);