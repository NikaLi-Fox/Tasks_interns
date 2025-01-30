clear
clc
close all

%% Координаты постов (в метрах)

% Пост один
x1 = 5000; 
y1 = 6000;

%Пост два
x2 = 1000; 
y2 = 1000;

%Пост три
x3 = 9000; 
y3 = 1000;

%% Разность хода в микросекундах (в секундах)

dt12 = 1.47e-6; 
dt13 = -13.4e-6; 

c = 3e8; 

%% Растояние в метрах

dd12 = c * dt12; 
dd13 = c * dt13; 

%% Система уравнений

syms x y % х у координаты ИРИ

d1 = sqrt((x - x1)^2 + (y - y1)^2);
d2 = sqrt((x - x2)^2 + (y - y2)^2);
d3 = sqrt((x - x3)^2 + (y - y3)^2);

eq1 = d1 - d2 == dd12;
eq2 = d1 - d3 == dd13;

s = solve([eq1, eq2], [x, y]);

%% Получение значений

xx = double(s.x);
yy = double(s.y);

fprintf('Координаты источника радиоизлучения (ИРИ):\n');
fprintf('x: %.2f м\n', xx);
fprintf('y: %.2f м\n', yy);

%% Визуализация

figure;hold on; grid minor; xlabel("X"); ylabel("Y")

plot(x1, y1, ".", "Color","green","MarkerSize",15); 
plot(x2, y2, ".", "Color","green", "MarkerSize",15); 
plot(x3, y3, ".", "Color","green","MarkerSize",15);

plot(xx, yy, "*", "Color","cyan","MarkerSize",15);