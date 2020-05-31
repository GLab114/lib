function [] = reset()
%RESET Summary of this function goes here
%   Detailed explanation goes here

currPool = gcp('nocreate');
if ~isempty(currPool)
    f = currPool.FevalQueue;
    cancel(f.QueuedFutures);
    cancel(f.RunningFutures);
    cancel(f.OutstandingFutures);
end
end

