function newimg = ImageFusion(channelWeight, layerWeight, varargin)
    imgsize = size(varargin{1});
    tmpimg = zeros(imgsize);
    if length(channelWeight) ~= nargin - 2
        error('The number of weigths are not matching.');
    end
    for i = 1:nargin - 2
        if size(varargin{i}) ~= imgsize
            error('Image sizes are not equal.');
        end
    end
    for i = 1:nargin - 2
        currentChannel = double(varargin{i});
        tmpimg = tmpimg + channelWeight(i)*currentChannel.*layerWeight;
    end
    tmpimg = tmpimg ./ (sum(channelWeight)*layerWeight);
    newimg = uint8(tmpimg);
end