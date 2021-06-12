function Seq = loadImages(imgPath)
    %currentFolder = pwd
    %imgPath = [currentFolder,'\Test Pattern Images']
    imgType = '.png'; % change based on image type
    images  = dir([imgPath imgType]);
    N = length(images);

    % check images
    if( ~exist(imgPath, 'dir') || N<1 )
        display('Directory not found or no matching images found.');
    end

    % preallocate cell
    Seq{N,1} = []

    for idx = 1:N
        Seq{d} = imread([imgPath images(idx).name]);
    end
end