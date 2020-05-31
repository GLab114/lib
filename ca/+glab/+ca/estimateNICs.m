function nICs = estimateNICs(fov, varargin)
%ESTIMATENICS Estimate the number of ICs in Ca-imageing field of view.
% v0.1.0 | N Gelwan | 2020-05
%
%   Usage:
%   nICs::int = glab.ca.estimateNICs(fov::2darray)
%
%   _ = glab.ca.estimateNICs(_, 'featSz', x::double)
%
%   _ = glab.ca.setimateNICs(_, 'medZThresh', x::double)

%%
defaultMedZThresh = 1;
defaultFeatSz = 2;

p = inputParser();
addParameter(p, 'medZThresh', defaultMedZThresh ...
    );
addParameter(p, 'featSz', defaultFeatSz ...
    );
parse(p, varargin{:});

medZThresh = p.Results.medZThresh;
featSz = p.Results.featSz;

%%
thresh = median(fov(:)) + medZThresh * std(fov(:));
fovNaN = fov;
fovNaN(fov < thresh) = nan;

fovBlur = imgaussfilt(fovNaN, featSz);
fovBlur(isnan(fovBlur(:))) = min(fovBlur(:));
maxes = imregionalmax(fovBlur);
nICs = sum(maxes(:));

end

