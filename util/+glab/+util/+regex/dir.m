function results = dir(path, expr, absolute)
%DIR Match files in a directory by regular expression. Pretend glob.
% v0.1.0 | N Gelwan | 2020-05
%   Isn't really like glob, though. Doesn't descend the filetree. Uses
%   regex syntax. Doesn't match '.' and '..'.
%   ***SEE BELOW FOR POTENTIAL SECURITY ISSUES***
%
%   Usage:
%   absolutePaths = regexDir(path, expr);
%   relativePath = regexDir(path, expr, false);
%
%   Examples:
%   >> regexDir('/', '^.*r$')
%
%   ans =
%    
%     2x1 cell array
%
%       {'/usr'}    {'/var'}
%
%   >> regexDir('/', '^.*r$', false)
%
%   ans =
%    
%     2x1 cell array
%
%       {'usr'}    {'var'}
%   
%   Errors:
%   - 'SecurityConcern' if `expr` contains executable MATLAB expression.
%
%   Security:
%   The `expr` arg in this function specifies a regular expression to 
%   match files against. As MATLAB-- for some reason-- allows execution 
%   of ARBITRARY MATLAB CODE when parsing regular expressions with the
%   `regexp function, this function could be a SECURITY VULNERABILITY. 
%
%   The caveat is that I built in a regexp parsing guard routine which
%   parses your regular expression for any dynamic code and shuts it down. 
%   But I'm not thinking hard about this now, and can't guarantee
%   this implementation actually works (regex is not my forte).
%   Don't use this in any  potentially exposed context. In fact, why don't 
%   you go ahead and re-implement this functionality with code which is 
%   inherently safer, and then submit a pull request? That would help.

%%
if ~exist('absolute', 'var')
    absolute = true;
end

%%
badExprs = '(\(\?\@(.*)\)|\(\?\?\@(.*)\))';
m = regexp(expr, badExprs, 'tokens');

if ~isempty(m)
    error( ...
        'GLaB:SecurityConcern', ...
        ['Detected dynamic regex `' m{1} '`; aborting for security'] ...
    );
end

%%
stats = dir(path);
names = {stats.name};
filter1 = cellfun( ...
    @(x)~strcmp(x, '.') && ~strcmp(x, '..'), names ...
);
filter2 = cellfun( ...
    @(x)~isempty(regexp(x, expr, 'once')), names ...
);
filter = logical(filter1 .* filter2);
names = names(filter);
if absolute
    results = cellfun( ...
        @(x)fullfile(path, x), names, ...
        'UniformOutput', false ...
    );
else
    results = names;
end

end

