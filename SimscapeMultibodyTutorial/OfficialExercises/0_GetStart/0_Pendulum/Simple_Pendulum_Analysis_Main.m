%% 1.Analyze Undamped Pendulum
%% 设置初始位置为0deg，不设置设置Internal Mechanics > Damping
%% 按照时序画位置曲线，速度曲线
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity

%% 画位置与速度之间的关系
figure
hold on
plot(out.q.data, out.w.data);
%% 将多角度的图2画在一张图上了:-80，-40、0、40和80度






%% 2.Analyze Damped Pendulum
%% 设置初始位置为0deg，Internal Mechanics > Damping to 8e-5 (N*m)/(deg/s)
%% 按照时序画位置曲线，速度曲线
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity
%% 画位置与速度之间的关系
figure
hold on
plot(out.q.data, out.w.data);
%% 将多角度的图2画在一张图上了:-240，-180，-120，-60、0和60度






%% 3.Analyze Damped and Driven Pendulum
%% 设置Actuation > Torque to Provided by Input,增加内部驱动,设置初始位置为0deg
%添加sine block.Amplitude =0.06,S-PS转化换，单位1或m^2*kg/s^2
%% 按照时序画位置曲线，速度曲线
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity

%% 画位置与速度之间的关系
figure
hold on
plot(out.q.data, out.w.data);


