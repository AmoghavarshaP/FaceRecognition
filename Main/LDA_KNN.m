clc;
clear;
close all;
data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50 split
%try 0.25,0.75
data_split = 0.5;
K=7;
%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%Defining X_train, X_train to include both classes from the training and testing data resplecively
%X_train = [x_neutral x_expression]; X_test = [x_neutral x_expression]
x_train = [training_data(:,1:3:3*data_size*data_split) training_data(:,2:3:3*data_size*data_split)];
x_test = [testing_data(:,1:3:3*data_size*(1-data_split)) testing_data(:,2:3:3*data_size*(1-data_split))];

%To calculate the mean value for the neutral and expression classes
neutral_mu = sum(training_data(:,1:3:3*data_size*data_split),2)/size(training_data(:,1:3:3*data_size*data_split),2);
expression_mu = sum(training_data(:,2:3:3*data_size*data_split),2)/size(training_data(:,2:3:3*data_size*data_split),2);

%To calculate the covariances for the both the classes and get the total
neutral_cov = cov(training_data(:,1:3:3*data_size*data_split)');
expression_cov = cov(training_data(:,2:3:3*data_size*data_split)');

total_cov = neutral_cov + expression_cov;

%Inverse of the total covariance 
inv_total_cov = pinv(total_cov);

%Direction of projection or theta for the data
theta = inv_total_cov.*(neutral_mu-expression_mu);

%Calling KNN Function
disp("LDA with KNN Classifier: "+ "--for K= "+K);
KNN_function(training_data,testing_data,K,theta,data_size,data_split);