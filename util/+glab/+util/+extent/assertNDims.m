function [] = assertNDims(extent, nDims)
%ASSERTNDIMS Throw an error if extent does not have given number of dimensions, otherwise pass silently.

if length(extent) ~= nDims
    error('Extent does not have correct number of dimensions');
end
end

