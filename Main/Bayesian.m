clc;
clear;
close all;
data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50 split
%try 0.25,0.75
data_split = 0.5;

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

%To calculate the covariances for the both the classes
neutral_cov = cov(training_data(:,1:3:3*data_size*data_split)');
expression_cov = cov(training_data(:,2:3:3*data_size*data_split)');

%To find the determinants of the covariance and also regularization of the
%covariances 
delta = 1;
neutral_cov = neutral_cov + delta.*eye(size(neutral_cov));
expression_cov = expression_cov +  delta.*eye(size(neutral_cov));
det_neutral_cov = det(neutral_cov);
det_expression_cov=det(expression_cov);

%To calculate the inverse of the covariances
inv_neutral_cov = pinv(neutral_cov);
inv_expression_cov = pinv(expression_cov);

%Now for the testing:
%First we assign the labels to the testing set
%The way the data is stuctures is that the first images 100 neutral and the
%next 100 are expreesion, so assigning neutral +1 and expression -1
accuracy = 0;
for n = 1:size(x_test,2)
    if n <= size(x_test,2)/2
        true_label = 1;
    else
        true_label = -1;
    end
    %Next, to calculate the posteriors for both the neutral and the expression
    %classes 
    P_neutral = (1/sqrt(2*pi*det_neutral_cov))*exp(-0.5*(x_test(:,n)-neutral_mu)'*inv_neutral_cov*(x_test(:,n)-neutral_mu));
    P_expression = (1/sqrt(2*pi*det_expression_cov))*exp(-0.5*(x_test(:,n)-expression_mu)'*inv_expression_cov*(x_test(:,n)-expression_mu));
    
    %appending the posteriors to with labels
    Posterior = [P_neutral 1;P_expression -1];
    %finding max of the two posterior probabilities
    [~,index] = max(Posterior(:,1));
    
    %proper labelling for comparison
    if index == 1
        computed_label = 1;
    elseif index == 2
        computed_label = -1;
    end
    
    %comparison of labels
    if true_label*computed_label == 1  
        accuracy = accuracy+1;
    end
end

disp("Bayesian Classifier Accuracy is: ");
disp((accuracy/size(x_test,2))*100);




