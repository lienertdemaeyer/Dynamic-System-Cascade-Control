# Dynamic System: Cascade Control of Liquid Level in a Water Tank

## Table of Contents
- [Introduction](#introduction)
- [Transfer Function of the Solenoid Valve](#transfer-function-of-the-solenoid-valve)
  - [Transfer Function Evaluation Model](#transfer-function-evaluation-model)
  - [Transfer Function Design Model](#transfer-function-design-model)
- [Simulation of the Dynamic Behavior](#simulation-of-the-dynamic-behavior)
  - [State Equations](#state-equations)
  - [Simulation Without Position Control](#simulation-without-position-control)
  - [Simulation With Position Control](#simulation-with-position-control)
- [Figures](#figures)

## Introduction
This project focuses on the application of a dynamic system for cascade control of the liquid level in a water tank. It includes an in-depth analysis of a solenoid valve, which can control the inflow rate of liquid into a tank. The solenoid valve is represented as a mass-spring-damper system, with a proportional relationship between electric current and magnetic force. This project also includes mathematical derivations of system transfer functions and a state-space representation.

## Transfer Function of the Solenoid Valve
The solenoid valve in this system can be modeled as a mass-spring-damper system. Below, we derive its transfer function, both for an evaluation model that considers all dynamics, and a design model that simplifies the system.

### Transfer Function Evaluation Model
The equation of motion for the mechanical part of the solenoid valve, treated as a mass-spring-damper system, is given by:

$$m\frac{d^2x}{dt^2} + c\frac{dx}{dt} + kx = K_c i(t)$$

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




## Simulation of Solenoid Valve Dynamics

We define the states as follows:

$$
\begin{aligned}
    x_1 &= x \\
    x_2 &= \dot{x} \\
    x_3 &= i
\end{aligned}
$$

The state equations for the mechanical spool and the electric coil are:

$$
\begin{aligned}
    \dot{x}_2 &= -\frac{k}{m}x_1 - \frac{c}{m}x_2 + \frac{K_c}{m}x_3 \\
    \dot{x}_3 &= -\frac{K_e}{L}x_2 - \frac{R}{L}x_3 + \frac{v}{L}
\end{aligned}
$$

The state-space representation is:

$$
\begin{bmatrix}
\dot{x}_1 \\ \dot{x}_2 \\ \dot{x}_3
\end{bmatrix} =
\begin{bmatrix}
0 & 1 & 0 \\
-\dfrac{k}{m} & -\dfrac{c}{m} & \dfrac{K_c}{m} \\
0 & -\dfrac{K_e}{L} & -\dfrac{R}{L}
\end{bmatrix}
\begin{bmatrix}
x_1 \\ x_2 \\ x_3
\end{bmatrix}
+
\begin{bmatrix}
0 \\ 0 \\ \dfrac{1}{L}
\end{bmatrix} v
$$













