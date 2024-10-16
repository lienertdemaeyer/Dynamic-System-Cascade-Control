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
2. 
   $$
   1 + KG(s) = 1 + \frac{K(s+1)}{s^4+4s^3+6s^2+4s} = 0
   $$

3. **Factorization**: Factor the numerator and denominator:
4. 
   $$
   1 + KG(s) = 1 + \frac{K(s+1)}{s(s+2)(s+1 \pm j)}
   $$

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
     $$
     \sigma_c = -\frac{\sum z_i - \sum p_j}{n-m} = -1
     $$
   - The asymptote angles are:
     - $k=0$: $\vartheta_0 = 60^\circ$
     - $k=1$: $\vartheta_1 = 180^\circ$
     - $k=2$: $\vartheta_2 = 300^\circ$

#### Pole-Zero Plot

The final pole-zero plot for Transfer Function 1 is shown below:

![pb1](https://github.com/user-attachments/assets/d78e3acb-6932-45cf-96d1-e5faacec3d87)



