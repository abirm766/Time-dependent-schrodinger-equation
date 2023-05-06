# Numerical Solution to Time Dependent Schrödinger Equation
1D time dependent Schrödinger equation is solved using **Finite Difference** method. For visualization, two simple cases of Step and Barrier potential is chosen. The computation is implemented in **Julia** (1.5.3 or later).  
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
Set, $a=\frac{i\Delta t}{2}$ and $b=\frac{i\Delta t}{4\Delta x^2}=\frac{a}{2\Delta x^2}$. Hence,
$$\Psi_k^{n+1}-\Psi_k^n=b\left(\Psi_{k-1}^n-2\Psi_k^n+\Psi_{k+1}^n+\Psi_{k-1}^{n+1}-2\Psi_k^{n+1}+\Psi_{k+1}^{n+1}\right)-aV_k\left(\Psi_k^n+\Psi_k^{n+1}\right)$$
$$\Rightarrow -b\Psi_{k-1}^{n+1}+\left(1+2b+aV_k\right)\Psi_k^{n+1}-b\Psi_{k+1}^{n+1}=b\Psi_{k-1}^n+\left(1-2b-aV_k\right)\Psi_k^n+b\Psi_{k+1}^n \quad (5)$$
Eq. (5) can be written in terms of Banded matrices,  
```math
\underbrace{\begin{pmatrix}
  1+2b+aV_1 & -b & 0 & \cdots & \cdots & 0 \\
  -b & 1+2b+aV_2 & -b & \ddots & \ddots & \vdots \\
  0  & \ddots  & \ddots & \ddots & \ddots & \vdots  \\
  \vdots  & \ddots  & \ddots & \ddots & \ddots & 0  \\
  \vdots  & \ddots  & \ddots & -b & \ddots & -b  \\
  0  & \cdots  & \cdots & 0 & -b & a+2b+aV_k  
 \end{pmatrix}}_A
 \underbrace{\begin{pmatrix}
    \Psi_1^{n+1}\\
    \Psi_2^{n+1}\\
    \vdots \\
    \vdots \\
    \vdots \\
    \Psi_k^{n+1}
\end{pmatrix}}_{\Psi^{n+1}} =  
```  
```math  
\underbrace{\begin{pmatrix}
  1-2b-aV_1 & b & 0 & \cdots & \cdots & 0 \\
  b & 1-2b-aV_2 & b & \ddots & \ddots & \vdots \\
  0  & \ddots  & \ddots & \ddots & \ddots & \vdots  \\
  \vdots  & \ddots  & \ddots & \ddots & \ddots & 0  \\
  \vdots  & \ddots  & \ddots & b & \ddots & b  \\
  0  & \cdots  & \cdots & 0 & b & a-2b-aV_k  
 \end{pmatrix}}_B
 \underbrace{\begin{pmatrix}
    \Psi_1^n\\
    \Psi_2^n\\
    \vdots \\
    \vdots \\
    \vdots \\
    \Psi_k^n
\end{pmatrix}}_{\Psi^n}
```  
Thus, the effective matrix equation,
$$\Psi^{n+1}=A^{-1}B\Psi^n \quad (6)$$  
Hence, the problem is reduced to solving Eq. (6). This matrix equation is solved for the above two potential using a Gaussian wave packet $\Psi^0$ to start with,
$$\Psi(x, 0) = e^{ikx}exp\left[-\frac{(x-\mu)^2}{\sigma}\right]$$  
## Result  
### Step potential  
![](https://github.com/abirm766/time-dependent-schrodinger-equation/blob/main/tdse_step.gif)  
### Barrier potential  
![](https://github.com/abirm766/time-dependent-schrodinger-equation/blob/main/tdse_barr.gif)
