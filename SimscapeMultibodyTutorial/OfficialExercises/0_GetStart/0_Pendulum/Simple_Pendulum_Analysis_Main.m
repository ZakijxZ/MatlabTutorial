%% 1.Analyze Undamped Pendulum
%% ���ó�ʼλ��Ϊ0deg������������Internal Mechanics > Damping
%% ����ʱ��λ�����ߣ��ٶ�����
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity

%% ��λ�����ٶ�֮��Ĺ�ϵ
figure
hold on
plot(out.q.data, out.w.data);
%% ����Ƕȵ�ͼ2����һ��ͼ����:-80��-40��0��40��80��






%% 2.Analyze Damped Pendulum
%% ���ó�ʼλ��Ϊ0deg��Internal Mechanics > Damping to 8e-5 (N*m)/(deg/s)
%% ����ʱ��λ�����ߣ��ٶ�����
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity
%% ��λ�����ٶ�֮��Ĺ�ϵ
figure
hold on
plot(out.q.data, out.w.data);
%% ����Ƕȵ�ͼ2����һ��ͼ����:-240��-180��-120��-60��0��60��






%% 3.Analyze Damped and Driven Pendulum
%% ����Actuation > Torque to Provided by Input,�����ڲ�����,���ó�ʼλ��Ϊ0deg
%���sine block.Amplitude =0.06,S-PSת��������λ1��m^2*kg/s^2
%% ����ʱ��λ�����ߣ��ٶ�����
close all
figure; % Open a new figure
hold on;
plot(out.q,'r'); % Plot the pendulum angle
plot(out.w,'b'); % Plot the pendulum angular velocity

%% ��λ�����ٶ�֮��Ĺ�ϵ
figure
hold on
plot(out.q.data, out.w.data);


