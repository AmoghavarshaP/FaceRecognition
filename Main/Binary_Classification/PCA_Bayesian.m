clc;
clear;
close all;

data_set = '../Data/data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50
data_split = 0.5;

%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%%Performing PCA on the data:
[U,S,V] = svds(training_data,90);
%%Calling the bayes function:
%Transforming the training and testing data -- Dimension reduction
training_data = U'*training_data;
testing_data = U'*testing_data;
%Calling Bayes function
delta = 1;
disp("PCA with Bayesian Classifier: ")
bayes_function(training_data,testing_data,delta,data_size,data_split);

% 
% %Visulization
% components = [10, 15, 20,25,30,40,45,50,60,75];
% accuracy = [81, 85.5, 88,88,88,86.5,88.5,88,88,86.5];
% vector = [components' accuracy_vector'];
% plot(vector(:,1),vector(:,2));
% title("Bayesian Classifier with PCA: Accuracy")
% xlabel("Number of Components");
% ylabel("Accuracy(%)")



