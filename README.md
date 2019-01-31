# LG-R100-VR-360 for Reshade

![alt text](https://imgur.com/YDiRP09.png)

  * Simple Reshade shader to rotate **2D monoscopic** (Simple_LG_R100_2D.fx) or **3D SBS** (Simple_LG_R100_SBS.fx) content for use with the LG R100 (VR 360) HMD.
Typically should be last in Reshade's order.

  * Recommended to combine with BlueSkyDefender's Polynomial-Barrel-Distortion shader to fix the HMD's (minimal) distortion, and/or aspect ratio when using non-native resolutions (as in not 1440x960, e.g. 1080p/1440p):
https://github.com/BlueSkyDefender/Depth3D/blob/master/Shaders/Polynomial_Barrel_Distortion.fx
