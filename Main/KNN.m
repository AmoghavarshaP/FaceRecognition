clc;
clear;
close all;
data_set = 'data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50 split
%try 0.25,0.75
data_split = 0.5;
%%Setting K value
K=3;

%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%Defining X_train, X_train to include both classes from the training and testing data resplecively
%X_train = [x_neutral x_expression]; X_test = [x_neutral x_expression]
x_neutral = training_data(:,1:3:3*data_size*data_split);
x_expression = training_data(:,2:3:3*data_size*data_split);
x_train = [x_neutral x_expression];
%x_train = [training_data(:,1:3:3*data_size*data_split) training_data(:,2:3:3*data_size*data_split)];
x_test = [testing_data(:,1:3:3*data_size*(1-data_split)) testing_data(:,2:3:3*data_size*(1-data_split))];

%x1= x_train(:,1:size(x_train,2)/2);
%x2 = x_train(:,2:100);

accuracy = 0;
for i = 1:size(x_test,2)
    distance_vector = [];
    if i <= size(x_test,2)/2
        true_label = 1;
    else
        true_label = -1;
    end
    
    for j = 1: size(x_neutral,2)
        distance = norm(x_test(:,i)-x_neutral(:,j));
        distance_vector = [distance_vector;[distance 1]];
    end
    for j = 1: size(x_expression,2)
        distance = norm(x_test(:,i)-x_expression(:,j));
        distance_vector = [distance_vector;[distance -1]];
    end
    
    %find the computed label: Dependent on K value
    poll = sortrows(distance_vector, 1);
    computed_label = mode(poll(1:K,2));
  
    if true_label*computed_label == 1
        accuracy = accuracy + 1;
    end
    
end
disp('Base acccuracy: ');
disp((accuracy/size(x_test,2))*100);
