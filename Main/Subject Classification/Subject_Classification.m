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
%mu = [];
%covariance = [];
%for i = 1:size(x_train,2)
%        if mod(i,2) == 1 
%           train_mu1 = (x_train(:,i)+x_train(:,i+1))/2*size(x_train(:,1),2);
%           mu = [mu train_mu1]; 
%        end
        
        %covar = cov(train_mu1);
        %covariance = [covariance covar];    
%end

%test = cov(mu(:,1)');  
%train_mu = sum(x_train,2)/size(x_train,2);
%train_cov = cov(x_train');
%set = x_test(:,1)-train_mu;
%cov = [];
%x = [1:size(x_train,2)/2];
%for i = 1:length(x)
%    disp(i);
%    temp = mu(:,i)';
%    covar = cov(temp);
%end

%Training the bayesian subject classification model:
covariance = [];
delta = 1;
for i = 1:size(x_train,2)/2
    train_mu(:,i) = (x_train(:,2*i-1))+x_train(:,2*i)/2;
    train_cov(:,:,i)= (((x_train(:,2*i-1)-train_mu(:,i))*transpose((x_train(:,2*i-1)-train_mu(:,i))))+((x_train(:,2*i)-train_mu(:,i))*transpose((x_train(:,2*i)-train_mu(:,i)))))/2;
    train_cov(:,:,i)= train_cov(:,:,i) + delta.*eye(size(train_cov,1));
    inv_train_cov(:,:,i)=pinv(train_cov(:,:,i));  
end

%Testing:
accuracy = 0;
for i = 1:size(x_test,2)
    Posterior = [];
    for j = 1:size(x_test,2)        
         P_test(i,j) = (1/sqrt(2*pi*det(train_cov(:,:,j))))*exp(-0.5*(x_test(:,i)-train_mu(:,j))'*inv_train_cov(:,:,j)*(x_test(:,i)-train_mu(:,j)));
   
    end
    [~,index] = max(P_test(i,:));
    if index == i
        disp('correct classification')
        accuracy = accuracy+1;
    else
        disp('incorrect classification')
    end
    
end

disp("Bayesian Classifier Accuracy is: ");
disp((accuracy/size(x_test,2))*100);
toc