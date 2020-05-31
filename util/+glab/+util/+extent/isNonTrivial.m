function val = nonTrivial(extent)
%NONTRIVIAL Summary of this function goes here
%   Detailed explanation goes here
nonTrivial = ~any(cellfun( ...
    @(x)x == glab.lib.util.EMPTY, ...
    extent ...
));
end

