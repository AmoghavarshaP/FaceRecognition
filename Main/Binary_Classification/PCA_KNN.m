clc;
clear;
close all;

data_set = '../Data/data.mat';
%Cropped set of images is 200 subjects
data_size = 200;
%Test-train split 50-50
data_split = 0.5;
%Setting K Value
K=3;
%Extract Training and Testing data
training_data = get_data('train',data_set,data_size,data_split);
testing_data = get_data('test',data_set,data_size,data_split);

%%Performing PCA on the data:
[U,S,V] = svds(training_data,60);
training_data = U'*training_data;
testing_data = U'*testing_data;
%%Calling the KNN function:
disp("PCA with KNN Classifier: "+ "--for K= "+K);
KNN_function(training_data,testing_data,K,data_size,data_split);



% %Visulization
% K_value        = [3,5,7,9,11];
% accuracy_value = [78,82,82,80,81];
% vector = [K_value' accuracy_value',];
% plot(vector(:,1),vector(:,2),'b');
% legend('KNN')
% hold on 
% K_value_LDA        = [3,5,7,9,11];
% accuracy_value_LDA = [83.5,83,84,84,85];
% vector = [K_value_LDA' accuracy_value_LDA'];
% plot(vector(:,1),vector(:,2),'r');
% hold on
% K_value_PCA       = [3,5,7,9,11];
% accuracy_value_PCA = [84.5,87,84.5,84.5,86];
% vector = [K_value_PCA' accuracy_value_PCA'];
% plot(vector(:,1),vector(:,2),'g');
% legend({'KNN','KNN with LDA','KNN with PCA'},'Location','southeast')
% title("KNN Classifier: Accuracy variations")
% xlabel("K");
% ylabel("Accuracy(%)")
% hold off

%Visulization
% components =      [10, 15, 20,25,30,40,45,50,60];
% accuracy_vector = [77.5,83,85,84.5,84,82.5,83,82.5,80.5];
% vector = [components' accuracy_vector'];
% plot(vector(:,1),vector(:,2));
% title("KNN Classifier with PCA ; K=3: Accuracy")
% xlabel("Number of Components");
% ylabel("Accuracy(%)")
