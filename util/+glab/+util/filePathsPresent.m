function present = filePathsPresent(filePaths)
%FILEPATHSPRESENT Check for the presence of a cell array of filepaths.
% v0.1.0 | N Gelwan | 2020-05
%
%   Usage:
%   present::bool = glab.util.filePathsPresent(filePaths::cell(string));
%
%   Examples:
%   >> fpsAllThere = {'/dev/null', '/dev/tty'};
%   >> glab.util.filePathsPresent(fpsAllThere)
%   
%   ans = 
%
%     logical
%
%       1
%
%   >> fpsNotAllThere = {'/dev/null', '/dev/foobarbaz'};
%   >> glab.util.filePathsPresent(fpsNotAllThere)
%
%   ans =
%
%     logical
%
%       0

%%
present = all(cellfun(@(x)exist(x, 'file'), filePaths));

end

