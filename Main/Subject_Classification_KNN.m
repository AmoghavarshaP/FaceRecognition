%% KNN Subject-Classification for Data.mat
clc;
clear;
close all;
data_set = 'data.mat';
%200 subjects, each subject has 3 images, total of 600 images 
total_size = 200;

x_train = get_subject_data('train',data_set,total_size);
x_test = get_subject_data('test',data_set,total_size);

K = 2;

