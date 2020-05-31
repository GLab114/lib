function data = matLoad(filePath)
%MATLOAD Summary of this function goes here
%   Detailed explanation goes here

%%
matStruct = load(filePath);
data = matStruct.data;

end

