clc;clear;
%% ����������
grav=[0 0 -10];
%% ����rigid transform
RotAngle=180;%Ĭ����+y
%% ����prismatic joint
Zr=10;%����equilibrium position��̬λ��\����ԭ��\δ����ʱ�ĳ���,UnitsĬ��Ϊcm
K=20;%spring stiffness����ϵ����UnitsĬ��ΪN/m
C=0.1;%damping coefficient����ϵ����UnitsĬ��ΪN/(m/s)
Z0=17.5;%��ʼλ�ã�UnitsĬ��Ϊcm
%% ����brick solid
Dimension=[1 2 3];%brick solid�ļ��β�����UnitsĬ��Ϊcm
M=.15;%brick solid��������UnitsĬ��Ϊkg
Color=[1 1 1];%������
%% ����ģ�Ͳ���������Ľṹ����Ϣ
simOut=sim('Task2_Hanging_Vibrating_Mass.slx');