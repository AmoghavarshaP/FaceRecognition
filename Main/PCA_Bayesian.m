clc;
clear;
close all;

data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50
data_split = 0.5;

%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%%Performing PCA on the data:
[U,S,V] = svds(training_data,25);
%%Calling the bayes function:
delta = 1;
disp("PCA with Bayesian Classifier: ")
bayes_function(training_data,testing_data,delta,U,data_size,data_split);



