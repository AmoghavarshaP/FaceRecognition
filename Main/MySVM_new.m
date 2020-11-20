clc;
clear;
close all;
data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50 split
%try 0.25,0.75
data_split = 0.5;

%Set the slack parameter
C = 1;
%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%Defining X_train, X_train to include both classes from the training and testing data resplectively
%X_train = [x_neutral x_expression]; X_test = [x_neutral x_expression]
xtrain_neutral = training_data(:,1:3:3*data_size*data_split);
xtrain_expression = training_data(:,2:3:3*data_size*data_split);
x_train = [xtrain_neutral xtrain_expression]';
x_test = [testing_data(:,1:3:3*data_size*(1-data_split)) testing_data(:,2:3:3*data_size*(1-data_split))];

%To solve the dual optimization problem: Matlab Function Quagprog
%x = quadprog(H,f,A,b,Aeq,beq,lb,ub)
%defining all the parameters as required for the function
%Also need to create labels for the data
neutral_label = ones(1,size(xtrain_neutral,2))'; %--- Setting +1 for neutral
expression_label = -ones(1,size(xtrain_expression,2))';
labels = [neutral_label;expression_label];

%Defining the H matrix --Quadratic objective term, specified as a symmetric real matrix.
%H represents the quadratic in the expression 1/2*x'*H*x + f'*x
H = (x_train*x_train').*(labels*labels');
f = -ones(size(x_train,1),1);
A=[];
b =[];
%Aeq = [labels';zeros((size(x_train,1)-1),size(x_train,1))];
Aeq = [labels';zeros(size(x_train,1)-1,size(x_train,1))];
beq = zeros(size(x_train,1),1);

%To set the bounds for the problem
lb = zeros(size(x_train,1),1);
ub = C*ones(size(lb));

alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub);

theta = ((alpha.*labels)'*x_train)';

% looking for random index of non-zero mu value (support-vector) to use it
% to find the bias (theta0)
[~,index] = max(alpha);
theta0 = (1/labels(index)) - theta'*x_train(index,:)';
acc = 0;
for i = 1:size(x_test,2)

    if i <= size(x_test,2)/2
        true_label = 1;
    else
        true_label = -1;
    end
    value = theta'*x_test(:,i) + theta0;
    % using the test image in the linear predictor

    prediction = value*true_label;

    if prediction > 0
        acc = acc+1;
    end
end
accuracy = (acc/size(x_test,2))*100;
disp('base accuracy:');
disp(accuracy);


