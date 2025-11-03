# Joel Kojma

import numpy as np

import matplotlib.pyplot as plt

# Define the function f(x) = e^x * ln(1 + e^(-x))
def f(x):
    return np.exp(x) * np.log(1 + np.exp(-x))

# Create x values
x = np.linspace(-50, 50, 1000)

# Calculate y values
y = f(x)

# Create the plot
plt.figure(figsize=(10, 6))
plt.plot(x, y, 'b-', linewidth=2)
plt.grid(True, alpha=0.3)
plt.xlabel('x')
plt.ylabel('f(x)')
plt.title(r'$f(x) = e^x \ln(1 + e^{-x})$')
plt.show()