# -*- coding: utf-8 -*-

"""
This script calculate the dominant color from 8 distinct colors in any RGB images
"""

import cv2
import numpy as np
import matplotlib.pyplot as plt

plt.close("all")

filename = 'green.jpg'                            # File name
img = cv2.imread(filename,1)                    # Read the RGB image
(x1,y1,k) = img.shape                           # Image dimensions
#img = cv2.resize(img,(int(x1/2), int(y1/2)))   # Resize the image
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)      # Convert it to HSV color space
hue = hsv[:,:,0]                                # Extract Hue layer
(x,y) = hue.shape                               # Hue dimensions
hue = ( hue/hue.max() )* 360                    # Map the value between (0,360)


r_limit = [12,321];     # Red range
o_limit = [13, 32];     # Orange range
y_limit = [33, 64];     # Yellow range
g_limit = [65, 150];    # Green range
c_limit = [151, 200];   # Cheightan range
b_limit = [201, 260];   # Blue range
pu_limit = [261, 290];  # Purple range
p_limit = [291, 320];   # Pink range


# Initialize counter for each color
Red = np.zeros(y)
Orange = np.zeros(y)
Yellow = np.zeros(y)
Green = np.zeros(y)
Cyan = np.zeros(y)
Blue = np.zeros(y)
Purple = np.zeros(y)
Pink = np.zeros(y)
White = np.zeros(y)
Black = np.zeros(y)

# Colors list
c_list = ['Red', 'Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Purple',
          'Pink'];

     
      
for i in range(x):
    for j in range(y):
        
        # If red
        if (hue[i,j] >= r_limit[1] or hue[i,j] <= r_limit[0] and hue[i,j] != 0):
            Red[j] += 1 

        # If orange
        if (hue[i,j] >= o_limit[0] and hue[i,j] <= o_limit[1] ):
            Orange[j] += 1

        # If yellow
        if (hue[i,j] >= y_limit[0] and hue[i,j] <= y_limit[1] ):
            Yellow[j] += 1

        # If green
        if (hue[i,j] >= g_limit[0] and hue[i,j] <= g_limit[1] ):
            Green[j] += 1
            
        # If cyan
        if (hue[i,j] >= c_limit[0] and hue[i,j] <= c_limit[1] ):
            Cyan[j] += 1
                      
        
        # If blue
        if (hue[i,j] >= b_limit[0] and hue[i,j] <= b_limit[1] ):
            Blue[j] += 1
        
        # If purple
        if (hue[i,j] >= pu_limit[0] and hue[i,j] <= pu_limit[1] ):
            Purple[j] += 1
          
        # If pink
        if (hue[i,j] >= p_limit[0] and hue[i,j] <= p_limit[1]):
            Pink[j] += 1
        

# Create a counter variable for all colors 
counter = np.array([Red, Orange, Yellow, Green, Cyan, Blue, Purple,Pink]) 

# Sum all color counters 
counter_sum = np.array([np.sum(Red), np.sum(Orange), np.sum(Yellow),
                        np.sum(Green), np.sum(Cyan), np.sum(Blue),
                        np.sum(Purple),np.sum(Pink)]) 
    

# Plot Number Of Pixels Of Eache Color Vs Column     
fig = plt.figure()
plt.grid(color=(128/255, 128/255, 128/255), linestyle='-', linewidth=0.5)
xx = np.arange(0, y, 1)
plt.plot(xx,Red,color="red")
plt.plot(xx,Orange, color=(230/255, 115/255, 0))
plt.plot(xx,Yellow,color=(255/255, 191/255, 0))
plt.plot(xx,Green,color=(26/255, 194/255, 0))
plt.plot(xx,Cyan, color=(0, 194/255, 171/255))
plt.plot(xx,Blue, color=(31/255, 87/255, 255/255))
plt.plot(xx,Purple,color=(161/255, 0, 230/255))
plt.plot(xx,Pink, color=(230/255, 0, 157/255))
plt.legend(c_list)
plt.ylim(ymin=0)
plt.xlim(xmin=0)
plt.xlabel('Column Number',fontsize=15)
plt.ylabel('Total Number Of Pixels At That Column',fontsize=15)
plt.title('Number Of Pixels Of Eache Color Vs Column',fontsize=20)
plt.show()


# Creat a color histogram
fig2, ax = plt.subplots()
ind = np.arange(1, 9)
(p1, p2, p3, p4, p5, p6, p7, p8) = plt.bar(ind, counter_sum)
p1.set_facecolor('r')
p2.set_facecolor((230/255, 115/255, 0))
p3.set_facecolor((255/255, 191/255, 0))
p4.set_facecolor((26/255, 194/255, 0))
p5.set_facecolor((0, 194/255, 171/255))
p6.set_facecolor((31/255, 87/255, 255/255))
p7.set_facecolor((161/255, 0, 230/255))
p8.set_facecolor((230/255, 0, 157/255))
ax.set_xticks(ind)
ax.set_xticklabels(c_list)
ax.set_ylabel('Total Number Of Pixels',fontsize=15)
ax.set_title('Histogram',fontsize=20)

# Print the dominiat color
id1 = np.argmax(counter_sum)
val = np.max(counter_sum)/(x*y)

print('The dominiat color is {} with ratio of {:.4f}'.format(c_list[id1], val))
