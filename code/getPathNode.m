function node = getPathNode(path)
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
if(size(path,2)>2)
    node=path(2:end-1);
else
    node=[];
end

end

