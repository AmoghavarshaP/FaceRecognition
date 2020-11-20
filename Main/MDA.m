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
training_data = get_subject_data('train',data_set,data_size);
testing_data = get_subject_data('test',data_set,data_size);
classes = 200;

mu = zeros(24*21,classes); 
for i=1:classes
    mu(:, i) = (training_data(:,2*i-1) + training_data(:,2*i))/2;
end

mu_all = zeros(24*21, 1);
for i=1:size(training_data,2)
    mu_all = mu_all + training_data(:,i);
end
mu_all = 1/size(training_data,2) * mu_all;

% Within scatter matrix
delta = 0.05;  
SW = zeros(504,504);
for i=1:classes
    for j=1:2
        S = (training_data(:,2*(i-1)+j) - mu(:,i) ) * ( training_data(:,2*(i-1)+j) - mu(:,i) ).';
    end
    S = S + delta * eye(504);
    SW = SW + S;
end


% Between scatter matrix
SB = zeros(504,504);
for i=1:classes
   SB = SB + 2 * ( mu(:,i) - mu_all ) * ( mu(:,i) - mu_all ).';  
end

[W,EV] = eigs(SB,SW, classes-1);