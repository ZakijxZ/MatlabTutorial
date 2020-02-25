%% clear up
clc;clear;
clearvars;close all;
%% 声明一些参数
% 重力参数
grav='[0 0 -10]';% gravity vector (m/s^2)
% prismatic joint的参数
Z0='14.75';%initial position of mass,初始位置(cm)
Zr='10';%equilibrium position静态位置\弹簧原长\未拉伸时的长度,Units默认为cm
K='20';%spring stiffness弹性系数，Units默认为N/m
C='0.5';%damping coefficient阻尼系数，Units默认为N/(m/s)
% brick solid的参数
Dimension='[1 2 3]';%brick solid的几何参数，Units默认为cm
M='.15';%brick solid的质量，Units默认为kg
% Color='[1 1 1]';%无量纲
Color='[0.5 0.5 1]';
%% 定义rigid transform的三种rot参数，对应三种仿真模式
baseAxis='+Y';%绕哪个轴rot
hanging='180';%rigid transform rotational angle(deg)
horizontal='90';%rigid transform rotational angle(deg)
inclined='120';%rigid transform rotational angle(deg)
%% 签订参数到simulink模型,签订过程需要打开simulink模型
% 签订重力场
set_param('Task3_Inclining_Vibrating_Mass/Mechanism Configuration',...  
            'GravityVector',grav);
% 签订rigid transform的rot模式
set_param('Task3_Inclining_Vibrating_Mass/Rigid Transform',...
            'RotationStandardAxis',baseAxis);
set_param('Task3_Inclining_Vibrating_Mass/Rigid Transform',...
            'RotationAngle',inclined);
% 签订prismatic joint的参数
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'PositionTargetValue',Z0);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'EquilibriumPosition',Zr);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'SpringStiffness',K);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'DampingCoefficient',C);
% 签订brick solid的参数
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'BrickDimensions',Dimension);
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'Mass',M);
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'GraphicDiffuseColor',Color);
%% 仿真
simOut=sim('Task3_Inclining_Vibrating_Mass');
