# Numerical Solution to Time Dependent Schrödinger Equation
1D time dependent Schrödinger equation is solved using **Finite Difference** method. For visualization, two simple cases of Step and Barrier potential is chosen. The computation is implemented in Julia (1.5.3 or later).  
### Step Potential:  
$$\ V(x) =
  \begin{cases}
    0       & \quad x<0\\
    1  & \quad x\ge1
  \end{cases}
\$$
### Barrier Potential:  
$$\ V(x) =
  \begin{cases}
    0       & \quad x<0\\
    1  & \quad 0\le x\le 1\\
    0       & \quad x>1\\
  \end{cases}
\$$
## Solution  
We have the Time Dependent Schrödinger Equation:  
$$i\hbar\frac{\partial}{\partial t}\Psi(x, t)=-\frac{\hbar^2}{2m}\frac{\partial^2}{\partial x^2}\Psi(x, t)+V(x)\Psi(x, t) \quad (1)$$
For ease of calculation set $\hbar$ and $m$ to unity. Using this rewrite Eq. (1) as,  
$$\frac{\partial}{\partial t}\Psi(x, t)=\frac{i}{2}\frac{\partial^2}{\partial x^2}\Psi(x, t)-iV(x)\Psi(x, t) \quad (2)$$
Now replace the derivatives with their discrete analogs using forward difference formula,   
$$\frac{\partial^2 \Psi}{\partial x^2}\equiv \frac{\Psi_{k-1}^n-2\Psi_k^n+\Psi_{k+1}^n}{\Delta x^2}$$  
$$\frac{\partial \Psi}{\partial t}\equiv \frac{\Psi_k^{n+1}-\Psi_k^n}{\Delta t}$$  
Here, $n$ is the time index and $k$ is the position index. Thus,  
$$\frac{\Psi_k^{n+1}-\Psi_k^n}{\Delta t}=\frac{i}{2\Delta x^2}\left(\Psi_{k-1}^n-2\Psi_k^n+\Psi_{k+1}^n\right)-iV_k\Psi_k^n \quad (3)$$  
$$\frac{\Psi_k^{n+1}-\Psi_k^n}{\Delta t}=\frac{i}{2\Delta x^2}\left(\Psi_{k-1}^{n+1}-2\Psi_k^{n+1}+\Psi_{k+1}^{n+1}\right)-iV_k\Psi_k^{n+1} \quad (4)$$  
Add Eq. (3) and Eq. (4),  
$$\Psi_k^{n+1}-\Psi_k^n=\frac{i\Delta t}{4\Delta x^2}\left(\Psi_{k-1}^n-2\Psi_k^n+\Psi_{k+1}^n+\Psi_{k-1}^{n+1}-2\Psi_k^{n+1}+\Psi_{k+1}^{n+1}\right)-i\frac{i\Delta t}{2}V_k\left(\Psi_k^n+\Psi_k^{n+1}\right)$$
