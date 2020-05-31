function [] = dispComp(canvas, compIdcs, varargin)
%DISPCOMP Summary of this function goes here
%   Detailed explanation goes here

%% Input parsing
defaultTarget = [];
defaultAlpha = 0.5;
defaultRGB = [1 0 0];
defaultColormap = 'default';

p = inputParser();
addParameter(p, 'target', defaultTarget);
addParameter(p, 'alpha', defaultAlpha);
addParameter(p, 'rgb', defaultRGB);
addParameter(p, 'colormap', defaultColormap);
parse(p, varargin{:});

target = p.Results.target;
alpha = p.Results.alpha;
rgb = p.Results.rgb;
cmap = p.Results.colormap;

%% GO!
nPixels = size(canvas);

comp = zeros(nPixels);
comp(compIdcs) = 1;

if isempty(target)
    image(canvas, 'CDataMapping', 'scaled');
    colormap(cmap);
    hold('on');
    image(ones(nPixels), ...
        'CData', cat(3, ...
            rgb(1) * ones(nPixels), ...
            rgb(2) * ones(nPixels), ...
            rgb(3) * ones(nPixels)), ...
        'AlphaData', alpha * comp);
    hold off;
else
    image(target, canvas, 'CDataMapping', 'scaled');
    colormap(target, cmap);
    % Does this (v) work?
    hold(target, 'on');
    image(target, ones(nPixels), ...
        'CData', cat(3, ...
            rgb(1) * ones(nPixels), ...
            rgb(2) * ones(nPixels), ...
            rgb(3) * ones(nPixels)), ...
        'AlphaData', alpha * comp);
    hold(target, 'off');
end
end

