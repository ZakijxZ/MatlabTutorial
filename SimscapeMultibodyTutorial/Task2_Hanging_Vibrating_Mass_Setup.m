clc;clear;
%% 设置重力场
grav=[0 0 -10];
%% 设置rigid transform
RotAngle=180;%默认绕+y
%% 设置prismatic joint
Zr=10;%设置equilibrium position静态位置\弹簧原长\未拉伸时的长度,Units默认为cm
K=20;%spring stiffness弹性系数，Units默认为N/m
C=0.1;%damping coefficient阻尼系数，Units默认为N/(m/s)
Z0=17.5;%初始位置，Units默认为cm
%% 设置brick solid
Dimension=[1 2 3];%brick solid的几何参数，Units默认为cm
M=.15;%brick solid的质量，Units默认为kg
Color=[1 1 1];%无量纲
%% 运行模型并保存输出的结构体信息
simOut=sim('Task2_Hanging_Vibrating_Mass.slx');