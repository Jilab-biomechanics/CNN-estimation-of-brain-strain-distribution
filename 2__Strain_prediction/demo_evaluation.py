
"""
Date: Oct 06 2020
Author: Kianoosh Ghazi
Email: kghazi@wpi.edu
see also: 
Github link

"""
import numpy as np
import keras
from scipy.io import loadmat
from scipy.io import savemat
import os
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

def main():
    
    
    ################# Loading testing profile and ground truth labels simulated by WHIM 
    dirpath = os.getcwd()
    x = loadmat(dirpath+'\\input.mat')
    y = loadmat(dirpath+'\\voxel_labels.mat')

    voxel_labels = y['voxel_strains']
    profile_CNN = x['pad_profile']
    ################# Reshape the dataset as N*3*201*1, where N is the number of profiles
    length_time = 201
    test_data = np.reshape(profile_CNN, (np.size(profile_CNN, 0), 6, length_time, 1))
    
    ################ Load the pre-trained models    
    
    mps_model = keras.models.load_model(dirpath+'\\pre_trained_model.h5', custom_objects={'error_func_with_mse': 'mean_squared_error'})
    
    ################ Summary of the CNN architecture
    mps_model.summary()
    
    ################ Predict MPS of the Whole brain
    predict_mps = mps_model.predict(test_data)
    
    ################ predicted MPS vs. actual MPS from WHIM scatter
    plt.scatter(voxel_labels,predict_mps[0,:])
    
    ################ Comput the correlation coefficient between the predicted MPS and actual MPS from WHIM    
    test_r_mps = np.corrcoef(predict_mps[0,:], voxel_labels)
    test_r_mps = test_r_mps[1,0];
    print("r of predicted voxel_wise MPS: %f" % test_r_mps)
    ################ Comput the linear regression slope between the predicted MPS and actual MPS from WHIM    
    lin_reg = LinearRegression().fit(predict_mps[0,:].reshape(-1,1), voxel_labels.reshape(-1,1))
    test_k_mps = lin_reg.coef_
    print("k of predicted voxel_wise MPS: %f" % test_k_mps)
    
    ################ Save the predicted brain strain results in 'Output.mat'
    savemat(dirpath+'Output.mat', {'predict_mps': predict_mps})


# In[1]:
if __name__ == '__main__':
    
    main()
