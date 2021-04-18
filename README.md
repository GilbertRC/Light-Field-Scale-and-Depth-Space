# Light Field Scale and Depth Space (Lisad Space)
A simple reproduced version of Light Field Scale and Depth Space

&bull; Lisad-1 can be used to detect 3D keypoints as the ray edge detection (edge detection) in EPI.
<br>
&bull; Lisad-2 can be used to estimate the depth map as the ray detection (blob detection) in EPI.

### Demo:
<img src=https://github.com/GilbertRC/Light-Field-Scale-and-Depth-Space/blob/main/result_buddha.jpg>
3D keypoints detection (hotter is closer)

### Description (for example, Lisad-1 space):
#### Step1: Extract epipolar plane image (EPI) in center view row (v=vC)
#### Step2: Construct Lisad-1 space for 3D keypoints detection (ray edge detection)
#### Step3: Find extreme points in Lisad-1 space

### References:
[1] I. Tosic, and K. Berkner, "3D keypoints detection by light field scale-depth space analysis," in *Proc. IEEE ICIP*, 2014, pp. 1927–1931.
<br>
[2] I. Tosic, and K. Berkner, "Light field scale-depth space transform for dense depth estimation," in *Proc. IEEE CVPRW*, 2014, pp. 441–448.
