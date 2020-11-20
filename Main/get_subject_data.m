%Custom data retrival function for the data_set data.mat for subject classification task
%type: Provides the type of data: train or test data
%data_set: for the purposes of this project--data.mat
%total size of the subjects in the data set -- for data.mat its 200
function get_subject_data = get_subject_data(type,data_set,total_size)
if strcmp(type,'train')
    images = load(data_set);
    data = [];
    for n = 1:total_size
        Neutral_images = images.face(:,:,3*n-2);
        Expression_images = images.face(:,:,3*n-1);
        data = [data Neutral_images(:)  Expression_images(:)];
    end
    get_subject_data = data;
    
elseif strcmp(type,'test')
    images = load(data_set);
    data = [];
    for n = 1:total_size
        Illumination_images = images.face(:,:,3*n);
        data = [data Illumination_images(:)];
    end
    get_subject_data = data;
    
end
