function srcLocs = thresh(srcLocs, zThresh)
%THRESH Summary of this function goes here
%   Detailed explanation goes here

%%
thresh = mean(srcLocs, [1 2]) + zThresh * std(srcLocs, [], [1 2]);
srcLocs(srcLocs < thresh) = 0;

end

