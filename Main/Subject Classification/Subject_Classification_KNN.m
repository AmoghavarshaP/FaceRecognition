%% KNN Subject-Classification for Data.mat
clc;
clear;
close all;
tic
data_set = '../Data/data.mat';
%200 subjects, each subject has 3 images, total of 600 images 
total_size = 200;
K=2;
x_train = get_subject_data('train',data_set,total_size);
x_test = get_subject_data('test',data_set,total_size);

train_labels = zeros(size(x_train,2),1);
test_labels  = zeros(size(x_test,2),1);

%Setting labels to the training data
for i = 1:size(x_train,2)/2
    train_labels(2*i-1)  = i;
    train_labels(2*i) = i;
end

%Setting labels to testing data
for i = 1:size(x_test,2)
    test_labels(i)  = i;
end

solution = zeros(200,1);
for i = 1:200
    min_value = (x_test(:,i)-x_train(:,1))'*(x_test(:,i) - x_train(:,1));
    for j = 1:400
        if (x_test(:,i)-x_train(:,j))'*(x_test(:,i) - x_train(:,j)) <= min_value
            min_value = (x_test(:,i)-x_train(:,j))'*(x_test(:,i) - x_train(:,j));
            solution(i) = train_labels(j);
        end
    end
end

accuracy = 0;
for i=1:size(x_test,2)
    if solution(i) == test_labels(i)
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy/size(x_test,2))*100;
disp("KNN Accuracy:")
display(accuracy);
%% With LDA
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
x_train_LDA = W'*x_train;
x_test_LDA = W'*x_test;
%Testing
solution = zeros(200,1);
for i = 1:200
    min_value = (x_test_LDA(:,i)-x_train_LDA(:,1))'*(x_test_LDA(:,i) - x_train_LDA(:,1));
    for j = 1:400
        if (x_test_LDA(:,i)-x_train_LDA(:,j))'*(x_test_LDA(:,i) - x_train_LDA(:,j)) <= min_value
            min_value = (x_test_LDA(:,i)-x_train_LDA(:,j))'*(x_test_LDA(:,i) - x_train_LDA(:,j));
            solution(i) = train_labels(j);
        end
    end
end

accuracy = 0;
for i=1:size(x_test_LDA,2)
    if solution(i) == test_labels(i)
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy/size(x_test_LDA,2))*100;
disp("KNN Subject Classifier with LDA Accuracy:")
display(accuracy);

%% PCA with KNN
[U,S,V] = svds(x_train,200);
x_train_PCA = U'*x_train;
x_test_PCA =  U'*x_test;

solution = zeros(200,1);
for i = 1:200
    min_value = (x_test_PCA(:,i)-x_train_PCA(:,1))'*(x_test_PCA(:,i) - x_train_PCA(:,1));
    for j = 1:400
        if (x_test_PCA(:,i)-x_train_PCA(:,j))'*(x_test_PCA(:,i) - x_train_PCA(:,j)) <= min_value
            min_value = (x_test_PCA(:,i)-x_train_PCA(:,j))'*(x_test_PCA(:,i) - x_train_PCA(:,j));
            solution(i) = train_labels(j);
        end
    end
end

accuracy = 0;
for i=1:size(x_test_PCA,2)
    if solution(i) == test_labels(i)
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy/size(x_test_LDA,2))*100;
disp("KNN Subject Classifier with PCA: ");
display(accuracy);


