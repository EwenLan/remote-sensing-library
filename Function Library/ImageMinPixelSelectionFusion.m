function newimg = ImageMinPixelSelectionFusion(varargin)
    imgsize = size(varargin{1});
    numLayer = 0;
    for i = 1:nargin
        curimgsize = size(varargin{i});
        curimgsizesize = length(curimgsize);
        if curimgsizesize == 3
            numLayer = numLayer + curimgsize(3);
        else
            if curimgsizesize == 2
                numLayer = numLayer + 1;
            end
        end
    end
    imgtable = zeros([imgsize(1:2), numLayer]);
    imgtablePoint = 1;
    for i = 1:nargin
        curimgsize = size(varargin{i});
        curimgsizesize = length(curimgsize);
        if curimgsizesize == 3
            for j = 1:curimgsize(3)
                imgtable(:,:,imgtablePoint) = varargin{i}(:,:,j);
                imgtablePoint = imgtablePoint + 1;
            end
        else
            if curimgsizesize == 2
                imgtable(:,:,imgtablePoint) = varargin{i}(:,:);
                imgtablePoint = imgtablePoint + 1;
            end
        end
    end
    newimg = uint8(min(imgtable, [], 3));
end