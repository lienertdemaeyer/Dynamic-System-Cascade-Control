# Dynamic System: Cascade Control of Liquid Level in a Water Tank

## Table of Contents
- [Introduction](#introduction)
- [Transfer Function of the Solenoid Valve](#transfer-function-of-the-solenoid-valve)
  - [Transfer Function Evaluation Model](#transfer-function-evaluation-model)
  - [Transfer Function Design Model](#transfer-function-design-model)
- [Simulation of the Dynamic Behavior of the Solenoid Valve](#simulation-of-the-dynamic-behavior-of-the-solenoid-valve)
  - [State Equations for the Solenoid Valve](#state-equations-for-the-solenoid-valve)
  - [Simulating Flow Rate and Valve Position without Position Control](#simulating-flow-rate-and-valve-position-without-position-control)
  - [Simulating Flow Rate and Valve Position with Position Control](#simulating-flow-rate-and-valve-position-with-position-control)
    - [P-Controller Evaluation Model](#p-controller-evaluation-model)
    - [P-Controller Design Model](#p-controller-design-model)
    - [PI-Controller Evaluation Model](#pi-controller-evaluation-model)
    - [PI-Controller Design Model](#pi-controller-design-model)
- [Comparison of Poles](#comparison-of-poles)
- [Advantages of Feedback](#advantages-of-feedback)
  - [First Advantage of Feedback](#first-advantage-of-feedback)
  - [Second Advantage of Feedback](#second-advantage-of-feedback)
- [Pole-Zero Analysis](#pole-zero-analysis)
  - [Transfer Function 1](#transfer-function-1)
  - [Transfer Function 2](#transfer-function-2)
  - [Transfer Function 3](#transfer-function-3)
  - [Transfer Function 4](#transfer-function-4)
  - [Pole-Zero Plot of the Solenoid Valve](#pole-zero-plot-of-the-solenoid-valve)
    - [Closed-Loop System with P-Controller](#closed-loop-system-with-p-controller)
    - [Closed-Loop System with PI-Controller](#closed-loop-system-with-pi-controller)
- [Analysis of Control Systems in the Frequency Domain](#analysis-of-control-systems-in-the-frequency-domain)
  - [Bode Analysis of the Dynamic Behavior of the Solenoid Valve with Position Control](#bode-analysis-of-the-dynamic-behavior-of-the-solenoid-valve-with-position-control)
    - [P-Controller: Evaluation Model](#p-controller-evaluation-model-1)
    - [P-Controller: Design Model](#p-controller-design-model-1)
    - [PI-Controller: Evaluation Model](#pi-controller-evaluation-model-1)
    - [PI-Controller: Design Model](#pi-controller-design-model-1)
  - [Magnitude Plot of the Closed-Loop Transfer Function](#magnitude-plot-of-the-closed-loop-transfer-function)
    - [P-Controller: Evaluation Model](#p-controller-evaluation-model-2)
    - [P-Controller: Design Model](#p-controller-design-model-2)
    - [PI-Controller: Evaluation Model](#pi-controller-evaluation-model-2)
    - [PI-Controller: Design Model](#pi-controller-design-model-2)
  - [Magnitude Plot of the Sensitivity Function](#magnitude-plot-of-the-sensitivity-function)
    - [P-Controller: Evaluation Model](#p-controller-evaluation-model-3)
    - [P-Controller: Design Model](#p-controller-design-model-3)
    - [PI-Controller: Evaluation Model](#pi-controller-evaluation-model-3)
    - [PI-Controller: Design Model](#pi-controller-design-model-3)


## Introduction
This project focuses on the application of a dynamic system for cascade control of the liquid level in a water tank. It includes an in-depth analysis of a solenoid valve, which can control the inflow rate of liquid into a tank. The solenoid valve is represented as a mass-spring-damper system, with a proportional relationship between electric current and magnetic force. This project also includes mathematical derivations of system transfer functions and a state-space representation.

## Transfer Function of the Solenoid Valve

The solenoid valve in this system can be modeled as a mass-spring-damper system. It controls the flow rate in a fluid tank by adjusting the position of a mechanical spool within the valve. This spool moves in response to an electromagnet, driven by an electric current through a coil, which induces a force on the spool. Below, we derive its transfer function, both for an evaluation model that considers all dynamics, and a design model that simplifies the system.

### Transfer Function Evaluation Model

The mechanical spool is treated as a mass-spring-damper system, where the mass is \( m \), the damping coefficient is \( c \), and the spring constant is \( k \). When an electric current \( i(t) \) passes through the coil, it generates a magnetic force \( F(t) \) on the spool, given by:

$$
F(t) = B_c l_c i = K_c i(t)
$$

where:
- \(m\): Mass of the moving element
- \(c\): Viscous damping coefficient
- \(k\): Spring constant
- \(K_c\): Proportional constant relating current and force
- \(i(t)\): Electric current

This force drives the motion of the mechanical spool, and the equation of motion can be written as:

$$
m\frac{d^2x}{dt^2} + c\frac{dx}{dt} + kx = K_c i(t)
$$

where \( x(t) \) is the relative position of the spool. This forms the basis for analyzing the dynamic behavior of the solenoid valve.

where:
- \(m\): Mass of the moving element
- \(c\): Viscous damping coefficient
- \(k\): Spring constant
- \(K_c\): Proportional constant relating current and force
- \(i(t)\): Electric current

In the Laplace domain, the transfer function from input voltage to the displacement of the valve can be expressed as:

$$\frac{X(s)}{V(s)} = \frac{\frac{K_c}{mR}}{(s^2 + \frac{c}{m}s + \frac{k}{m})(\frac{L}{R}s + 1) + \frac{K_cK_e}{mR}s}$$

### Transfer Function Design Model
In the design model, it is assumed that the dynamics of the electrical coil can be neglected. This leads to a simplified transfer function:

$$\frac{X(s)}{V(s)} = \frac{\frac{K_c}{Rk}}{b_0s^2 + b_1s + 1}$$

where:
- $b_0 = \frac{m}{k}$
- $b_1 = \frac{c}{k} + \frac{K_cK_e}{Rk}$



## Simulation of the Dynamic Behavior of the Solenoid Valve

### State Equations for the Solenoid Valve

We define the states as:

$$
\begin{aligned}
    x_1 &= x \\
    x_2 &= \dot{x} \\
    x_3 &= i
\end{aligned}
$$

#### Mechanical Coil:

The system equation for the mechanical coil becomes:

$$
\dot{x_2} = -\frac{k}{m}x_1 - \frac{c}{m}x_2 + \frac{K_c}{m}x_3
$$

#### Electrical Coil:

Using the system equation for the electrical coil:

$$
\dot{x_3} = -\frac{K_e}{L}x_2 - \frac{R}{L}x_3 + \frac{v}{L}
$$

#### State-Space Representation:

The state-space representation is given by:

$$
\begin{bmatrix}
\dot{x_1} \\
\dot{x_2} \\
\dot{x_3}
\end{bmatrix} =
\begin{bmatrix}
0 & 1 & 0 \\
-\frac{k}{m} & -\frac{c}{m} & \frac{K_c}{m} \\
0 & -\frac{K_e}{L} & -\frac{R}{L}
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
x_3
\end{bmatrix}
+
\begin{bmatrix}
0 \\
0 \\
\frac{1}{L}
\end{bmatrix}
v
$$

$$
y =
\begin{bmatrix}
1 & 0 & 0 \\
\alpha & 0 & 0 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
x_3 \\
\end{bmatrix}
$$

where:

$$
\alpha = C_d \pi d_{a1} \sqrt{P_s \frac{2}{\rho}} x
$$








## Simulating Flow Rate and Valve Position without Position Control

### State Equations
The state-space representation of the solenoid valve system can be defined with the following state variables:

$$
\begin{aligned}
    x_1 &= x \\
    x_2 &= \dot{x} \\
    x_3 &= i
\end{aligned}
$$

The state equations are derived from the equations of motion for the mechanical spool and the electric coil:

$$
\begin{aligned}
    \dot{x}_2 &= -\frac{k}{m}x_1 - \frac{c}{m}x_2 + \frac{K_c}{m}x_3 \\
    \dot{x}_3 &= -\frac{K_e}{L}x_2 - \frac{R}{L}x_3 + \frac{v}{L}
\end{aligned}
$$

Additionally, the constant $\alpha$ is defined as:

$$
\alpha = C_d \pi d_{a1} \sqrt{\frac{2P_s - x}{\rho}}
$$

### Key Equations and Simulation Insights

### Evaluation Model
The evaluation model captures the full dynamics, including the electrical coil. The system is modeled as:

$$
\begin{bmatrix}
\dot{x_1} \\
\dot{x_2} \\
\dot{x_3}
\end{bmatrix} =
\begin{bmatrix}
0 & 1 & 0 \\
-\frac{k}{m} & -\frac{c}{m} & \frac{K_c}{m} \\
0 & -\frac{K_e}{L} & -\frac{R}{L}
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
x_3
\end{bmatrix}
+
\begin{bmatrix}
0 \\
0 \\
\frac{1}{L}
\end{bmatrix}
v
$$

With the output equation:

$$
y =
\begin{bmatrix}
1 & 0 & 0 \\
\alpha & 0 & 0
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
x_3
\end{bmatrix}
$$

### Design Model
In the design model, the electrical coil dynamics are neglected. We assume $\dot{i} = 0$, leading to the reduced system:

$$
\dot{x_2} = -\frac{k}{m}x_1 - \left(\frac{c}{m} + \frac{K_e K_c}{mR}\right)x_2 + \frac{K_c}{mR}v
$$

This results in the state-space equation:

$$
\begin{bmatrix}
\dot{x_1} \\
\dot{x_2}
\end{bmatrix} =
\begin{bmatrix}
0 & 1 \\
-\frac{k}{m} & -\left(\frac{c}{m} + \frac{K_e K_c}{mR}\right)
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
+
\begin{bmatrix}
0 \\
\frac{K_c}{mR}
\end{bmatrix}
v
$$



#### MATLAB Simulation Results

Simulations were carried out for different values of $K_e$ and $c$. Key observations include:

![Debiet zonder positieregelaar](https://github.com/user-attachments/assets/10650202-12fb-483c-81d5-78ef503426ea)


1. The **blue graph** (evaluatiemodel) and **purple dotted graph** for $c=0.4$ and $K_e=0$ exhibited the greatest damping.
2. The **red graph** (evaluatiemodel) and **green dotted graph** for $c=0.15$ and $K_e=0$ showed the strongest overshoot.
3. The **orange graph** (evaluatiemodel) and **cyan graph** for $c=0.15$ and $K_e=500$ showed more damping compared to the red graph, despite having the same damping coefficient, due to the increased feedback from the electromotive force ($K_e=500$).

![Klepstand van de solenoïdeklep zonder positieregelaar](https://github.com/user-attachments/assets/836d6dfb-d5c3-4a1c-872c-e54016bd3e51)







## Simulation of Flow Rate and Valve Position with Position Control

### **P-controller evaluation model**
For a P-controller, the following holds:

$$ v_{in} = K_{rc}(x_r - x) $$

Let $x_1 = x$

$$ v_{in} = K_{rc}(x_r - x_1) $$

Substituting this into the state equation of the solenoid valve derived in Section 1.2.1, where $v = v_{in} + v_{noise}$, gives:

$$
\begin{bmatrix}
\dot{x_1}\\
\dot{x_2}\\
\dot{x_3}\\
\end{bmatrix}=
\begin{bmatrix}
0 & 1 & 0\\
-\frac{k}{m} & -\frac{c}{m} & \frac{Kc}{m}\\
-\frac{K_{rc}}{L} & -\frac{Ke}{L} & -\frac{R}{L}\\
\end{bmatrix}
\begin{bmatrix}
x_1\\
x_2\\
x_3\\
\end{bmatrix}+
\begin{bmatrix}
0 & 0\\
0 & 0\\
\frac{K_{rc}}{L} & \frac{1}{L}\\
\end{bmatrix}
\begin{bmatrix}
x_r\\
v_{noise}\\
\end{bmatrix}
$$


### **P-controller design model**

For the design model, $\dot{x_3} = 0$, so:

$$
0 = -\frac{K_{rc}}{L}x_1 - \frac{K_e}{L}x_2 - \frac{R}{L}x_3 +
\frac{K_{rc}}{L}x_r + \frac{1}{L}v_{noise}
$$

Solving for $x_3$ gives:

$$
x_3 = -\frac{K_{rc}}{R}x_1 - \frac{K_e}{R}x_2 - \frac{K_{rc}}{R}x_r + \frac{1}{R}v_{noise}
$$

Substituting into $\dot{x_2}$ gives:

$$
\dot{x_2} = -\frac{k}{m}x_1 - \frac{c}{m}x_2 + \frac{K_c}{m} \left(-\frac{K_{rc}}{R}x_1 - \frac{K_e}{R}x_2 + \frac{K_{rc}}{R}x_r + \frac{1}{R}v_{noise}\right)
$$

$$
\dot{x_2} = -\left(\frac{k}{m} + \frac{K_{rc}K_c}{mR}\right)x_1 - \left(\frac{c}{m} + \frac{K_cK_e}{mR}\right)x_2 + \frac{K_cK_{rc}}{mR}x_r + \frac{K_c}{mR}v_{noise}
$$

The state equation of the design model for the P-controller becomes:

$$
\begin{bmatrix}
\dot{x_1}\\
\dot{x_2}\\
\end{bmatrix}=
\begin{bmatrix}
0 & 1\\
-\left(\frac{k}{m} + \frac{K_{rc}K_c}{mR}\right) & -\left(\frac{c}{m} + \frac{K_cK_e}{mR}\right)\\
\end{bmatrix}
\begin{bmatrix}
x_1\\
x_2\\
\end{bmatrix}+
\begin{bmatrix}
0 & 0\\
\frac{K_cK_{rc}}{mR} & \frac{K_c}{mR}\\
\end{bmatrix}
\begin{bmatrix}
x_r\\
v_{noise}\\
\end{bmatrix}
$$


### **PI-controller evaluation model**

The transfer function is given by:

$$ G_{rc}(s) = K_{rc}(1 + \frac{1}{\tau_{ic}s}) $$

The PI-controller acts as an integrator and introduces a new state into the system: $v_{in}$. The phase form of the PI-controller is described as:

$$ v_{in} = K_{rc}(x_{r} - x) + \frac{K_{rc}}{\tau_{ic}} \int_{0}^{x} (x_{r} - x) \,dx $$

Working out the integral gives:

$$ v_{in} =  K_{rc}(1 + \frac{1}{\tau_{ic}s}) (x_{r} - x) $$

And $\dot{v_{in}}$ with $\dot{x_{r}} = 0$ becomes:

$$ \dot{v_{in}} = -K_{rc} \dot{x} + \frac{K_{rc}}{\tau_{ic}} x_{r} - \frac{K_{rc}}{\tau_{ic}} x $$

For the evaluation model, $v_{in}$ is now also considered as a state:

$$
\begin{array}{ll}
    x_1 = x \\
    x_2 = \dot{x} \\
    x_3 = i \\
    x_4 = v_{in} \\
\end{array}
$$

The equations for $v_{in}$ derived above, the mechanical valve, and the electrical coil derived in Section 1.2.1 are:

$$
\begin{array}{ll}
    \ddot{x} = -\frac{k}{m} x - \frac{c}{m} \dot{x} + \frac{K_c}{m} i \\
    \frac{di}{dt} = -\frac{K_e}{L} \dot{x} - \frac{R}{L} i + \frac{v}{L} \\
    \dot{v_{in}} = -K_{rc} \dot{x} + \frac{K_{rc}}{\tau_{ic}} x_{r} - \frac{K_{rc}}{\tau_{ic}} x \\
\end{array}
$$

With the above states and with $v = v_{in} + v_{noise}$ substituted, this gives:

$$
\begin{array}{ll}
    \dot{x_2} = -\frac{k}{m} x_1 - \frac{c}{m} x_2 + \frac{K_c}{m} x_3 \\
    \dot{x_3} = -\frac{K_e}{L} x_2 - \frac{R}{L} x_3 + \frac{v_{in} + v_{noise}}{L} \\
    \dot{x_4} = -K_{rc} x_2 + \frac{K_{rc}}{\tau_{ic}} x_{r} - \frac{K_{rc}}{\tau_{ic}} x_1 \\
\end{array}
$$

The state equation in matrix form becomes:

$$
\[
\begin{bmatrix}
\dot{x_1}\\
\dot{x_2}\\
\dot{x_3}\\
\dot{x_4}\\
\end{bmatrix}=
\begin{bmatrix}
0 & 1 & 0 & 0\\
-\frac{k}{m} & -\frac{c}{m} & \frac{K_{c}}{m} & 0\\
0 & -\frac{K_{e}}{L} & -\frac{R}{L} & \frac{1}{L}\\
-\frac{K_{rc}}{\tau_{ic}} & -K_{rc} & 0 & 0\\
\end{bmatrix}
\begin{bmatrix}
x_1\\
x_2\\
x_3\\
x_4\\
\end{bmatrix}+
\begin{bmatrix}
0 & 0\\
0 & 0\\
0 & \frac{1}{L}\\
\frac{K_{rc}}{\tau_{ic}} & 0\\
\end{bmatrix}
\begin{bmatrix}
x_r\\
v_{ruis}\\
\end{bmatrix}
\]
$$


### **PI-controller design model**

For the design model, $\dot{x_3} = \dot{i} = 0$, so:

$$
\dot{x_3} = -\frac{K_e}{L}x_2 - \frac{R}{L}x_3 + \frac{v}{L} = 0
$$

Solving for $x_3$ gives:

$$
x_3 = -\frac{K_e}{R}x_2 + \frac{v_{in} + v_{noise}}{R}
$$

Substituting into $\dot{x_2}$ and rearranging gives:

$$
\dot{x_2} = -\frac{k}{m}x_1 - \frac{c}{m}x_2 + \frac{K_c}{m} \left(-\frac{K_e}{R}x_2 + \frac{v_{in} + v_{noise}}{R}\right)
$$

$$
\Longleftrightarrow \dot{x_2} = -\frac{k}{m}x_1 - \left(\frac{c}{m} + \frac{K_cK_e}{mR}\right)x_2 + \frac{K_c}{m}\frac{v_{in} + v_{noise}}{R}
$$

The state equation becomes:

$$
\[
\begin{bmatrix}
\dot{x_1}\\
\dot{x_2}\\
\dot{x_3}\\
\end{bmatrix}=
\begin{bmatrix}
0 & 1 & 0\\
-\frac{k}{m} & {\frac{-K{c}K{c}}{mR}} {-\frac{c}{m}} & \frac{K_{c}}{mR}\\
-\frac{K_{rc}}{\tau_{ic}} & -K_{rc} & 0\\
\end{bmatrix}
\begin{bmatrix}
x_1\\
x_2\\
x_3\\
\end{bmatrix}+
\begin{bmatrix}
0 & 0\\
0 & \frac{K_{c}}{mR}\\
\frac{K_{rc}}{\tau_{ic}} & 0\\
\end{bmatrix}
\begin{bmatrix}
x_r\\
v_{ruis}\\
\end{bmatrix}
\]
$$


### P-Controller MATLAB Simulations

The behavior of the valve position was simulated with a P-controller using the following parameter values:

$$x = 0.002\ m \qquad c = 0.4\ Ns/m \qquad K_e = 0\ Vs/m$$

After 2 seconds, a step input was applied, and the simulations were performed for the following $K_{rc}$ values:

$$10\ kV/m \qquad 20\ kV/m \qquad 30\ kV/m \qquad 50\ kV/m \qquad 100\ kV/m \qquad 400\ kV/m$$

#### Figure 1
The plot below shows the valve position [$m$] over time [$s$] for different $K_{rc}$ values using the P-controller.

![klepstand van de solenoïdklep met P-regelaar 3](https://github.com/user-attachments/assets/b57e0d82-df7d-4ac6-8606-5cb071459532)

It can be observed that at $K_{rc} = 400\ kV/m$, the evaluation model becomes unstable, while the design model remains stable and will evolve towards the desired valve position of $x = 0.002\ m$. This is due to the design model having one less pole (2 poles instead of 3). The design model is an approximation, and as the dynamics increase (with a higher $K_{rc}$), this leads to errors. The stronger the $K_{rc}$, the larger the overshoot, resulting in more oscillations. For example, with $K_{rc} = 10\ kV/m$, the output of the evaluation model (solid blue line) quickly evolves towards equilibrium, while for $K_{rc} = 100\ kV/m$, the output shows a damped sinusoidal behavior in response to the step input. Despite the slower response for higher $K_{rc}$ values, the output still reaches the desired valve position of $x = 0.002\ m$, which is not always the case for lower $K_{rc}$ values.

#### Figure 2
The following plot shows the valve position [m] over time [s] with the P-controller at $K_{rc} = 400\ kV/m$ for the evaluation model.

![klepstand van de solenoïdklep met P-regelaar 2](https://github.com/user-attachments/assets/963a22b1-2671-4806-b8c7-173889a6b148)

#### Figure 3
The plot below shows the valve position [m] over time [s] with the P-controller at $K_{rc} = 400\ kV/m$ for the design model.

![klepstand van de solenoïdklep met P-regelaar 1](https://github.com/user-attachments/assets/75a7a743-e67d-4f45-b0ef-0712f842feda)




### PI-Controller MATLAB Simulation

The behavior of the valve position was simulated with a PI-controller using the following parameter values:

$$K_{rc} = 20\ kV/m \qquad \tau_{ic} = 0.5\ s \qquad \tau_{ic} = 1\ s \qquad \tau_{ic} = 1.5\ s \qquad \tau_{ic} = 2\ s$$

The plot below shows the valve position [m] over time [s] with different $\tau_{ic}$ values for the PI-controller.

![Klepstand van de solenoïdklep met PI-regelaar](https://github.com/user-attachments/assets/bef19d17-0de9-449c-9fdf-69fc6d1eaa8c)






### Comparison of Poles

#### Poles without controller for Evaluation Model and Design Model

| $K_e$ [Vs/m] | $c$ [Ns/m] | Evaluation Model | Design Model |
|--------------|------------|------------------|--------------|
| 0            | 0          | -0.6202; -2.5798; -66.6667 | -0.6202; -2.5798 |
| 0            | 0.15       | -0.6000+1.1136i; -0.6000-1.1136i; -66.6667 | -0.6000+1.1136i; -0.6000-1.1136i |
| 500          | 0.15       | -0.8049+0.9809i; -0.8049-0.9809i; -66.2549 | -0.8000+0.9798i; -0.8000-0.9798i |

#### Poles of P-controller for Evaluation Model and Design Model

| $K_{rc}$ [V/m] | Evaluation Model | Design Model |
|----------------|------------------|--------------|
| 10000          | -66.7922; -1.5372+2.6868i; -1.5372-2.6868i | -1.6000+2.6533i; -1.6000-2.6533i |
| 20000          | -66.7922; -1.4750+3.9190i; -1.4750-3.9190i | -1.6000+3.8781i; -1.6000-3.8781i |
| 30000          | -67.0404; -1.4131+4.8436i; -1.4131-4.8436i | -1.6000+4.8000i; -1.6000-4.8000i |
| 50000          | -67.2849; -1.2909+6.2890i; -1.2909-6.2890i | -1.6000+6.2482i; -1.6000-6.2482i |
| 100000         | -67.8809; -0.9929+8.8969i; -0.9929-8.8989i | -1.6000+8.8904i; -1.6000-8.8904i |
| 400000         | -71.0859; 0.6096+17.3561i; 0.6096-17.3561i | -1.6000+17.8616i; -1.6000-17.8616i |

#### Poles of PI-controller for Evaluation Model and Design Model

| $K_{rc}$ [V/m] | $\tau$ [s] | Evaluation Model | Design Model |
|----------------|------------|------------------|--------------|
| 20000          | 0.5        | -66.9093; -0.4332+3.8808i; -0.4332-3.8808i; -2.0910 | -2.0937; -0.5531+3.8701i; -0.5531-3.8701i |
| 20000          | 1          | -66.9130; -0.9561+3.7936i; -0.9561-3.7936i; -1.0415 | -1.0423; -1.0789+3.7666i; -1.0789-3.7666i |
| 20000          | 1.5        | -66.9143; -1.1409+3.8137i; -1.1409-3.8137i; -0.6707 | -0.6707; -1.2646+3.7821i; -1.2646-3.7821i |
| 20000          | 2          | -66.9149; -1.2300+3.8331i; -1.2300-3.8331i; -0.4918 | -0.4918; -1.3541+3.7993i; -1.3541-3.7993i |



### Advantages of Feedback

#### First Advantage of Feedback
System errors (static errors) caused by stationary (constant) disturbances can be reduced (disturbance rejection) in a feedback system compared to an open-loop system by a factor of $1 + AK_{rc}$, where $AK_{rc}$ represents the loop gain for $s=0$.

#### Second Advantage of Feedback
In a closed-loop system, the static gain ($s=0$) is much less sensitive to variations in the gain $A$ of the physical system than in an open-loop system. This sensitivity decreases by a factor of $1 + AK_{rc}$, meaning that with a very large static gain $K_{rc}$ from the controller, the sensitivity to variations in parameter $A$ approaches zero.



## Pole-Zero Analysis

The roots of the characteristic equation of a transfer function provide important insights into the stability and response of a system, which directly impacts system performance. By graphically plotting the roots in the s-plane as a function of a parameter $K$, this procedure systematically analyzes system behavior over 12 key steps. The open-loop transfer function $G(s)$ has $m$ zeros and $n$ poles, while the corresponding closed-loop transfer function $G_t(s)$ has closed-loop zeros and poles.

The main steps include:
- Writing the characteristic equation as $1 + KG(s) = 0$
- Factoring the transfer function $G(s)$
- Plotting the poles and zeros in the s-plane
- Determining the branches of the root locus (pole-zero plot)
- Finding real axis segments, symmetry, departure, and arrival angles
- Identifying asymptotes, multiple roots, and points where the root locus crosses the imaginary axis

This method helps in visualizing how system poles move as the gain $K$ changes, providing a graphical way to assess system stability and dynamic behavior. Below, we apply this procedure to Transfer Function 1, where we explore its poles and zeros.




### Transfer Function 1

The transfer function is given as:

$$
KG(s) = \frac{K(s+1)}{s^4+4s^3+6s^2+4s}
$$

#### Key Steps:
1. **Characteristic Equation**: Rewrite the characteristic equation as:
2. $1 + KG(s) = 1 + \frac{K(s+1)}{s^4+4s^3+6s^2+4s} = 0$

3. **Factorization**: Factor the numerator and denominator:
4. $1 + KG(s) = 1 + \frac{K(s+1)}{s(s+2)(s+1 \pm j)}$

5. **Poles and Zeros**: 
   - Zero: $z_1 = -1$
   - Poles: $p_1 = 0$, $p_2 = -2$, $p_3 = -1 - j$, $p_4 = -1 + j$

   ![pn1](https://github.com/user-attachments/assets/5af0b392-a10d-4d9d-8196-c0a9e1b972e5)

6. **Branches of the Pole-Zero Plot**: 
   - Four branches exist: one ends at the finite zero $z_1 = -1$, while the remaining three tend to infinity. 

7. **Segments on the Real Axis**: 
   - Points on the real axis between $(-\infty, -2]$ and $[-1, 0]$ belong to the pole-zero plot as they satisfy the angle criterion.

8. **Symmetry**: 
   - The pole-zero plot is symmetric about the real axis.

9. **Departure and Arrival Angles**: 
   - The departure angle for pole $p_1 = 0$: $\vartheta_{p_1} = 180^\circ$
   - The departure angle for pole $p_2 = -2$: $\vartheta_{p_2} = 180^\circ$
   - The departure angles for poles $p_3 = -1 - j$ and $p_4 = -1 + j$: $\vartheta_{p_3} = \vartheta_{p_4} = 0^\circ$

   - The arrival angle at zero $z_1 = -1$: $\vartheta_{z_1} = 0^\circ$

10. **Asymptotes**: 
   - The intercept $\sigma_c$ is given by:
     $
     \sigma_c = -\frac{\sum z_i - \sum p_j}{n-m} = -1
     $
   - The asymptote angles are:
     - $k=0$: $\vartheta_0 = 60^\circ$
     - $k=1$: $\vartheta_1 = 180^\circ$
     - $k=2$: $\vartheta_2 = 300^\circ$

#### Pole-Zero Plot

The final pole-zero plot for Transfer Function 1 is shown below:

![pb1](https://github.com/user-attachments/assets/d78e3acb-6932-45cf-96d1-e5faacec3d87)




### Transfer Function 2

The transfer function is given as:

$$
KG(s) = \frac{K}{s+4}
$$

#### Key Steps:
1. **Characteristic Equation**: Rewrite the characteristic equation as:
   $1 + KG(s) = 1 + \frac{K}{s+4} = 0$

2. **Factorization**: The numerator $T(s)$ and denominator $N(s)$ of $G(s)$ are already factored.

3. **Poles and Zeros**: 
   - There is no zero.
   - One pole: $p_1 = -4$

   ![pn2](https://github.com/user-attachments/assets/6d979c16-24cb-4eee-9195-cee220a299a5)

4. **Branches of the Pole-Zero Plot**: 
   - There is one branch, which tends asymptotically to infinity. There is no finite endpoint, and one endpoint goes to infinity.

5. **Segments on the Real Axis**: 
   - All points to the left of $p_1 = -4$ belong to the pole-zero plot because there is one pole to the right, satisfying the angle criterion for $s \in [-\infty, -4]$.

6. **Symmetry**: 
   - The pole-zero plot is symmetric about the real axis.

7. **Departure and Arrival Angles**: 
   - There is only one departure angle for pole $p_1 = -4$: $\vartheta_{p_1} = 180^\circ$
   - There is no arrival angle, as there is no zero.

8. **Asymptotes**: 
   - The intercept $\sigma_c$ is given by:$\sigma_c = -\frac{\sum z_i - \sum p_j}{n-m} = -4$
   - The asymptote angle is:
     - $k=0$: $\theta_0 = 180^\circ$

9. **Multiple Roots**: 
   - The condition $N(\hat{s})T'(\hat{s}) - N'(\hat{s})T(\hat{s}) = 0$ does not hold, so there are no multiple roots.

10. **Imaginary Axis Intersection**: 
   - Using the Routh-Hurwitz criterion, it is determined that the pole-zero plot does not intersect the imaginary axis, as $K > 0$ leads to no non-negative poles.

   ![pb2](https://github.com/user-attachments/assets/38789d1e-9e14-4ecb-840c-5acb8427f9ea)

The final pole-zero plot for Transfer Function 2 is shown above.






### Transfer Function 3

The transfer function is given as:

$$
KG(s) = \frac{K}{s(s+10)(s+30)}
$$

#### Key Steps:
1. **Characteristic Equation**: Rewrite the characteristic equation as:
   $1 + KG(s) = 1 + \frac{K}{s(s+10)(s+30)} = 0$

2. **Factorization**: The numerator $T(s)$ and denominator $N(s)$ of $G(s)$ are already factored.

3. **Poles and Zeros**: 
   - There are no zeros.
   - Poles: $p_1 = 0$, $p_2 = -10$, $p_3 = -30$

   ![pn3](https://github.com/user-attachments/assets/ade63357-517b-4379-a072-e7d9a3807a1d)

4. **Branches of the Pole-Zero Plot**: 
   - There are three branches, all tending to infinity. There are no finite endpoints, and all three branches go to infinity.

5. **Segments on the Real Axis**: 
   - Points on the real axis in the intervals $[-\infty, -30]$ and $[-10, 0]$ belong to the pole-zero plot as they satisfy the angle criterion.

6. **Symmetry**: 
   - The pole-zero plot is symmetric about the real axis.

7. **Departure Angles**: 
   - The departure angles for the poles are:
     - For pole $p_1 = 0$: $\vartheta_{p_1} = 180^\circ$
     - For pole $p_2 = -10$: $\vartheta_{p_2} = 0^\circ$
     - For pole $p_3 = -30$: $\vartheta_{p_3} = 180^\circ$

8. **Asymptotes**: 
   - The intercept $\sigma_c$ is given by:
     $
     \sigma_c = -\frac{\sum z_i - \sum p_j}{n-m} = \frac{-40}{3}
     $
   - The asymptote angles are:
     - $k=0$: $\vartheta_0 = 60^\circ$
     - $k=1$: $\vartheta_1 = 180^\circ$
     - $k=2$: $\vartheta_2 = 300^\circ$

9. **Multiple Roots**: 
   - Solving $N(\hat{s})T'(\hat{s}) - N'(\hat{s})T(\hat{s}) = 0$ results in two candidate points for multiple roots: $s_1 = -22.1515$ and $s_2 = -4.5125$. Since only $s_2$ lies on the pole-zero plot, it is identified as a multiple root.

10. **Imaginary Axis Intersection**: 
   - Using the Routh-Hurwitz criterion, the pole-zero plot intersects the imaginary axis at $s = 10\sqrt{3}j$ and $s = -10\sqrt{3}j$.

   ![pb3](https://github.com/user-attachments/assets/f2fac7db-b168-4523-aab3-7ed7d80ad97a)

The final pole-zero plot for Transfer Function 3 is shown above.




### Transfer Function 4

The transfer function is given as:

$$
KG(s) = \frac{K(s+3)}{(s+1)(s+2)}
$$

#### Key Steps:
1. **Characteristic Equation**: Rewrite the characteristic equation as:
   $1 + KG(s) = 1 + \frac{K(s+3)}{(s+1)(s+2)} = 0$

2. **Factorization**: The numerator $T(s)$ and denominator $N(s)$ of $G(s)$ are already factored.

3. **Poles and Zeros**: 
   - One zero: $z_1 = -3$
   - Two poles: $p_1 = -1$, $p_2 = -2$

   ![pn4](https://github.com/user-attachments/assets/7ea7cf5f-27c9-4904-8fe8-12d66dd7f7d6)

4. **Branches of the Pole-Zero Plot**: 
   - There are three branches: one ends at the finite zero $z_1 = -3$, while the other two tend to infinity. There is one finite endpoint and two endpoints at infinity.

5. **Segments on the Real Axis**: 
   - Points on the real axis in the intervals $[-\infty, -3]$ and $[-2, -1]$ belong to the pole-zero plot as they satisfy the angle criterion.

6. **Symmetry**: 
   - The pole-zero plot is symmetric about the real axis.

7. **Departure and Arrival Angles**: 
   - Departure angle for pole $p_1 = -1$: $\vartheta_{p_1} = 180^\circ$
   - Departure angle for pole $p_2 = -2$: $\vartheta_{p_2} = 180^\circ$
   - Arrival angle at zero $z_1 = -3$: $\vartheta_{z_1} = 0^\circ$

8. **Asymptotes**: 
   - The intercept $\sigma_c$ is given by:$\sigma_c = -\frac{\sum z_i - \sum p_j}{n-m} = 0$
   - The asymptote angle is:
     - $k=0$: $\vartheta_0 = 180^\circ$

9. **Multiple Roots**: 
   - Solving $N(\hat{s})T'(\hat{s}) - N'(\hat{s})T(\hat{s}) = 0$ results in two candidate points for multiple roots: $s_1 = -1.568$ and $s_2 = -4.414$. Since both lie on the pole-zero plot, both are identified as multiple roots.

10. **Imaginary Axis Intersection**: 
   - Using the Routh-Hurwitz criterion, it is determined that there are no intersections with the imaginary axis, as the roots are real.

   ![pb4](https://github.com/user-attachments/assets/e3d9cb79-31f7-4fa4-a5c4-80fccf842b33)

The final pole-zero plot for Transfer Function 4 is shown above.



### Pole-Zero Plot of the Solenoid Valve

In this section, the pole-zero plot of the closed-loop transfer function of the solenoid valve is calculated, with the gain $K_{rc}$ as the variable parameter. The simulation is performed using MATLAB for both the P-controller and the PI-controller (with $\tau_{ic} = 1s$), for both the evaluation model and the design model. The equations for the solenoid valve are repeated below:

#### Evaluation Model:
$$
\frac{x}{v} = \frac{\frac{K_c}{kR}}{a_0s^3+a_1s^2+a_2s+1}
$$

#### Design Model (Neglecting Coil Dynamics):
$$
\frac{x}{v}=\frac{\frac{K_c}{Rk}}{a_0s^2+a_1s+1}
$$

### Closed-Loop System with P-Controller

#### Evaluation Model
The pole-zero plot of the closed-loop system with the P-controller for the evaluation model is shown below:

![P-eval](https://github.com/user-attachments/assets/eba7ef2d-d7b4-4c40-8d0e-eec86f6422fb)

- **Poles**: $p_1 = -0.62$, $p_2 = -2.58$, $p_3 = -66.7$
- The real axis segments of the pole-zero plot are located left of $p_3$ and between $p_1$ and $p_2$. There is a breakout point at $s = -1.59$ between $p_1$ and $p_2$.
- Since all branches go to infinity and there are no zeros, the system will become unstable with an increase in gain $K_{c}$ as the pole-zero plot partly lies in the right half of the plane.

#### Design Model
The pole-zero plot for the design model with the P-controller is shown below:

![P-ontwerpzoom](https://github.com/user-attachments/assets/f464ff6c-de50-4c26-9237-d493664a03eb)

- **Poles**: $p_1 = -0.62$, $p_2 = -2.58$
- The real axis between the poles belongs to the pole-zero plot, with a breakout point at $s = -1.60$. Both branches asymptotically go to infinity with angles of $90^\circ$ and $-90^\circ$.
- As the entire pole-zero plot lies in the left half of the plane, the system remains stable according to the design model. However, this model does not accurately reflect the behavior of the evaluation model, as the design model always predicts stability.




### Closed-Loop System with PI-Controller

#### Evaluation Model
The pole-zero plot of the closed-loop system with the PI-controller for the evaluation model is shown below:

![PI-eval](https://github.com/user-attachments/assets/b1c11486-85ad-450c-a88d-4f97c623701f)

- **Poles**: $p_1 = 0$, $p_2 = -0.62$, $p_3 = -2.58$, $p_4 = -66.7$
- **Zero**: $z_1 = -1$
- The real axis segments of the pole-zero plot are located left of $p_4$, between $p_3$ and $z_1$, and between $p_1$ and $p_2$. The breakout point between $p_1$ and $p_2$ is $s = -0.362$.
- Since part of the pole-zero plot lies in the right half of the plane, the system will become unstable with an increase in gain $K_c$.

#### Design Model
The pole-zero plot for the design model with the PI-controller is shown below:

![PI-ontwerp](https://github.com/user-attachments/assets/93432916-4ec3-4aaa-a801-871b1f62c88f)

- **Poles**: $p_1 = 0$, $p_2 = -0.62$, $p_3 = -2.58$
- **Zero**: $z_1 = -1$
- The real axis segments are between $p_3$ and $z_1$ and between $p_1$ and $p_2$. The breakout point between $p_1$ and $p_2$ is at $s = -0.362$. The branches from $p_1$ and $p_2$ asymptotically go to infinity with angles of $90^\circ$ and $-90^\circ$.
- The entire pole-zero plot lies in the left half of the plane, meaning that according to the design model, the system remains stable regardless of the gain $K_c$. However, the design model is not an accurate reflection of the evaluation model, as it always predicts stability.


### Analysis of Control Systems in the Frequency Domain

#### Bode Analysis of the Dynamic Behavior of the Solenoid Valve with Position Control

Using the Bode diagram of the system, it can be determined whether the system is stable. The Bode diagram consists of two plots: a magnitude plot showing $20\log_{10}|G(j\omega)|$, expressed in decibels ($dB$), as a function of frequency $\omega$, expressed in rad/s, and a phase plot showing $\angle G(j\omega)$, expressed in degrees, also as a function of $\omega$. The stability of the closed-loop system can be determined using the Nyquist stability criterion. This criterion states that for a stable open-loop system, the closed-loop system will be stable if $|G_o(j\omega)| < 1$ when $\text{arg}[G_o(j\omega)] = -180^\circ$.

The closed-loop system must have a certain level of immunity to unmodeled dynamic phenomena. The **gain margin** (amplitude margin) is defined as the extra number of $dB$ by which the open-loop magnitude $|G_o(j\omega_p)|$ can increase at the phase crossover frequency $\omega_p$ before the magnitude reaches one. The phase crossover frequency is the frequency at which the phase of $G_o(s)$ equals $-180^\circ$ or $\text{arg}[G_o(j\omega)] = -180^\circ$. The smaller $|G_o(j\omega_p)|$ is compared to one, the more immune the closed-loop system is to unmodeled dynamics. The **phase margin** is defined as the extra number of degrees by which the open-loop phase $\text{arg}[G_o(j\omega_g)]$ can increase at the gain crossover frequency $\omega_g$ before the phase reaches $-180^\circ$. The gain crossover frequency is the frequency where the open-loop gain equals one. The gain margin and phase margin can be calculated using MATLAB.

#### Magnitude and Phase Plot of the Open-Loop Transfer Function

The Bode diagrams of the open-loop transfer function were calculated using MATLAB for various values of the gain $K_{r_c}$, along with the corresponding amplitude and phase margins. The open-loop transfer function of the solenoid valve with position control can be written as:

$$
G_o(s) = G_r(s)G_{cp}(s)
$$

where $G_{cp}(s)$ is the transfer function of the solenoid valve derived in Section 1.1, and $G_r(s)$ is the transfer function of the controller. For the P-controller, this is:

$$
G_r(s) = K_{r_c}
$$

and for the PI-controller:

$$
G_r(s) = K_{r_c}\left(1+\frac{1}{\tau_{ic}s}\right)
$$

#### P-Controller: Evaluation Model

In Figure \ref{fig:bodeplot_P-reg_eval_open}, the Bode diagram of the open-loop transfer function with the P-controller for the evaluation model is shown for different values of the gain $K_{r_c}$. A higher controller gain shifts the magnitude plot upwards. The black line on the magnitude plot represents the gain margins. The phase plot is the same for every gain, lagging and approaching $-270^\circ$ at high frequencies. The black lines on the phase plot represent the phase margins. 

In Table \ref{tab:Amp_en_fasemarges}, the values of the amplitude and phase margins for the different $K_{r_c}$ values are presented. As the gain of the P-controller increases, these margins decrease, indicating that the closed-loop system becomes less immune or robust to unmodeled dynamic phenomena. At a gain of 400,000, the phase margin even becomes negative, indicating that the closed-loop system is no longer stable.

![P-regelaar_evaluatiemodel_Go](https://github.com/user-attachments/assets/ef034a88-3a47-4bda-93b7-2252c55a613a)
*Figure 1: Bode diagram of the open-loop transfer function with P-controller for the evaluation model*

| $K_{r_c}$ | Gain Margin (dB) | Phase Margin (°) |
|-----------|------------------|------------------|
| 10000     | 27.96            | 62.36            |
| 20000     | 13.98            | 42.62            |
| 30000     | 9.32             | 33.47            |
| 50000     | 5.59             | 23.83            |
| 100000    | 2.80             | 13.13            |
| 400000    | 0.70             | -4.28            |

*Table 1: Amplitude and phase margins corresponding to the Bode diagram of the open-loop transfer function with P-controller for the evaluation model*



#### P-Controller: Design Model

For the design model, the transfer function $G_r(s)$ looks different and is second-order instead of third-order. This is because the dynamics of the electric coil are neglected. Figure \ref{fig:bodeplot_P-reg_ontw_open} shows the Bode diagrams of the open-loop transfer function with the P-controller, but now for the design model. The phase plot shows that the system is again lagging, but now approaches $-180^\circ$ at high frequencies. However, this value is never exactly reached, resulting in infinitely large gain margins. This can be seen in Table \ref{tab:Amp_en_fasemarges2}, which shows the amplitude and phase margins for the design model.

Additionally, it is noticeable that for a gain of 400,000, the phase margin is no longer negative, meaning that the system remains stable and insensitive to unmodeled dynamic phenomena.

![P-regelaar_ontwerpmodel_Go](https://github.com/user-attachments/assets/ff8f8cca-8562-4083-b6f7-346221f617a0)
*Figure 2: Bode diagram of the open-loop transfer function with P-controller for the design model*

| $K_{r_c}$ | Gain Margin (dB) | Phase Margin (°) |
|-----------|------------------|------------------|
| 10000     | $\infty$         | 64.27            |
| 20000     | $\infty$         | 45.65            |
| 30000     | $\infty$         | 37.33            |
| 50000     | $\infty$         | 28.95            |
| 100000    | $\infty$         | 20.48            |
| 400000    | $\infty$         | 10.25            |

*Table 2: Amplitude and phase margins corresponding to the Bode diagram of the open-loop transfer function with P-controller for the design model*




#### PI-Controller: Evaluation Model

Figure \ref{fig:bodeplot_PI-reg_eval_open} shows the Bode diagrams of the open-loop transfer function with the PI-controller for the evaluation model, for different values of the gain $K_{r_c}$. Once again, the black line in the magnitude plot represents the gain margins, and the black lines in the phase plot represent the phase margins.

The integrating action (I-action) of the PI-controller is visible in the magnitude plot at lower frequencies, where the magnitude line drops by 20 dB per decade, and in the phase plot at lower frequencies, where there is a phase lag of $-90^\circ$. At higher frequencies, the PI-controller behaves more like a P-controller as the P-action dominates.

Table \ref{tab:Amp_en_fasemarges3} shows the amplitude and phase margins corresponding to the Bode diagram of the open-loop transfer function with the PI-controller for the evaluation model. It can be observed that, once again, as the gain $K_{r_c}$ increases, the margins decrease, making the system with a PI-controller less robust or immune to unmodeled dynamic phenomena. The closed-loop system will become unstable at a gain of 400,000 V/m as the phase margin becomes negative. Compared to the evaluation model with the P-controller, these margins are smaller, indicating that a lower gain $K_{r_c}$ is preferable to maintain robustness.

![PI_regelaar_evaluatiemodel_Go](https://github.com/user-attachments/assets/2eb794d4-bf5a-4001-b9cc-60a18816001c)
*Figure 3: Bode diagram of the open-loop transfer function with PI-controller for the evaluation model*

| $K_{r_c}$ | Gain Margin (dB) | Phase Margin (°) |
|-----------|------------------|------------------|
| 10000     | 18.90            | 37.01            |
| 20000     | 9.45             | 26.43            |
| 30000     | 6.30             | 20.74            |
| 50000     | 3.78             | 14.26            |
| 100000    | 1.89             | 6.51             |
| 400000    | 0.47             | -7.57            |

*Table 3: Amplitude and phase margins corresponding to the Bode diagram of the open-loop transfer function with PI-controller for the evaluation model*



#### PI-Controller: Design Model

The Bode diagrams of the open-loop transfer function with the PI-controller for the design model are shown in Figure \ref{fig:bodeplot_PI-reg_ontw_open}. Similar to the previous case, the system is again lagging, but this time it approaches $-180^\circ$ at higher frequencies. In these Bode diagrams, the I-action can be seen at lower frequencies, and the P-action at higher frequencies.

As with the design model for the P-controller, the $-180^\circ$ phase is never exactly reached, resulting in infinitely large gain margins. This can be seen in Table \ref{tab:Amp_en_fasemarges4}, which displays the amplitude and phase margins corresponding to Figure \ref{fig:bodeplot_PI-reg_ontw_open}. It is also evident that for a gain of 400,000, the phase margin remains positive, meaning the system remains stable.

![PI-regelaar_ontwerpmodel_Go](https://github.com/user-attachments/assets/de9f1f48-8065-4ea9-82c9-6f3c10b147b2)
*Figure 4: Bode diagram of the open-loop transfer function with PI-controller for the design model*

| $K_{r_c}$ | Gain Margin (dB) | Phase Margin (°) |
|-----------|------------------|------------------|
| 10000     | $\infty$         | 39.05            |
| 20000     | $\infty$         | 29.54            |
| 30000     | $\infty$         | 24.66            |
| 50000     | $\infty$         | 19.44            |
| 100000    | $\infty$         | 13.92            |
| 400000    | $\infty$         | 7.03             |

*Table 4: Amplitude and phase margins corresponding to the Bode diagram of the open-loop transfer function with PI-controller for the design model*


### Magnitude Plot of the Closed-Loop Transfer Function

The magnitude plot of the closed-loop transfer function was calculated using MATLAB for both the evaluation model and the design model for both the P- and PI-controllers. This was done for all gain values of both controllers, with the same time constant. The result is shown in Figures \ref{fig:bodeplot_P-reg_eval_gesloten}–\ref{fig:bodeplot_PI-reg_ontw_geslotenn}.

The closed-loop transfer function $G_t(s)$ is defined as:

$$
G_t(s) = \frac{G_o(s)}{1 + G_o(s)}
$$

where $G_o(s)$ is the open-loop transfer function or loop gain.

The four plots below show a similar trend. For the P-controller at low frequencies, the lines approach 0 dB, where $\lvert G_o(j\omega) \rvert = 1$. This shows that the reference signal is closely followed at low frequencies. For the PI-controller, the magnitude lines coincide with 0 dB, meaning that the reference signal is reached exactly, while a P-controller always has a tracking error.

Afterward, the magnitude increases in all plots near the system's natural frequency. The peak shifts to the right for higher gains. Noise is amplified around this frequency, which can lead to instability, meaning excessively high gains are not good for the system.

At high frequencies, the magnitude drops for both the P- and PI-controllers. This is a desired effect, as it effectively filters out sensor noise and unmodeled high-frequency dynamic phenomena.

#### P-Controller: Evaluation Model

![P-regelaar_evaluatiemodel_Gt](https://github.com/user-attachments/assets/54de635d-bfe5-4a9e-92c7-f4ee58a5754d)
*Figure 5: Magnitude plot of the closed-loop transfer function with P-controller for the evaluation model*

#### P-Controller: Design Model

![P-regelaar_ontwerpmodel_Gt](https://github.com/user-attachments/assets/3d6cb48c-2412-44b0-8e8b-bf3fa320ebbe)
*Figure 6: Magnitude plot of the closed-loop transfer function with P-controller for the design model*

#### PI-Controller: Evaluation Model

![PI_regelaar_evaluatiemodel_Gt](https://github.com/user-attachments/assets/91eaa7a2-3f37-40b2-94c3-9163c015a544)
*Figure 7: Magnitude plot of the closed-loop transfer function with PI-controller for the evaluation model*

#### PI-Controller: Design Model

![PI-regelaar_ontwerpmodel_Gt](https://github.com/user-attachments/assets/5a3b405c-7103-4f70-987f-70f278b277dd)
*Figure 8: Magnitude plot of the closed-loop transfer function with PI-controller for the design model*



### Magnitude Plot of the Sensitivity Function

The sensitivity function $S(s)$ is the transfer function from the measurement noise/sensor noise $v$ to the measured signal $y$. Consider a simple system with two input signals: a reference signal $r$ and all process variations at the end of the system $v$. This system can be represented by:

$$
y = \frac{G_{cp} G_r}{1 + G_{cp} G_r} r + \frac{1}{1 + G_{cp} G_r} v
$$

with the sensitivity:

$$
S(s) = \frac{1}{1 + G_{cp} G_r}
$$

If $S(s) \approx 0$, then the effect of the measurement noise on the measured signal $y$ will be small. Sensitivity can also be described by the nominal sensitivity peak $M_s$, which is defined as:

$$
M_s = \underset{0 < \omega < \infty}{\text{max}} \left|\frac{1}{1 + G_{cp}(j\omega) G_r(j\omega)}\right|
$$

This formula minimizes the distance between the Nyquist plot and the unstable $-1$ point. A higher sensitivity means the system is more sensitive to process variations, implying that the Nyquist plot has points close to the $-1$ point, making the system more prone to instability. A nominal sensitivity peak between 1.3 and 2 is considered normal, while values above this range are considered high.

#### P-Controller: Evaluation Model

When the gain is reduced, the maximum sensitivity decreases, meaning the closed-loop transfer function becomes less sensitive to process variations for frequencies above the breakpoint frequency. For $K_{rc}=400000$, the nominal sensitivity peak is 22 dB or a magnitude of 12.5, which is very high. This conclusion could already be drawn from Table 2, where a phase margin of -4.28 is reached. For a gain of $K_{rc}=100000$, a nominal sensitivity peak of 3.5 is reached, which is still high but better than $K_{rc}=400000$. This decreasing trend continues as $K_{rc}$ decreases.

As the gain increases, the plots shift to the right, meaning the system becomes less sensitive to process variations at frequencies lower than the breakpoint frequency.

In conclusion, at low frequencies, increasing $K_{rc}$ is beneficial as it makes the closed-loop transfer function less sensitive to noise. However, the advantages at low frequencies are offset by disadvantages at higher frequencies near $M_s$, where the system becomes more prone to instability. At even higher frequencies beyond $M_s$, all plots converge to 0 dB, where $|S| = \left|\frac{1}{1+G_{cp} G_r}\right| = 1$, meaning the system is no more or less sensitive to process variations.

![P-regelaar_evaluatiemodel_S_nieuw](https://github.com/user-attachments/assets/d9a858b0-8b97-47ef-afd6-2bcad7d70a8d)
*Figure 1: Magnitude plot of the sensitivity function with P-controller for the evaluation model*

#### P-Controller: Design Model

The design model for the P-controller shows the same trends as the evaluation model. However, the maximum peak height is lower for each gain, meaning that by neglecting the dynamics of the electric coil, more stable behavior can be achieved near the $M_s$ frequencies for each gain.

![P-regelaar_ontwerpmodel_S_nieuw](https://github.com/user-attachments/assets/f62f5d2d-c27e-49c8-bfa5-b3c49dad2bfa)
*Figure 2: Magnitude plot of the sensitivity function with P-controller for the design model*

#### PI-Controller: Evaluation Model

For the PI-controller, the sensitivity continues to decrease at lower frequencies, meaning that the PI-controller is better at suppressing process noise than the P-controller, thereby better tracking the reference signal. Interestingly, for $K_{rc}=400000$, the $M_s$ is slightly lower than for $K_{rc}=100000$, meaning that for frequencies near $M_s$, the system with higher $K_{rc}$ is slightly more stable than with a lower $K_{rc}$ value.

![PI-regelaar_evaluatiemodel_S_nieuw](https://github.com/user-attachments/assets/381a08b2-5f5c-45ca-9528-f4ad038649ed)
*Figure 3: Magnitude plot of the sensitivity function with PI-controller for the evaluation model*

#### PI-Controller: Design Model

The same decreasing trend at lower frequencies can be observed for the design model.

![PI-regelaar_ontwerpmodel_S_nieuw](https://github.com/user-attachments/assets/6fa20ae7-b6b3-402a-a060-3232867374fd)

*Figure 4: Magnitude plot of the sensitivity function with PI-controller for the design model*


