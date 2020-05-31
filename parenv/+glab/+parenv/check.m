function env = check()
%READ Summary of this function goes here
%   

%%
m = memory();
maxBytes = 0.90 * m.MaxPossibleArrayBytes;

currPool = gcp('nocreate');
if isempty(currPool)
    useParallel = false;
    nWorkers = 1;
else
    useParallel = true;
    nWorkers = currPool.NumWorkers;
end

env = struct( ...
    'useParallel', useParallel, ...
    'nWorkers', nWorkers, ...
    'maxBytes', maxBytes ...
);
end

