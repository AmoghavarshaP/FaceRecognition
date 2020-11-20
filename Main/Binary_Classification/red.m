
%% section test
function KNN_function = KNN_function(training_data,testing_data,K,scaled_value,data_size,data_split)

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
        distance = norm((scaled_value'*x_test(:,i))-(scaled_value'*x_neutral(:,j)));
        distance_vector = [distance_vector;[distance 1]];
    end
    for j = 1: size(x_expression,2)
        distance = norm((scaled_value'*x_test(:,i))-(scaled_value'*x_expression(:,j)));
        distance_vector = [distance_vector;[distance -1]];
    end
    %find the computed label: Dependent on K value
    poll = sortrows(distance_vector, 1);
    computed_label = mode(poll(1:K,2));
  
    if true_label*computed_label == 1
        accuracy = accuracy + 1;
    end
end
disp('Accuracy is:  ');
disp((accuracy/size(x_test,2))*100);

end