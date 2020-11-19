%%This program includes subject classification tasks for both Bayesian 
%% Bayesian Subject-Classification for Data.mat
clc;
clear;
close all;
data_set = 'data.mat';
%200 subjects, each subject has 3 images, total of 600 images 
total_size = 200;

x_train = get_subject_data('train',data_set,total_size);
x_test = get_subject_data('test',data_set,total_size);


%Training the bayesian subject classification model:
mu = [];
for i = 1:size(x_train,2)/2
        train_mu1 = (x_train(:,i)+x_train(:,i+1))/2*size(x_train(:,1),2);
        mu = [mu train_mu1];
        
end
test = cov(mu(:,1)');  
train_mu = sum(x_train,2)/size(x_train,2);
cov = [];
x = [1:size(x_train,2)/2];
for i = 1:length(x)
    disp(i);
    temp = mu(:,i)';
    covar = cov(temp);
end

train_cov = cov(x_train');
%Regularization of the covariance matrix
delta = 1;
train_cov = train_cov + delta.*eye(size(train_cov));
det_train_cov = det(train_cov);

if det(train_cov)== 0
    disp('singular')
    pause
end

%To calculate the inverse of the covariance
inv_train_cov = pinv(train_cov);

%Testing:
accuracy = 0;
for i = 1:size(x_test,2)
    Posterior = [];
    for j = 1:size(x_test,2)        
         P_test = (1/sqrt(2*pi*det_train_cov))*exp(-0.5*(x_test(:,j)-train_mu)'*inv_train_cov*(x_test(:,j)-train_mu));
         Posterior = [Posterior P_test];
    end
    [~,index] = max(Posterior);
    if index == i
        disp('correct classification')
        accuracy = accuracy+1;
    else
        disp('incorrect classification')
    end
    
end

disp("Bayesian Classifier Accuracy is: ");
disp((accuracy/size(x_test,2))*100);