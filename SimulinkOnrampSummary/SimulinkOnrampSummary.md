<center><b><font color="b" size="7">Simulink Onramp Summary</font></b></center>

# Simulink中如何保存高清图片

## 1 拷贝视图

<img src="SimulinkOnrampSummary.assets/copy-figure.png" alt="copy-figure" style="zoom: 80%;" />

视觉上看metafile在word中更清晰

## 2 使用saveas函数保存

```matlab
help saveas查看可存格式的后缀名
saveas - 将图窗保存为特定文件格式
    此 MATLAB 函数 将 fig 指定的图窗或 Simulink 模块图保存到 filename 文件中。将文件名指定为字符向量或字符串，包括文件扩展名，例如
    'myplot.jpg'。文件扩展名用于定义文件格式。如果不指定扩展名，则 saveas 会将图窗保存为 FIG 文件。要保存当前图窗，请将 fig 指定为 gcf。

    saveas(fig,filename)
    saveas(fig,filename,formattype)
    saveas(get_param(gcs,'handle'),'task1','emf');%获取当前simulink
    saveas(gcf,'Barchart.png');%获取当前图窗
```

```matlab
%% 用批量保存多种格式的图片,其中emf比较高清
format={'jpg','png','bmp','emf','pbm','pgm','ppm','tiff','pdf'};%多种目标格式
name='demo';
for i=1:length(format)
    saveas(get_param(gcs,'handle'),name,format(i));
end
```

| 扩展名 | 生成的格式                                                   |
| :----- | :----------------------------------------------------------- |
| `.fig` | MATLAB® FIG 文件（对 Simulink 模块图无效）                   |
| `.m`   | 可以打开图窗的 MATLAB FIG 文件和 MATLAB 代码 （对于 Simulink 模块图无效） |
| `.jpg` | JPEG 图像                                                    |
| `.png` | 可移植网络图形                                               |
| `.eps` | EPS 3 级黑白                                                 |
| `.pdf` | 可移植文档格式                                               |
| `.bmp` | Windows® 位图                                                |
| `.emf` | 增强的图元文件                                               |
| `.pbm` | 可移植位图                                                   |
| `.pcx` | Paintbrush 24-bit                                            |
| `.pgm` | 可移植灰度图                                                 |
| `.ppm` | 可移植像素图                                                 |
| `.tif` | TIFF 图像，已压缩                                            |

## 3 使用print函数-需要打开待打印的模型

```matlab
help print
print - 打印图窗或保存为特定文件格式

    此 MATLAB 函数 使用指定的文件格式将当前图窗保存到文件中，例如 print('BarPlot','-dpng')。如果该文件不包括扩展名，则 print会附加适用的扩展名。
    print(filename,formattype)
    print -s文件名 -d格式名 另存的文件名
    print -stask1 -dmeta demo
```

# Sample time采样时间

ODE:(Ordinary Differential Equations)常微分方程;

右键查看模型的中所有的sample time-All

<img src="SimulinkOnrampSummary.assets/sample-time-display.png" alt="sample-time-display" style="zoom:67%;" />

[采样时间的类型](https://ww2.mathworks.cn/help/simulink/ug/types-of-sample-time.html)、[指定采样时间](https://ww2.mathworks.cn/help/simulink/ug/how-to-specify-the-sample-time.html)、[系统中的采样时间](https://ww2.mathworks.cn/help/simulink/ug/managing-sample-times-in-systems.html)、[求解器](https://ww2.mathworks.cn/help/simulink/ug/solvers.html#f7-14212)

sample time=0或者[0,0]代表连续采样时间

sample time=-1或者[-1,0]代表继承

sample time=[0,1]代表固定子步数

sample time=[inf,0]或者[inf]代表固定采样时间

离散采样时间，向量为[ Ts, To]，其中 `Ts` 是采样期间，`To` 是初始时间偏移量

| 采样时间类型 | 采样时间                            | 颜色                                                   | 注释                            | 显式 |
| :----------- | :---------------------------------- | :----------------------------------------------------- | :------------------------------ | :--- |
| 离散         | [Ts, To]                            | 按速度降序排列：红色、绿色、蓝色、浅蓝色、深绿色、橙色 | D1、D2、D3、D4、D5、D6、D7...Di | 是   |
| 连续         | [0, 0]                              | 黑色                                                   | Cont                            | 是   |
| 固定子步     | [0, 1]                              | 灰色                                                   | FiM                             | 是   |
| 继承         | [–1, 0]                             | 不适用                                                 | 不适用                          | 是   |
| 固定         | [Inf, 0]                            | 品红色                                                 | Inf                             | 是   |
| 可变         | [–2,Tvo]                            | 棕色                                                   | V1、V2...Vi                     | 否   |
| 可控制       | [base, -2i]，i = 0、1、2…           | 棕色                                                   | Ctrl1、Ctrl2、Ctrl3…Ctrli       | 是   |
| 混合         | 不适用                              | 黄色                                                   | 不适用                          | 否   |
| 触发         | Source: D1、Source:D2、...Source:Di | 青蓝色                                                 | T1、T2...Ti                     | 否   |
| 异步         | [–1, –n]                            | 紫色                                                   | A1、A2...Ai                     | 否   |
| 数据流       | 不适用                              | 浅紫色                                                 | 不适用                          | 否   |

<img src="SimulinkOnrampSummary.assets/Hybrid-system.png" alt="Hybrid-system" style="zoom:33%;" />

# Simulink onramp

## Task1 重力与空气阻力的平衡

<img src="SimulinkOnrampSummary.assets/Task1.png" alt="Task1" style="zoom:67%;" />

zoom：滚轮

pan平移：按住滚轮或者空格+drag

Fit diagram(图)to screen:空格

## Task2 PI控制下的单位阶跃响应

双击信号时如果可以追溯到名字，则显示，否则需要重新命名

单位阶跃信号下的![step_signal](https://matlabacademy-content.mathworks.com/4.12.4/simulinkR2019b/content/Simulink/Blocks%20and%20Signals/Identifying%20Blocks%20and%20Signals/images/unit_step.png)

![Task2](SimulinkOnrampSummary.assets/Task2.png)

## Task3 Low-pass filter低通滤波器

![Task3](SimulinkOnrampSummary.assets/Task3.png)

## Task4 数学计算模块Math Operation-37个

![Task4](SimulinkOnrampSummary.assets/Task4.png)

## Task5 逻辑操作与位操作模块logic and bit operation-19个

![Task5](SimulinkOnrampSummary.assets/Task5.png)

## Task6 信号路由模块signal routing-28个

![Task6](SimulinkOnrampSummary.assets/Task6.png)

## Task7 构建时序组合信号

![Task7](SimulinkOnrampSummary.assets/Task7.png)

## Task8 Automotive Performance Package

- 汽车性能套件
- signal editor 仅仅是一个自定义（可定义多种场景）的信号模块，跟sine wave\ramp一样

![Task8](SimulinkOnrampSummary.assets/Task8.png)

## Task9 参数化编程

![Task9](SimulinkOnrampSummary.assets/Task9.png)

model workspace是模型工作空间，仅仅对单个模型有用，在model explorer里面更改变量，对象等

base workspace是基本工具空间，里面的变量可以再多个模型间调用

## Task10 User-define Functions-14个

- Matlab function(用户定义的函数)

![Task10](SimulinkOnrampSummary.assets/Task10.png)

## Task11 系统的动力学方程

<img src="SimulinkOnrampSummary.assets/Task11.png" alt="Task11" style="zoom:67%;" />

##   Task12 Discrete模块-21个,u输入,积分是Z^-1^

<img src="SimulinkOnrampSummary.assets/Task12-1.png" alt="Task12-1" style="zoom:50%;" />UnitDelay:采样并保持一个采样周期的延迟。

<img src="SimulinkOnrampSummary.assets/Task12-2.png" alt="Task12-2" style="zoom:67%;" />

## Task13 离散系统的建立

- 车的位置基于上一次的位置和当前速度

<img src="SimulinkOnrampSummary.assets/Task13-1.png" alt="Task13-1" style="zoom:50%;" />

<img src="SimulinkOnrampSummary.assets/Task13-2.png" alt="Task13-2" style="zoom:80%;" />

### 离散系统的总结

> 假设模型如下：
>
> *x*[*k*]−*x*[*k*−1]=*u*[*k*]−*u*[*k*−1]
>
> *u*[*k*]=sin[*k*]

#### Step1 将当前状态保留在等号左边，其余在右边

<img src="SimulinkOnrampSummary.assets/Task13-summary-1.png" alt="Task13-summary-1" style="zoom:67%;" />

#### Step2 根据变量的k和k-1决定需要几个UnitDelay,本模型需要2个

<img src="SimulinkOnrampSummary.assets/Task13-summary-2.png" alt="Task13-summary-2" style="zoom: 67%;" />

#### Step3 添加UnitDelay模块，并标记好信号(为了更清晰)

<img src="SimulinkOnrampSummary.assets/Task13-summary-3.png" alt="Task13-summary-3" style="zoom:67%;" />

#### Step4 按照等式右边构建模型

<img src="SimulinkOnrampSummary.assets/Task13-summary-4.png" alt="Task13-summary-4" style="zoom:67%;" />

#### Step5连接剩余信号以保证模型的等号性

<img src="SimulinkOnrampSummary.assets/Task13-summary-5.png" alt="Task13-summary-5" style="zoom:67%;" />

#### Step6按条件设置所有UnitDelay模块的采样时间和初始值

<img src="SimulinkOnrampSummary.assets/Task13-summary-6.png" alt="Task13-summary-6" style="zoom:67%;" />

## Task14  Continuous模块-14个，u输入,积分是s^-1^

<img src="SimulinkOnrampSummary.assets/Task14-1.png" alt="Task14-1" style="zoom:67%;" />

<img src="SimulinkOnrampSummary.assets/Task14-2.png" alt="Task14-2" style="zoom:67%;" />

  一些连续系统的建模实例，你可以建立带有 many degrees-of-freedom(多自由度)的模型, like this [half-car suspension model](matlab:web(fullfile(docroot, 'simulink/slref/automotive-suspension.html'))), or non-linear systems, such as this [friction model with hard stops](matlab:web(fullfile(docroot, 'simulink/slref/friction-model-with-hard-stops.html'))).

### 连续系统的总结

- 建立连续系统的步骤与离散系统相似

> 假设模型如下：
>
> ![Task14-summary-0](SimulinkOnrampSummary.assets/Task14-summary-0.png)

#### Step1 将最高级的微分放在等式左边，其余放在右边

<img src="SimulinkOnrampSummary.assets/Task14-summary-1.png" alt="Task14-summary-1" style="zoom:67%;" />

#### Step2 根据微分之间的关系确定积分符号，这里有两个积分

<img src="SimulinkOnrampSummary.assets/Task14-summary-2.png" alt="Task14-summary-2" style="zoom:67%;" />

#### Step3 添加Integrator模块，并标记信号(为了更清晰)

<img src="SimulinkOnrampSummary.assets/Task14-summary-3.png" alt="Task14-summary-3" style="zoom:67%;" />

#### Step4 按照等式右边构建模型

<img src="SimulinkOnrampSummary.assets/Task14-summary-4.png" alt="Task14-summary-4" style="zoom:67%;" />

#### Step5 连接剩余信号以保证模型的等号性

<img src="SimulinkOnrampSummary.assets/Task14-summary-5.png" alt="Task14-summary-5" style="zoom:67%;" />

#### Step6 按条件设置所有Integrator模块的采样时间和初始值

<img src="SimulinkOnrampSummary.assets/Task14-summary-6.png" alt="Task14-summary-6" style="zoom:67%;" />

## Task15 仿真时间和仿真步长的设置

###  Simulation duration仿真时间:t~stop~

### Automatic step size selection:最大时间步长![Task15-1](SimulinkOnrampSummary.assets/Task15-1.png)

 Step size, along with other solver settings, can also be configured manually. For more information, see [Choose a Solver](https://www.mathworks.com/help/simulink/ug/choose-a-solver.html).可变步长求解器更适合于纯连续模型，例如质量弹簧阻尼器系统的动力学。对于包含多个开关的模型，建议使用固定步长求解器，例如逆变器电源系统，这是因为求解器重置的次数会导致可变步长求解器的行为类似于固定步长求解器。

![Task15-2](SimulinkOnrampSummary.assets/Task15-2.png)

当出现锯齿状时用手动设置为固定步长，再对固定步长的值进行设置。	

![Task15-3](SimulinkOnrampSummary.assets/Task15-3.png)

## Task16 Thermostat Model:温控器模型PIcontrol(离散)

### Step1 PI控制器测量误差，并基于误差输出控制信号

<img src="SimulinkOnrampSummary.assets/Task16-1.png" alt="Task16-1" style="zoom:67%;" />

### Step2 一个简单的控制策略，当温度很低时火炉on，当温度很高时火炉off

<img src="SimulinkOnrampSummary.assets/Task16-2.png" alt="Task16-2" style="zoom:67%;" />

### Step3 根据以上控制策略得到结果:具备适当的平均温度，但是波动很大

<img src="SimulinkOnrampSummary.assets/Task16-3.png" alt="Task16-3" style="zoom:67%;" />

### Step4 更改控制策略:将控制器的输出控制为误差的比例，例:当误差很低时，几乎不需要什么热量；当误差很大时,则heater处于最大功率

<img src="SimulinkOnrampSummary.assets/Task16-4.png" alt="Task16-4" style="zoom:67%;" />

### Step5 仅有比例控制会存在稳态误差,故加入累计误差的影响,即积分环节

<img src="SimulinkOnrampSummary.assets/Task16-5.png" alt="Task16-5" style="zoom:67%;" />

### Step6 考虑当前误差和累计误差的控制器称为PI控制器

<img src="SimulinkOnrampSummary.assets/Task16-6.png" alt="Task16-6" style="zoom:67%;" />

### Step7 本项目你将建立PI离散控制器

<img src="SimulinkOnrampSummary.assets/Task16-7-1.png" alt="Task16-7-1" style="zoom:67%;" />

$$\text{Proportional-integral control:}\\
y[k] = y_p[k] + y_i[k], \text{where:}y_p[k] = K_pe[k],\ 
y_i[k] = K_iT_se[k] + y_i[k-1]$$

![Task16-7-2](SimulinkOnrampSummary.assets/Task16-7-2.png)

Simulink also ships with prebuilt controller blocks. You can read about [PID controllers and discrete PID controllers](matlab:web(fullfile(docroot, 'simulink/slref/pidcontroller.html'))

## Task17 Peregrine Falcon Dive:猎鹰潜水捕食(连续)

<img src="SimulinkOnrampSummary.assets/Task17-1.png" alt="Task17-1" style="zoom:67%;" />

猎鹰捕食时受重力和空气阻力，运动方程如下图中的step1,最高速度可达350km/h，当它接近地面时，它会改变机翼的角度，增加阻力，从而迅速减速到安全的着陆速度。该项目分为两部分，先对固定的阻力参数进行建模，再对机翼开口安全着陆进行建模。

![Task17-2](SimulinkOnrampSummary.assets/Task17-2.png)

右键可以重构，ctrl+i用于模块镜像，ctrl+R用于旋转

<img src="SimulinkOnrampSummary.assets/Task17-3.png" alt="Task17-3" style="zoom:67%;" />

# Resources其余资源

#### MathWorks Training

[My Courses](https://matlabacademy.mathworks.com/):可以查看免费的官方教程

[Instructor-led courses](https://www.mathworks.com/services/training/courses.html#simulink):查看官方提供的所有适用课程，了解培训形式以及适合的课程

#### Simulink Resources

[Simulink Getting Started Guide](https://www.mathworks.com/help/simulink/getting-started-with-simulink.html)- A set of tutorials that continue into more advanced topics such as model hierarchy and design principles. 

[Getting Started with Simulink](https://www.mathworks.com/products/simulink/getting-started.html)

[MathWorks examples]([https://www.mathworks.com/help/simulink/examples.html?s_tid=CRUX_lftnav_example_%5Bobject+Object%5D&category=index](https://www.mathworks.com/help/simulink/examples.html?s_tid=CRUX_lftnav_example_[object+Object]&category=index))- Documentation page containing example models, grouped by application. 

#### Additional Capabilities

[Stateflow Product Page](https://www.mathworks.com/products/stateflow.html)- Stateflow is an environment that can be used within Simulink to model logic systems and state machines. 

[Model-Based Design](https://www.mathworks.com/solutions/model-based-design.html)- Learn about the tools available to implement model-based design in Simulink. 

