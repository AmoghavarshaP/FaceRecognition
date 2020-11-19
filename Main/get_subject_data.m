function get_subject_data = get_subject_data(type,data_set,total_size)
if strcmp(type,'train')
    images = load(data_set);
    data = [];
    for n = 1:total_size
        image_N = images.face(:,:,3*n-2);
        image_E = images.face(:,:,3*n-1);
        data = [data image_N(:) image_E(:)];
    end
    get_subject_data = data;
    
elseif strcmp(type,'test')
    images = load(data_set);
    data = [];
    for n = 1:total_size
        image_I = images.face(:,:,3*n);
        data = [data image_I(:)];
    end
    get_subject_data = data;
    
end
