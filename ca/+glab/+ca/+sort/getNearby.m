function nearby = getNearby(db, idx, filterRejected)
%GETNEARBY Summary of this function goes here
%   Detailed explanation goes here

%%
if ~exist('filterRejected', 'var')
    filterRejected = false;
end

%%
td = 0.05;

%%
diameter = norm(db.const.nPixels2);
thr = td * diameter;

mode = db.const.srcModes(idx, :);
dists = sqrt(sum((db.const.srcModes - mode) .^ 2, 2));

isNear = dists <= thr;
% Get rid of self
isNear(idx) = false;

if filterRejected
    isNear = isNear .* (db.status ~= glab.ca.sort.status.REJECTED);
end

nearby = find(isNear);

end

