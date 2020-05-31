function env = start(varargin)
%START Summary of this function goes here
%   Detailed explanation goes here

%%
defaultUseParallel = true;
defaultNWorkers = 12;
defaultMaxBytes = [];

p = inputParser();
addParameter(p, 'useParallel', defaultUseParallel, ...
    @(x)isscalar(x) && islogical(x));
addParameter(p, 'nWorkers', defaultNWorkers, ...
    @(x)(x > 0) && (floor(x) == x));
addParameter(p, 'maxBytes', defaultMaxBytes ...
    );
parse(p, varargin{:});

useParallel = p.Results.useParallel;
nWorkers = p.Results.nWorkers;
maxBytes = p.Results.maxBytes;
if isempty(maxBytes)
    m = memory();
    maxBytes = 0.90 * m.MaxPossibleArrayBytes;
end

%%
if useParallel
    currPool = gcp('nocreate');
    if ~isempty(currPool)
        delete(currPool);
    end
    parpool(nWorkers);
else
    if nWorkers > 1
        warning('Setting `nWorkers` to 1, as `useParallel` is false.');
    end
    nWorkers = 1;
end

env = struct( ...
    'useParallel', useParallel, ...
    'nWorkers', nWorkers, ...
    'maxBytes', maxBytes ...
);
end

