"""
Date: Oct 25 2019
Author: Shaoju Wu
Edited by: Kianoosh Ghazi
Email: Kianoosh Ghazi@wpi.edu
see also: 
https://github.com/Jilab-biomechanics/CNN-brain-strains

"""
import numpy as np
import scipy.io
import tensorflow as tf
import keras
from keras.models import load_model
from scipy.io import loadmat
from scipy.io import savemat
from sklearn.metrics import mean_squared_error
from math import sqrt
import os

if __name__ == '__main__':
    
    ################# Loading testing profile with shape (N*3*201),where N is the number of profiles. 
    ################# Please check our preprocessing demo if you do not know how to obtain input profile format
    dirpath = os.getcwd()
    x = loadmat(dirpath+'/Input.mat')
    profile_CNN = x['pad_profile']
    
    ################# Reshape the dataset as N*3*201*1
    length_time = 201
    test_data = np.reshape(profile_CNN, (np.size(profile_CNN, 0), 6, length_time, 1))
    
    ################ Load the pre-trained models    
    mps_model = keras.models.load_model(dirpath+'\\pre_trained_model.h5', custom_objects={'error_func_with_mse': 'mean_squared_error'})
    
    ################ Summary of the CNN architecture
    mps_model.summary()
    
    ################ Predict MPS of the Whole brain
    predict_mps = mps_model.predict(test_data)
    
    ################ Save the predicted brain strain results in 'Output.mat'
    savemat(dirpath+'Output.mat', {'predict_mps': predict_mps})
    print("Predicted results successfully save in Output.mat")
