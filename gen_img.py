import cv2 as cv
import numpy as np
import time
import datetime

save_path = './time_imgs/'
while 1:
    img_array = np.zeros((300,600),dtype='uint8')
    text = str(datetime.datetime.now())
    font_face = cv.FONT_HERSHEY_PLAIN
    font_scale = 2
    thickness = 2

    text_size = cv.getTextSize(text,font_face,font_scale,thickness)

    origin_x = (img_array.shape[1] - text_size[0][0])//2
    origin_y = (img_array.shape[0] + text_size[0][1])//2

    cv.putText(img_array,text,(origin_x,origin_y),font_face,font_scale,(255,255,255),thickness,8,0)

    cv.imwrite(save_path+str(time.time())+'.jpg',img_array)

    time.sleep(1)

