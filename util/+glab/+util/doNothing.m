function varargout = doNothing(varargin)
%DONOTHING Do nothing. For use in higher-order functions.
% v0.1.0 | N Gelwan | 2020-05
% Usage:
% glab.util.doNothing(any::any...)
%
% glab.util.doNothing(_, 'nOut', n::int)

%%
defaultNOut = 0;

p = inputParser();
addParameter(p, 'nOut', defaultNOut, ...
    @(x)isscalar(x) && (floor(x) == x) && x >= 0);
parse(p, varargin{:});

nOut = p.Results.nOut;

%%
varargout = cell(nOut, 1);

end

