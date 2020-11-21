Project1: CMSC828C: Statistical Pattern Recognition 
Author: Amoghavarsha Prasanna
UID: 116952910

The files have been organised into 3 folders namely Binary Classification, Data and Subject Classification.

*****************************************************************************************************************************************
Task: Neutral vs Expression Classification:
Change the directory to aprasann_P1/Binary_Classification

All the files in this directory are dependent on get_data.m to access the data from the data-set Data.mat

--Bayesian Classifier:----
Run Bayesian.m to test the Bayesian classifier. 
Run the files LDA_Bayesian.m and PCA_Bayesian.m for their respective classifiers, these two files also use bayes_function for the testing.

----KNN Classifier: ----
Run KNN.m to test the KNN classifier. 
Run the files LDA_KNN.m and PCA_KNN.m for their respective classifiers, these two files also use KNN_function for the testing.

---SVM Classifiers:----
Run MySVM_new.m to test the linear SVM, SVM_rbf and SVM_poly to test the SVM classifiers with their respective kernels. 
*******************************************************************************************************************************************
Task: Subject Classification 
Change the directory to aprasann_P1/Subject Classification

Data-set : Data.mat

--Bayesian Classifier:----
Run Subject_Classification.m to test subject classification with bayesian. The data is retrieved from get_subject_data.m
For Bayesian with MDA and PCA--Run Subject_MDA_PCA.m this files makes use of bot get_subject_data.m and Bayes_subject.m

--KNN Classifier:----
Run Subject_Classification_KNN.m to test subject classification with KNN.The data is retrieved from get_subject_data.m. This files also provides the results for KNN with MDA and PCA .
*******************************************************************************************************************************************







