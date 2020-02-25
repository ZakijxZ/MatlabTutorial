<center><b><font face="微软雅黑体" color="b" size="7">SimMechanics Summary</font></b></center>
> From Gordon Parker from michigan Technology University-共5节课

Introduction to Multibody Simulation

Vehicle Modeling Using Simscape Multibody

# 前言

```matlab
smnew %创建一个新的模板
sm_lib%打开Simscape Multibody块库
```

<img src="SimscapeMultibodySummary.assets/default-config.png" alt="default-config" style="zoom:67%;" />

>以上三个模块是一个物理模型的基本环境，除重力场外一般不用修改

<img src="SimscapeMultibodySummary.assets/world-Frame.png" alt="world-Frame" style="zoom:33%;" />

> 坐标系:默认Z向上，X倒地稍微向右，Solidworks装配的时候最好这样装

# Task 1 Vibrating Mass弹簧阻尼系统

- 水平面horizontal

<img src="SimscapeMultibodySummary.assets/Vibrating Mass.png" alt="Vibrating Mass" style="zoom:67%;" />

## 理论分析

​	<img src="SimscapeMultibodySummary.assets/Vibrating_Mass-1582398015847.png" alt="Vibrating_Mass" style="zoom:67%;" />

## Rigid Transform

- 刚性连接，可以自由组合不同的translational and rotational 变换

## Prismatic Joint

- 棱柱关节,具有一个沿z轴的平移自由度，关节方向由从动框架相对于基础框架的运动定义,类似于与内置的弹簧阻尼元件

- State Targets：指定初始状态
  - specific position ：特定的位置
    - priority：优先级（High(desired) || low(approximate)）
    - value
  - specific velocity：特定速度（与位置相似）
- Internal Mechanics：内部力学参数
  - equilibrium position： 静态位置，即弹簧原长。
  - spring stiffness：弹性系数
  - damping coefficient：阻尼系数

- Limmits
  - Specify low limit：指定下限
  - Specify upper limit：指定上限
- Actuation:激活方式
  - Force：自动计算，provide by input ,None
  - motion:自动计算，provide by input

- sensing:传感器（position\velocity\acceleration\actuator force\lower-limit force\upper-limit force）

- mode configuration:normal\disengaged\provide by input
- composite force/torque sensing:复合力/扭矩感应

## Model

![model-1](SimscapeMultibodySummary.assets/model-1.png)

<img src="SimscapeMultibodySummary.assets/Vibrating_Mass_results.png" alt="Vibrating_Mass_results" style="zoom:67%;" />

# Task2 Hanging Vibrating Mass悬挂弹簧阻尼系统

- vertical-垂直悬挂

## 理论分析

![Hanging Vibrating Mass](SimscapeMultibodySummary.assets/Hanging Vibrating Mass-1.png)

![Hanging Vibrating Mass-2](SimscapeMultibodySummary.assets/Hanging Vibrating Mass-2.png)

>故如果设置初始位置Z0=17.5cm,可以看到小方块基本不运动

## 参数化编程

- 方法一：将每个位置都填成变量，再编写.m空间在`base workspace`里提前生成需要的变量，再运行模型
- 方法二：通过`set_param`去真真切切更改模块的每一个值，然后再用`sim`函数运行模型

## Model

- 这里的参数化编程采用方法一，Ctrl+D：更新三维视图

![Hanging-Vibrating-Mass-Model](SimscapeMultibodySummary.assets/Hanging-Vibrating-Mass-Model.png)

<img src="SimscapeMultibodySummary.assets/Hanging-Vibrating-Mass-Results.png" alt="Hanging-Vibrating-Mass-Results" style="zoom:50%;" />

# Task3 Incline Vibrating Mass倾斜阻尼弹簧系统

- Incine-倾斜，theta

## 理论分析

<img src="SimscapeMultibodySummary.assets/Incline Vibrating Mass-1.png" alt="Incline Vibrating Mass-1" style="zoom:50%;" />

<img src="SimscapeMultibodySummary.assets/Incline Vibrating Mass-2.png" alt="Incline Vibrating Mass-2" style="zoom:50%;" />

- 这里利用参数化方法二:通过`set_param`去真真切切更改模块的每一个值，然后再用`sim`函数运行模型
- 通过`annotation`查看每个模块对应的值

# Task4 Configurating programmatically

- 针对不同的`scenarios`场景（如：horizontal、hanging、inclining）配置参数，用`set_param`函数编写`.m`文件，通过`annotation`去查属性名。
- 建立的模型就是`Task3_Inclining_Vibrating_Mass.slx`，需要运行`Task3_Inclining_Vibrating_Mass_Setup.m`
- 之后可以根据情况将模块进行封装，创建mask

# Task5 Modeling N Vibrating Masses子系统

- External Force and Torque外力或外力矩元件的使用
- 子系统的建立

## 理论分析

![N Vribrating Mass-1](SimscapeMultibodySummary.assets/N-Vribrating-Mass-1.jpg)

![N-Vribrating-Mass-2](SimscapeMultibodySummary.assets/N-Vribrating-Mass-2.jpg)

> 通过以上分析，可以得到N个方程，手写表示会很耗时，同时有错误的可能，故直接到`Simmechics`搭建系统

## Model

![nMass-Model](SimscapeMultibodySummary.assets/nMass-Model.png)

> 可以通过`on/off`分别控制三个`mass`的输入控制，对`pulse`进行更改改变输入力的形式与大小
>
> 这里的`pulse`都是由两个`step`相加构成的

![gity](SimscapeMultibodySummary.assets/gity.gif)

<img src="SimscapeMultibodySummary.assets/nMass-Results.png" alt="nMass-Results" style="zoom:67%;" />

# Task6 Double Pendulum Model双摆

## 理论分析

### 单摆运动

- 假设：忽略杆件的重力，摆球半径为r，质量为m,杆件长为L，theta0=70deg

![Single-Pendulum-Model](SimscapeMultibodySummary.assets/Single-Pendulum-Model.png)

故搭建得到其单摆运动的simulink模型，如下：![Simmulink-model](SimscapeMultibodySummary.assets/Simmulink-model.png)

> 注：sin的计算是用的rad弧度，故初值70deg的设定要转化为rad,而输出theta时需要deg，再转化回来

![Double-Pendulum-Model-0](SimscapeMultibodySummary.assets/Double-Pendulum-Model-0.png)Revolute Joint:旋转关节，两个坐标轴原点O、`Z轴`重合，`X和Y`绕重合的`Z`轴旋转，关节方向由从`follower`相对于`base`的运动定义,即revo joint默认添加绕`Z`轴的`pin`销钉

![Frame-Link](SimscapeMultibodySummary.assets/Frame-Link.png)

如上述坐标转换关系，在SemMechanics中建立最终考虑rod质量的单摆模型

![Single-Pendulum-Model-1](SimscapeMultibodySummary.assets/Single-Pendulum-Model-1.png)

### 双摆运动



![Double-Pendulum-Model-1](SimscapeMultibodySummary.assets/Double-Pendulum-Model-1.png)

<img src="SimscapeMultibodySummary.assets/Double-Pendulum-Model-2.png" alt="Double-Pendulum-Model-2" style="zoom:67%;" />

<img src="SimscapeMultibodySummary.assets/Double-Pendulum-Model-3.png" alt="Double-Pendulum-Model-3" style="zoom:67%;" />

# Task7 Solidworks2Simmechanics

## Step1 下载适配安装包

[链接一](https://ww2.mathworks.cn/help/physmod/smlink/ref/linking-and-unlinking-simmechanics-link-software-with-solidworks.html )

[链接二](https://ww2.mathworks.cn/campaigns/offers/download_smlink.html )

##  Step2 以管理员身份打开MATLAB,并切换安装包目录执行安装

- 依次输入以下命令

```matlab
install_addon('smlink.r2019b.win64.zip') 
regmatlabserver
smlink_linksw
```

- 启动sw,启动插件，不需要重启

## Step3 在Assembly下的第三个工具里,选择以下步骤

<img src="SimscapeMultibodySummary.assets/eg1.png" alt="eg1" style="zoom: 50%;" />

- 指定名字，后缀为.xml,高版本默认为第2代xml

## Step4 切换至Simulink下,导入模型

- 导入1st模型时，`mech_import('XXXXXXXXXX.xml')`.

- 导入2st模型，`smimport(‘XXXXXXX.xml’)`.

# Task8 实战-单摆

![practice](SimscapeMultibodySummary.assets/practice.png)

> 其对应生成的`DataFile`不能删除

# 基础知识

## Frames and Transforms

- *x*轴为红色，*y*轴为绿色，*z*轴为蓝色

| Frames and Transforms                                        | 名称                                           |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [Reference Frame](https://ww2.mathworks.cn/help/physmod/sm/ref/referenceframe.html) | 非惯性参考系，相对参考系                       |
| [Rigid Transform](https://ww2.mathworks.cn/help/physmod/sm/ref/rigidtransform.html) | 固定框架之间的空间关系，时不变关系，移动或旋转 |
| [World Frame](https://ww2.mathworks.cn/help/physmod/sm/ref/worldframe.html) | 惯性参考系,全局参考系                          |

每个`body`的R端口代表它本身的`local reference frame of a solid`

> 注：如果两个实体块通过刚性变换块连接，则它们属于同一实体。然后，一个重力作用在该物体的质心上。而对于关节而言，不论其类型如何(Weld Joint焊接)，每个关节块都将其连接的身体元素分离为单独的身体。现实生活中，刚性变换loop存在，但在模型中Rigid transform loops是不允许的

- Custom Solid Frames

`Solid block` 提供了一个`frame creation` 界面，可用于自定义新的和`frames`. 你可以定位和定向一个自定义`frame`通过使用 `geometry features` （such as 点、线、面）. 从惯性角度来看，更方便, 你也可以通过使用实体的质心和三个坐标轴来达到目的。

## Bodies-17个

| block                                                        | 名称             | 结构参数                                                     |
| :----------------------------------------------------------- | ---------------- | ------------------------------------------------------------ |
| [File Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/filesolid.html) | 来自文件         | 从外部文件派生的属性生成的实体                               |
| [Graphic](https://ww2.mathworks.cn/help/physmod/sm/ref/graphic.html) |                  | 具有图形属性的marker                                         |
| [Inertia](https://ww2.mathworks.cn/help/physmod/sm/ref/inertia.html) |                  | 具有固定惯性的质量元素，用于为特定的Frame添加惯性属性        |
| [Inertia Sensor](https://ww2.mathworks.cn/help/physmod/sm/ref/inertiasensor.html) |                  | 传感器，用于测量车身组或机构的惯性特性                       |
| [Brick Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/bricksolid.html) | 方块             | [x,y,z],坐标原点在重心,具有geometry, inertia和color的实心方块 |
| [Cylindrical Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/cylindricalsolid.html) | 圆柱             | 沿Z轴的length,Radius,坐标原点在重心，具有geometry, inertia和color的实心圆柱 |
| [Spherical Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/sphericalsolid.html) | 球体             | Radius=scalar，坐标原点在重心，具有geometry, inertia和color的实心球 |
| [Ellipsoidal Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/ellipsoidalsolid.html) | 椭球体           | Radius=[x,y,z]，坐标原点在重心，具有geometry, inertia和color的实心椭球 |
| [Extruded Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/extrudedsolid.html) | 拉伸体           | 具有geometry, inertia和color的拉伸体，可用于产生正多棱柱，`General Extrusion: Cross-section`—在XY平面上指定的横截面坐标，是一个两列[X,Y]的矩阵 |
| [Revolved Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/revolvedsolid.html) | 旋转体           | 具有geometry, inertia和color的旋转体，在XZ平面上指定的横截面坐标,是一个两列[X,Z]的矩阵 |
| [General Flexible Beam](https://ww2.mathworks.cn/help/physmod/sm/ref/generalflexiblebeam.html) | 通用柔性梁       |                                                              |
| [General Variable Mass](https://ww2.mathworks.cn/help/physmod/sm/ref/generalvariablemass.html) | 一般可变质量     | 具有可变惯性的质量元素                                       |
| [Reduced Order Flexible Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/reducedorderflexiblesolid.html) | 基于降阶柔性固体 |                                                              |
| [Variable Brick Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/variablebricksolid.html) |                  | 质量和尺寸可变的实心方块                                     |
| [Variable Cylindrical Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/variablecylindricalsolid.html) |                  | 质量和尺寸可变的实心圆柱                                     |
| [Variable Spherical Solid](https://ww2.mathworks.cn/help/physmod/sm/ref/variablesphericalsolid.html) |                  | 质量和尺寸可变的实心球                                       |
| [Spline](https://ww2.mathworks.cn/help/physmod/sm/ref/spline.html) |                  | 三次插值平面曲线或空间曲线                                   |

> body elements包括（均有质量）：有几何形状和interia惯性的实体、单单有interia惯性的实体、单单有几何形状(没有惯性)的实体
>
> Those of plain inertias普通惯性仅包括惯性，其参数通常包括质量，质心，惯性矩和惯性乘积
>
> 可视化一个截面:当有多个封闭图形时，数组元素按顺时针方向排序，以确保在生成横截面时，实体区域保持在左侧。
>
> - 有关如何创建一个复合bodies，请参见[Try It: Create a Compound Geometry:并包括创建一个复合惯性](https://www.mathworks.com/help/physmod/sm/ug/compounding-body-elements.html#mw_14364c3d-f2ab-4f78-bc99-d6a67541e061).
>
> - [Try It: Define a Simple Cross-Section](https://www.mathworks.com/help/physmod/sm/ug/modeling-extrusions-and-revolutions.html#mw_30008208-0fe0-4a53-badf-ef5164c6211a)、[Try It: Define a Cross-Section with Two Holes](https://www.mathworks.com/help/physmod/sm/ug/modeling-extrusions-and-revolutions.html#mw_2c67629c-9947-41a3-b552-51e4bfe83b1a).
>
> ```matlab
> plot（cs（：，1），cs（：，2），'Color'，[0.6 0.6 0.6]，'Marker'，'。'，... 
> 'MarkerSize'，9，'MarkerEdgeColor'，[1 0 0]）；
> ```

## Assembly-28个

- 通过joint，gear和约束等连接实体
- The joint blocks 决定了最大自由度—rotational and translational—在连接的bodies们之间
- The constraint blocks 减少自由度 by应用 kinematic relationships运动学关系 that 经常耦合自由度 . There 
- 对Assembly的 模型拓扑: you can model `kinematic trees` （例如a double pendulum双摆） 和 `kinematic loops`（例如a four bar四缸）.
- `Gear and Constraint blocks `也施加了bodies间的运动约束，不同在于它们是根据在实体之间要移除的DoFs进行参数化的,而 `Joint blocks` 则是根据提供的DoFs进行参数化的。

### Joint:均是`F`关于`B`

- joints是在物体之间施加主要的运动学约束，这些运动学约束决定了它们如何相对运动。关节可以是物理连接，例如在线性液压致动器的壳体和轴之间，也可以是虚拟连接，例如在地球和月球之间

- Joint Primitives：关节基元

  `Joint blocks` 是`joint primitives`的分类, 各种基础但完整的`joint`不能再细分 . Joint primitives range in number from zero (如Weld Joint block焊接模块)  to six(如Bushing Joint block套管接头模块). 这里有five joint primitives:

  - Prismatic移动 — Allows translation along a single standard axis (x, y, or z). 关节块最多可以包含三个 prismatic joint primitives, 每一个都代表一个translational DoF. 被标记为 `P*`, 其中星号表示运动轴 , 如`Px、Py 、Pz`
  - Revolute旋转 — Allows rotation about a single standard axis (x, y, or z).关节块最多可以包含三个 revolute joint primitives,  每一个都代表一个rotational DoF. 被标记为 `R*`,其中星号表示运动轴,如`Rx、Ry、Rz`
  - Spherical —允许绕任何3-D轴[ *x*，*y*，*z* ] 旋转. 关节块最多包含一个spherical primitive, 并且永远不会与revolute primitives 组合. 被标记为`S`.
  - Lead Screw丝杠 Primitive —允许在标准轴（例如z）上旋转和平移耦合. This primitive converts between rotation at one end and translation at the other. 关节块最多包含一个`lead screw primitive`. 被标记为`LS*`, 其中星号表示运动轴.
  - Constant Velocity Joint等速万向节 — 允许在任意对齐的相交轴之间以恒定速度旋转. 关节块包含不超过一个constant velocity primitive. 被标记为`CV`.

  > Why use Joint blocks with spherical primitives? 
  >
  > Those with three `revolute primitives` are susceptible to 万向节锁定gimbal lock—这是因为当任意两个旋转轴对齐时通常不希望丢失其中一个旋转自由度。由于数值奇异，Gimbal lock 会导致仿真错误。 `Spherical primitives`通过使用称为四元数的4-D量表示3-D旋转，消除了万向锁定错误的风险。

![joint_primitives_summary](SimscapeMultibodySummary.assets/joint_primitives_summary.png)

![joint-DOF](SimscapeMultibodySummary.assets/joint-DOF.png)

- Joint Inertia:关节惯性

  - Simscape多体关节已理想化。它们与真实关节的不同之处在于它们没有惯性-在大多数模型中都是合适的近似值，在这些模型中，关节惯性对系统动力学的影响通常可以忽略不计。

  - 如果关节惯性很重要，不可忽略, 可以用Solid or Inertia blocks来解释. 

  - Connect `the block Reference frame ports` to the appropriate适当的 joint frames and specify the joint inertial properties in the block dialog boxes.

  - 有关如何指定惯性的更多信息，请参见[表示固体惯量](https://www.mathworks.com/help/physmod/sm/ug/specifying-solid-inertia.html)、[指定自定义惯量:从Solidworks指定](https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html)


| one或None Primitives的关节                                   | 描述                                             |
| ------------------------------------------------------------ | ------------------------------------------------ |
| [Prismatic Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/prismaticjoint.html) | 移动关节，一个prismatic primitive（Pz），1自由度 |
| [Revolute Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/revolutejoint.html) | 旋转关节，一个revolute primitive(Rz)，1自由度    |
| [Spherical Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/sphericaljoint.html) | 球关节，一个spherical primitive(S)，3自由度      |
| [Weld Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/weldjoint.html) | 焊接，no joint primitives，自由度为零            |

| Multiple Primitives Joints                                   | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [6-DOF Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/6dofjoint.html) | 六自由度关节，一个 spherical 和 三个prismatic primitives，6自由度 |
| [Bearing Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/bearingjoint.html) | 轴承关节，一个prismatic 和三个revolute primitives，4自由度   |
| [Bushing Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/bushingjoint.html) | 衬套接头，三个prismatic和三个revolute primitives，6自由度    |
| [Cartesian Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/cartesianjoint.html) | 笛卡尔关节，三个prismatic primitives，3自由度                |
| [Cylindrical Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/cylindricaljoint.html) | 圆柱关节，关于Z轴的一个prismatic和一个revolute primitives，2自由度 |
| [Gimbal Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/gimbaljoint.html) | 万向节，三个revolute primitives，3自由度                     |
| [Pin Slot Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/pinslotjoint.html) | 销槽接头，一个prismatic（Px）和一个revolute primitives(Rz)，2自由度 |
| [Planar Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/planarjoint.html) | 平面接头，两个prismatic(Rz)和一个revolute primitives(Px\\Py)，3自由度 |
| [Rectangular Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/rectangularjoint.html) | 矩形接头，两个prismatic primitives(Px\\Py)，2自由度          |
| [Telescoping Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/telescopingjoint.html) | 伸缩关节 ，一个prismatic(Pz)和一个spherical joint primitive(S)，4自由度 |
| [Universal Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/universaljoint.html) | 万向节，两个revolute primitives(Rx\\Ry)，2自由度             |

| Coupled Degrees of Freedom耦合自由度                         | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Constant Velocity Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/constantvelocityjoint.html) | 等速万向节，两个旋转自由度的关节，被约束以等速旋转，（Rx\\Ry，记作CV）2自由度 |
| [Lead Screw Joint](https://ww2.mathworks.cn/help/physmod/sm/ref/leadscrewjoint.html) | 丝杠接头，耦合的平移和旋转运动，（Lsz）1自由度               |

| Gear齿轮关节                                                 | 描述                                             |
| ------------------------------------------------------------ | ------------------------------------------------ |
| [Bevel Gear Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/bevelgearconstraint.html) | 锥齿轮的两个相互倾斜的旋转轴之间的运动学约束     |
| [Common Gear Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/commongearconstraint.html) | 两个具有平行旋转轴的共面正齿轮之间的运动学约束   |
| [Rack and Pinion Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/rackandpinionconstraint.html) | 平移齿条体与旋转小齿轮体之间的运动学约束         |
| [Worm and Gear Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/wormandgearconstraint.html) | 蜗杆与齿轮箱之间具有垂直非相交旋转轴的运动学约束 |

| Pulleys皮带轮                                                | 描述                                 |
| ------------------------------------------------------------ | ------------------------------------ |
| [Belt-Cable End](https://ww2.mathworks.cn/help/physmod/sm/ref/beltcableend.html) | 滑轮系统绳的尖端                     |
| [Belt-Cable Properties](https://ww2.mathworks.cn/help/physmod/sm/ref/beltcableproperties.html) | 滑轮系统绳的一般特性                 |
| [Belt-Cable Spool](https://ww2.mathworks.cn/help/physmod/sm/ref/beltcablespool.html) | 滑轮系统中绳索的源和下沉             |
| [Pulley](https://ww2.mathworks.cn/help/physmod/sm/ref/pulley.html) | 车轮包裹在绳索中，用于传递扭矩和运动 |

| Other Constraints其它约束                                    | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Angle Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/angleconstraint.html) | 角度约束，在`B`和`F`的Z轴之间施加固定角度<br />        如果约束角大于0°且小于180°，则框架将失去一个旋转自由度。<br />如果约束角恰好为0°或180°（即框架平行或反平行），则它们会失去两个旋转自由度。 |
| [Distance Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/distanceconstraint.html) | 距离约束，在`B`和`F`的原点之间施加固定距离<br />        框架彼此失去一个平移自由度 |
| [Point On Curve Constraint](https://ww2.mathworks.cn/help/physmod/sm/ref/pointoncurveconstraint.html) | 框架原点在固定曲线上的运动学约束<br />        该约束允许`F`从动框架 的原点仅沿连接到`B`基础框架端口的曲线平移 |

## Dynamics

- 添加力，扭矩和运动输入以驱动模型并使用传感器测量其动态响应

### Model Actuation

- 你可以通过应用force or torque `to a body` or `to a joint`来激活模型.

- Forces and Torques library. Add a block from this library and connect it `to the body frame(s)` that you want to apply the force or torque to.

- External Force and Torque作用在Body's Frame

- joint's actuation具有motion和Force or torque两种方式

  motion运动—指定给定关节图元的随时间变化的轨，

  Force or torque- 指定给定的关节图元上作用的随时间变化的致动力或扭矩

  > 当开启其中一种时,另一种要设置为自动计算

| Loads负荷                                                    | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [External Force and Torque](https://ww2.mathworks.cn/help/physmod/sm/ref/externalforceandtorque.html) | 来自Multibody模型外部的General力和/或扭矩                    |
| [Gravitational Field引力场](https://ww2.mathworks.cn/help/physmod/sm/ref/gravitationalfield.html) | Field of force due to point mass点质量引起的力场,来源于万有引力定律，仅需设置源mass,；引力场是时不变的。要指定时变，空间均匀的力场，使用[Mechanism Configuration](https://ww2.mathworks.cn/help/physmod/sm/ref/mechanismconfiguration.html)块 |
| [Internal Force](https://ww2.mathworks.cn/help/physmod/sm/ref/internalforce.html) | 任意两个frames原点之间的General力对                          |
| [Inverse Square Law Force反平方法则力](https://ww2.mathworks.cn/help/physmod/sm/ref/inversesquarelawforce.html) | 与两个任意frames原点之间距离的平方成反比的力对（例如库仑静电力） |
| [Spatial Contact Force](https://ww2.mathworks.cn/help/physmod/sm/ref/spatialcontactforce.html) | 其中至少一个是3-D的两个物体之间的接触力                      |
| [Spring and Damper Force](https://ww2.mathworks.cn/help/physmod/sm/ref/springanddamperforce.html) | 任意两个frames之间的Spring-damper force pair，与两个帧原点之间的距离和相对速度成比例的力 |

### Dynamical Sensing

- 你可以测量`frame pairs`之间的各种 dynamical variables。Sensing outputs有两种类型:

  Motion — 计算并输出两个`Simscape Multibody frames`之间的相对位置，速度或加速度。通过使用`joint blocks`的`sensing capability`来测量`joint Frames`之间的运动；或者使用 `Transform Sensor block`来测量任意两个`frames` 的运动：spatial relationship空间关系 .

  Force or torque — 计算并输出两个`Simscape Multibody frames`之间的力和扭矩。 你可以通过具体的`Forces and Torques blocks`来端口框架（the port frames）之间测量的力和力矩----比如`the Inverse Square Law Force block`----或者`joint block`的端口框架（the port frames）之间的力和力矩。


`Joint blocks`使您能够感测它们各自的端口框架之间的不同类型的力和扭矩，包括

- 作用在给定关节基元上的Actuation force or torque.
- Constraint force and torque 作用在整个关节(joint-wide) 以防止关节垂直方向的自由度运动.
- Total force and torque, 包括约束和关节原始促动贡献including constraint and joint primitive actuation contributions, acting joint-wide.

| Sensors传感器                                                | 描述                             |
| ------------------------------------------------------------ | -------------------------------- |
| [Transform Sensor](https://ww2.mathworks.cn/help/physmod/sm/ref/transformsensor.html) | 测量两个框架之间空间关系的传感器 |

| Utilities实用工具                                            | 描述                 |
| ------------------------------------------------------------ | -------------------- |
| [Mechanism Configuration](https://ww2.mathworks.cn/help/physmod/sm/ref/mechanismconfiguration.html) | 全机械仿真和机械参数 |

## [可视化模型及其组件](https://www.mathworks.com/help/physmod/sm/ug/model-visualization.html)

- 用于创建动画，输出可变视角动画、惯量椭球等。

# 创建模型空间变量

- [更改模型空间数据](https://ww2.mathworks.cn/help/simulink/ug/change-model-workspace-data.html)

- 嵌入`Matlab`代码

  ```matlab
  rhos = simmechanics.demohelpers.densities;
  colors = simmechanics.demohelpers.colors;
  Ks = 100000; % Spring Constant
  Kb = 20000;  % Damping Constant
  Wbc = 200;  % Barrel Cam Rotation Speed
  
  hws = get_param(bdroot, 'modelworkspace');%获取前所选模型的工作区
  ```


# 专业术语

pixels：像素

dialog box：对话框

Along Principal Inertia Axis：沿着主要惯性轴

diagram:动画视图

geometry：几何

inertia：转动惯量

derived values:衍生值

opacity:透明度0~1

offset:偏移量

translational and rotational ：平移和旋转

toggle:切换

Cartesian：笛卡尔式子

Primitives：基元\基本体\原始事物

Prismatic Joint：移动关节

 couple：耦合

Pivot Mount：枢轴安装

Hexagon：六边形

Cross-section：横截面

Peg：销钉

origin：原点

