# CNN-estimation-of-brain-strain-distribution
CNN-estimation-of-brain-strain-distribution [[link of the paper]](https://www.liebertpub.com/doi/10.1089/neu.2020.7281).

This demo version is on a 4mm voxel-wise basis.

This page will be updated as needed. 

## Authors:
Kianoosh Ghazi, Shaoju Wu, Wei Zhao, and Songbai Ji

For technical questions, contact K. Ghazi: kghazi AT wpi dot edu

For collaboration inquries, contact S. Ji: sji AT wpi dot edu

## Prerequisites
- System: Windows/ MacOS/ Linux (e.g: Ubuntu 16.04)
- Matlab 2017 or above
- [Python 3.6](https://www.anaconda.com/distribution/)
- [Scikit-Learn](https://scikit-learn.org/stable/install.html)
- [Scipy](https://www.scipy.org/)
- [Keras 2.2.4](http://faroit.com/keras-docs/2.2.4/#installation)
- [Tensorflow 1.11.0](https://pypi.org/project/tensorflow/1.11.0/#files)
## Data preprocessing:
- Resampling the impact profile to 1 ms (temporal resolution) 
- Acquiring Acceleration
- Scaling Acceleration
- Conjugate axis transform (if needed)
- Shifting based on resultant rotational velocity peak location
- Replicated padding
- Acquiring Acceleration
- Scaling Acceleration
- Combining velocity and scaled acceleration

## Preprocessing demo:
A data preprocessing demo is provided in /1__Preprocessing folder.
- Go to /Preprocessing
- Run `demo_preprocessing.m` in Matlab

![](https://github.com/Jilab-biomechanics/CNN-estimation-of-brain-strain-distribution/blob/main/3__figures/1.jpg)

![](https://github.com/Jilab-biomechanics/CNN-estimation-of-brain-strain-distribution/blob/main/3__figures/2.jpg)

![](https://github.com/Jilab-biomechanics/CNN-estimation-of-brain-strain-distribution/blob/main/3__figures/3.jpg)

## Pretrained CNN models:
Pretrained CNN neural network model is provided based on all of the brain response samples available in the published study (N=5661). They correspond to the maximum principal strain (MPS) pattern of the whole brain. 

## Strain Prediction demo:
To use the pretrained CNN models for strain estimation, please check the strain prediction evaluation demo in /2__Strain_prediction folder
- Go to /2__Strain_prediction
- Download [[pre-trained model]](https://drive.google.com/drive/folders/1iYKKr1NCk6FwGG1Ax-26Ueb-ipxfy8ih?usp=sharing) to "2__Strain_prediction"
- Run `python demo_evaluation.py`. 
- **Input**: Notice that this demo uses `Evaluation_example.mat` as an example rotational velocity and acceleration profile input for evaluation. 
- **Output**: The output file will be saved as `Output.mat` in the /2__Strain_prediction folder.
![](https://github.com/Jilab-biomechanics/CNN-estimation-of-brain-strain-distribution/blob/main/3__figures/scatter_plot.JPG)

## Quick Run:
If you need to use your own rotational velocity input profile to estimate brain strains from the pretrained CNN models 
- Go to /2__Strain_prediction
- **Input**: Store your input as `pad_profile` (Check `demo_preprocessing.m` for detail) and save it as `Input.mat`
- Run `python predict_all.py`
- **Output**: The predicted outputs will be `predict_mps` (MPS of WB) saved in `Output.mat`. 
- You can easily modify the programs to batch process.

## Citation:
Please cite the following studies for the CNN data tool for brain strain pattern (Ref 1), our previous CNN  tool for peak brain strain (Ref 2), the model (Ref 3) if you apply in your study:
1. Ghazi K, Wu S, Zhao W, Ji S. Instantaneous Whole-brain Strain Estimation in Dynamic Head Impact. J Neurotrauma. 2020 Oct 30. doi: 10.1089/neu.2020.7281. Epub ahead of print. PMID: 33126836.
2. Wu, S., Zhao, W., Ghazi, K., Ji, S. 2019. Convolutional neural network for efficient estimation of  regional brain strains. Scientific Reports 9, 17326. [doi:10.1038/s41598-019-53551-1](https://www.nature.com/articles/s41598-019-53551-1)
3. Zhao, W., Ji, S., 2019. White matter anisotropy for impact simulation and response sampling in traumatic brain injury. J. Neurotrauma 36, 250–263. [doi:10.1089/neu.2018.5634 **front cover**](https://www.liebertpub.com/doi/abs/10.1089/neu.2018.5634) 

## Further development:
We would appreciate it if you can send us sample head impact kinematics data so that: (1) to verify that the CNN-estimated strains are sufficiently accurate relative to the directly simulated counterparts; and (2) to allow us expanding the training dataset to further improve the CNN estimation accuracy.

### Acknowledgement:
Funding is provided by the NIH Grant R01 NS092853 and the Ford University Research Program. The authors are grateful to the National Football League (NFL) Committee on Mild Traumatic Brain Injury (MTBI) and Biokinetics and Associates Ltd. for providing the reconstructed head impact data. They also thank Dr. David Camarillo at Stanford University and Dr. Adam Bartsch at Prevent Biometrics for sharing head impact data. The Titan X Pascal GPU used in this work was donated by the NVIDIA Corporation. 

### License:
CNN-estimation-of-brain-strain-distribution is an open-source library and is licensed under the [GNU General Public License (v3)](https://www.gnu.org/licenses/gpl-3.0.en.html). 
