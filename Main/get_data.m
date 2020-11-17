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
    
    

