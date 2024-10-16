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

## Simulation of the Dynamic Behavior

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

### Simulation Without Position Control
In this part, we simulate the system's behavior without a feedback position controller. The simulation involves step changes in the input voltage and analysis of the resulting flow rate and valve position.

### Simulation With Position Control
The system was also simulated using a proportional (P) and proportional-integral (PI) controller to maintain a desired valve position. The impact of different controller parameters on system dynamics and stability was analyzed.

## Figures

Below are placeholders for figures that illustrate key results from the project. Please replace the placeholders with the appropriate project images.

- ![Figure 1: Dynamic System Setup](images/figure1_placeholder.png)
- ![Figure 2: Transfer Function Response](images/figure2_placeholder.png)
- ![Figure 3: State-Space Simulation](images/figure3_placeholder.png)
- ![Figure 4: Simulation Without Control](images/figure4_placeholder.png)
- ![Figure 5: Simulation With PI Controller](images/figure5_placeholder.png)
