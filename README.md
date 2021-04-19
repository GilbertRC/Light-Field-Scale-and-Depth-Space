# Light Field Scale and Depth Space (Lisad Space)
A simple reproduced version of Light Field Scale and Depth Space

&bull; Lisad-1: ray edge detection for 3D keypoints detection, just as the edge detection in EPI.
<br>
&bull; Lisad-2: ray detection for depth estimation, just as the blob detection in EPI.

### Demo:
<center>3D keypoints detection (hotter is closer)<img src=https://github.com/GilbertRC/Light-Field-Scale-and-Depth-Space/blob/main/result_buddha.jpg width="400"></center>

### Description (for example, Lisad-1 space):
&bull; Step 1: Extract epipolar plane image (EPI) in center view row (v=vC)
<br>
&bull; Step 2: Construct Lisad-1 space for 3D keypoints detection (convolved with first-order derivative Ray-Gaussian kernal)
<br>
&bull; Step 3: Find extreme points in Lisad-1 space

### References:
[1] I. Tosic, and K. Berkner, "3D keypoints detection by light field scale-depth space analysis," in *Proc. IEEE ICIP*, 2014, pp. 1927–1931. [link](https://ieeexplore.ieee.org/document/7025386/)
<br>
[2] I. Tosic, and K. Berkner, "Light field scale-depth space transform for dense depth estimation," in *Proc. IEEE CVPRW*, 2014, pp. 441–448. [link](https://ieeexplore.ieee.org/document/6910019)
