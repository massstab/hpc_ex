import matplotlib
import matplotlib.pyplot as plt
from numpy import genfromtxt

c_output = genfromtxt('timing_plot_1000x1000.out', delimiter=',')

x = c_output[:,0]
y = c_output[:,1]
print(x, y)

fig, ax = plt.subplots()

ax.scatter(x,y)

ax.set_title('Visualization of the obtained times with different block sizes')
ax.set_xlabel('NUM_BLOCK')
ax.set_ylabel('duration in s')

plt.savefig('plot.png')
plt.show()