function y = movmeann(x, l, n, dim, nanflag)
% MOVMEANN Iterated moving-average filter.
% v1.0.0 | nGelwan | 2018
% y = movmeann(x, l, n, dim, nanflag)
%   Provides a wrapper over MOVMEAN to allow for `n` passes. Supports all
%   other arguments to MOVMEAN, including `dim` and `nanflag`, which are 
%   optional.
if ~exist('dim', 'var')
    dim = 1;
end
if ~exist('nanflag', 'var')
    nanflag = 'omitnan';
end
y = x;
for i = 1:n
    y = movmean(y, l, dim, nanflag);
end
end
