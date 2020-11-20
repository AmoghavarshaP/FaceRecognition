%%This program includes subject classification tasks for Bayesian 
%% Bayesian Subject-Classification for Data.mat
clc;
clear;
close all;
data_set = '../Data/data.mat';
%200 subjects, each subject has 3 images, total of 600 images 
total_size = 200;
tic
x_train = get_subject_data('train',data_set,total_size);
x_test = get_subject_data('test',data_set,total_size);

%Number of classes for subject classification
classes = 200;

train_mu = zeros(size(x_train,1),classes); 
for i=1:classes
    train_mu(:, i) = (x_train(:,2*i-1) + x_train(:,2*i))/2;
end

tot_mu = zeros(size(x_train,1), 1);
for i=1:size(x_train,2)
    tot_mu = tot_mu + x_train(:,i);
end
tot_mu = 1/size(x_train,2) * tot_mu;

% Within scatter matrix
delta = 1;  
SW = zeros(size(x_train,1),size(x_train,1));
for i=1:classes
    for j=1:2
        S = (x_train(:,2*(i-1)+j) - train_mu(:,i) ) * ( x_train(:,2*(i-1)+j) - train_mu(:,i) ).';
    end
    S = S + delta * eye(size(x_train,1));
    SW = SW + S;
end

% Between scatter matrix
SB = zeros(size(x_train,1),size(x_train,1));
for i=1:classes
   SB = SB + 2 * ( train_mu(:,i) - tot_mu ) * ( train_mu(:,i) - tot_mu ).';  
end

[W,EV] = eigs(SB,SW,200);
%Transforming the training and testing data -- Dimension reduction
x_train_LDA = W'*x_train;
x_test_LDA =  W'*x_test;
disp("Please be patient this takes time")
disp("Bayesian Classifier with MDA: ");
Bayes_subject_func(x_train_LDA,x_test_LDA,delta);

%Subject Classification with PCA
[U,S,V] = svds(x_train,200);
x_train_PCA = U'*x_train;
x_test_PCA =  U'*x_test;
disp("Bayesian Classifier with PCA: ");
Bayes_subject_func(x_train_PCA,x_test_PCA,delta);

