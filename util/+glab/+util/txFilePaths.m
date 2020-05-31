function filePaths = txFilePaths(filePaths, varargin)
%TXFILEPATHS Transform a cell array of filepaths.
% v0.1.0 | N Gelwan | 2020-05
%   Specify transformations which operate on the parent directory, name,
%   and extension of filepaths independently and use them to batch process
%   a collection of filepaths.
%
%   Usage:
%   filePaths::cell(string) = ...
%       glab.util.txFilePaths(filePaths::cell(string));
%   txdFilePaths::cell(string) = glab.util.txFilePaths( ...
%       filePaths::cell(string), ...
%       'pathTx', pathTx::string->string, ...
%       'nameTx', nameTx::string->string, ...
%       'extnTx', extnTx::string->string ...
%   );
%
%   Examples:
%   >> fps = {'/home/file1.txt', '/home/file2.txt'};
%   >> pathTx = @(path)[path '/data'];
%   >> nameTx = @(name)[name '-PROCD'];
%   >> extnTx = @(extn)'.dat';
%   >> glab.util.txFilePaths( ...
%       fps, ...
%       'pathTx', pathTx, ...
%       'nameTx', nameTx, ...
%       'extnTx', extnTx ...
%   );
%
%   ans =
%
%     2x1 cell array
%
%       {'/home/data/file1-PROCD.dat'}    
%       {'/home/data/file2-PROCD.dat'} 

%%
defaultPathTx = @(x)x;
defaultNameTx = @(x)x;
defaultExtnTx = @(x)x;

p = inputParser();
addParameter(p, 'pathTx', defaultPathTx ...
    );
addParameter(p, 'nameTx', defaultNameTx ...
    );
addParameter(p, 'extnTx', defaultExtnTx ...
    );
parse(p, varargin{:});

pathTx = p.Results.pathTx;
nameTx = p.Results.nameTx;
extnTx = p.Results.extnTx;
fullTx = @(x)combine(x, pathTx, nameTx, extnTx);

%%
filePaths = cellfun(fullTx, filePaths, 'UniformOutput', false);

end

function out = combine(in, pathTx, nameTx, extnTx)
[path, name, extn] = fileparts(in);
out = fullfile( ...
    pathTx(path), ...
    [nameTx(name) extnTx(extn)] ...
);
end
