function bayes_subject = bayes_subject_func(x_train,x_test,delta)
tic
%Training the bayesian subject classification model:
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
        %disp('correct classification')
        accuracy = accuracy+1;
    else
        %disp('incorrect classification')
    end
    
end

disp("Accuracy is : ");
disp((accuracy/size(x_test,2))*100);
toc