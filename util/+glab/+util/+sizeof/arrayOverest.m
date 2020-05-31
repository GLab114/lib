function [total, data, header] = arrayOverest(dtype, size)
%ARRAYOVEREST Over-estimate allocation requirements (in bytes) matlab needs for an array of a given size and dtype. 
% Over-estimate because I couldn't find any references with details on how
% MATLAB stores its array headers.

header = glab.lib.util.sizeof.ARRAYHEADER;
data = prod(size) * glab.lib.util.sizeof.dtype(dtype);
total = header + data;
end

