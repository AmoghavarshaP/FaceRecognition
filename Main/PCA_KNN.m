clc;
clear;
close all;

data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50
data_split = 0.5;
%Setting K Value
K=3;
%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%%Performing PCA on the data:
[U,S,V] = svds(training_data,25);
%%Calling the bayes function:
disp("PCA with KNN Classifier: "+ "--for K= "+K);
KNN_function(training_data,testing_data,K,U,data_size,data_split);
