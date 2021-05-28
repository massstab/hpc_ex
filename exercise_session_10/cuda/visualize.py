import matplotlib
import matplotlib.pyplot as plt
from numpy import genfromtxt

c_output = genfromtxt('timing_plot.out', delimiter=',')
print(c_output)

cmap = plt.get_cmap('PiYG')

x = c_output[:,0]
y = c_output[:,1]
z = c_output[:,2]


fig, ax = plt.subplots()

# contours are *point* based plots, so convert our bound into point
# centers
cf = ax.scatter(x, y, c=z, s=100)
print(cf)

cbar = fig.colorbar(cf, ax=ax)
ax.set_title('Visualization of the obtained time dependence')
ax.axis('equal')
ax.set_xlabel('NUM_BLOCK')
ax.set_ylabel('NUM_THREAD')
cbar.set_label('duration in seconds')

# adjust spacing between subplots so `ax1` title and `ax0` tick labels
# don't overlap
fig.tight_layout()

plt.show()