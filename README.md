# Efficient subspace clustering of hyperspectral images using similarity-constrained sampling

## Abstract

The unsupervised classification of hyperspectral images (HSIs) draws attention in the remote sensing community due to its inherent complexity and the lack of labeled data. Among unsupervised methods, sparse subspace clustering (SSC) achieves high clustering accuracy by constructing a sparse affinity matrix. However, SSC has limitations when clustering HSI images due to the number of spectral pixels. Specifically, the temporal complexity grows at a cubic ratio of the size of the data, making it inefficient for addressing HSI subspace clustering. We propose an efficient SSC-based method that significantly reduces the temporal and spatial computational complexity by splitting the HSI clustering task using similarity-constrained sampling. Our sim- ilarity-constrained sampling strategy considers both edge and superpixel information of the HSI to boost the clustering performance. This sampling strategy enables an intelligent selection of spectral signatures, and then, we split the clustering problem into multiples threads. Experimental results on widely used HSI datasets show that the efficiency of the proposed method outperforms baseline methods by up to 30% in overall accuracy and up to six times in computing time.

### This repository contains the MatLab codes of this paper. 


You can Download the HSI from: https://www.ehu.eus/ccwintco/index.php/Hyperspectral_Remote_Sensing_Scenes and copy in Data path.


Run the main file to preform Subspace clustering with efficiente similrity constrain

# License

This code package is licensed under the GNU GENERAL PUBLIC LICENSE (version 3) - see the Lisence file for details.
