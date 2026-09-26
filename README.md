# Generalized two dimensional principal component analysis by Lp-norm for image analysis. 

MATLAB algorithms and experiment functions for generalized two-dimensional PCA by Lp-norm.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-D4AF37?style=flat-square)](LICENSE)

Copyright (C) 2015 Jing Wang

Two demos:  
G2DPCA_demo_1, https://github.com/yuzhounh/G2DPCA_demo_1  
G2DPCA_demo_2, https://github.com/yuzhounh/G2DPCA_demo_2  
2018-6-13 22:58:14

For 1D algorithms, the image data should be 2D matrix, nSub $\times$ (height $\times$ width).   
For 2D algorithms, the image data should be 3D matrix, height $\times$ width $\times$ nSub.   
The images are listed in the subject-by-subject manner. Please refer to the manuscript for more information about the experiments, and refer to the 2DPCAL1-S toolbox (https://github.com/yuzhounh/2DPCAL1-S) for the main script.

## Prerequisites and Execution

This checkout provides algorithms and experiment functions, with no top-level `main.m` or bundled dataset. The [first demo](https://github.com/yuzhounh/G2DPCA_demo_1) and [second demo](https://github.com/yuzhounh/G2DPCA_demo_2) linked in the original documentation provide complete example workflows.

The core MATLAB function has the signature `W = G2DPCA(x, s, p, nPV)`. Prepare `x` as a three-dimensional image array; the implementation checks `s >= 1` and `p > 0`. The classification and reconstruction wrappers also require prepared `data/` files and an output `result/` directory.

## Variables
database, ORL or Feret (matching the case-sensitive strings used by the experiment functions)  
x,   image data  
lam, a tuning parameter in RSPCA or 2DPCAL1-S  
s,   a tuning parameter in GPCA or G2DPCA  
p,   a tuning parameter in GPCA or G2DPCA  
nPV, number of projection vectors to be calculated  
W,   projection vectors

## Repository Structure

- [G2DPCA.m](G2DPCA.m), [GPCA.m](GPCA.m), [PCA2DL1S.m](PCA2DL1S.m), and [RSPCA.m](RSPCA.m): algorithms.
- `classify_*.m` and `reco_*.m`: experiment functions.
- [manuscript.pdf](manuscript.pdf): accompanying paper.

## Major references
**PCA**: M. Turk and A. Pentland, “Eigenfaces for recognition,” Journal of cognitive neuroscience, vol. 3, no. 1, pp. 71–86, 1991.  
**PCA-L1**: N. Kwak, “Principal component analysis based on L1-norm maximization,” IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 30, no. 9, pp. 1672–1680, 2008.  
**RSPCA**: D. Meng, Q. Zhao, and Z. Xu, “Improve robustness of sparse PCA by L1-norm maximization,” Pattern Recognition, vol. 45, no. 1, pp. 487–497, 2012.  
**GPCA**: Z. Liang, S. Xia, Y. Zhou, L. Zhang, and Y. Li, “Feature extraction based on Lp-norm generalized principal component analysis,” Pattern Recognition Letters, vol. 34, no. 9, pp. 1037–1045, 2013.  
**2DPCA**: J. Yang, D. Zhang, A. F. Frangi, and J.-Y. Yang, “Two-dimensional PCA: a new approach to appearance-based face representation and recognition,” IEEE Transactions on Pattern Analysis and Machine
Intelligence, vol. 26, no. 1, pp. 131–137, 2004.  
**2DPCA-L1**: X. Li, Y. Pang, and Y. Yuan, “L1-norm-based 2DPCA,” IEEE Transactions on Systems, Man, and Cybernetics, Part B: Cybernetics, vol. 40, no. 4, pp. 1170–1175, 2010.  
**2DPCAL1-S**: H. Wang and J. Wang, “2DPCA with L1-norm for simultaneously robust and sparse modelling,” Neural Networks, vol. 46, no. 0, pp. 190–198, 2013.  
**G2DPCA**: J. Wang, “Generalized 2-D Principal Component Analysis by Lp-Norm for Image Analysis,” IEEE Transactions on Cybernetics, vol. 46, no. 3, pp. 792-803, 2016.   

## License

See the existing [GPL-3.0 license](LICENSE).

## Contact
Jing Wang  
wangjing0@seu.edu.cn  
yuzhounh@163.com  
2015-3-22 11:07:44
