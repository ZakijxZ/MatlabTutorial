%% clear up
clc;clear;
clearvars;close all;
%% ����һЩ����
% ��������
grav='[0 0 -10]';% gravity vector (m/s^2)
% prismatic joint�Ĳ���
Z0='14.75';%initial position of mass,��ʼλ��(cm)
Zr='10';%equilibrium position��̬λ��\����ԭ��\δ����ʱ�ĳ���,UnitsĬ��Ϊcm
K='20';%spring stiffness����ϵ����UnitsĬ��ΪN/m
C='0.5';%damping coefficient����ϵ����UnitsĬ��ΪN/(m/s)
% brick solid�Ĳ���
Dimension='[1 2 3]';%brick solid�ļ��β�����UnitsĬ��Ϊcm
M='.15';%brick solid��������UnitsĬ��Ϊkg
% Color='[1 1 1]';%������
Color='[0.5 0.5 1]';
%% ����rigid transform������rot��������Ӧ���ַ���ģʽ
baseAxis='+Y';%���ĸ���rot
hanging='180';%rigid transform rotational angle(deg)
horizontal='90';%rigid transform rotational angle(deg)
inclined='120';%rigid transform rotational angle(deg)
%% ǩ��������simulinkģ��,ǩ��������Ҫ��simulinkģ��
% ǩ��������
set_param('Task3_Inclining_Vibrating_Mass/Mechanism Configuration',...  
            'GravityVector',grav);
% ǩ��rigid transform��rotģʽ
set_param('Task3_Inclining_Vibrating_Mass/Rigid Transform',...
            'RotationStandardAxis',baseAxis);
set_param('Task3_Inclining_Vibrating_Mass/Rigid Transform',...
            'RotationAngle',inclined);
% ǩ��prismatic joint�Ĳ���
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'PositionTargetValue',Z0);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'EquilibriumPosition',Zr);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'SpringStiffness',K);
set_param('Task3_Inclining_Vibrating_Mass/spring_1',...
            'DampingCoefficient',C);
% ǩ��brick solid�Ĳ���
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'BrickDimensions',Dimension);
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'Mass',M);
set_param('Task3_Inclining_Vibrating_Mass/Brick Solid',...
            'GraphicDiffuseColor',Color);
%% ����
simOut=sim('Task3_Inclining_Vibrating_Mass');
