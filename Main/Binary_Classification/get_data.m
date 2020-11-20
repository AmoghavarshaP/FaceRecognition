%Custom data retrival function for the data_set data.mat
%type: Provides the type of data: train or test data
%data_set: for the purposes of this project--data.mat
%total size of the subjects in the data set -- for data.mat its 200
%split: provides the proportion of data split
function get_data = get_data(type,data_set,size,split)
if strcmp(type,'train')
    images = load(data_set);
    data = [];
    for n = 1:3*size*split
        image = images.face(:,:,n);
        image = image(:);
        data = [data image];
    end
    get_data = data;
    
elseif strcmp(type,'test')
    images =  load(data_set);
    data = [];
    for n = (3*size*split)+1:3*size
        image = images.face(:,:,n);
        image = image(:);
        data = [data image];
    end
    get_data = data;
end
    
    

