function [] = dispSeeds(canvas, seedIdcs, varargin)
%DISPSEEDS Summary of this function goes here
%   Detailed explanation goes here

%% Input parsing
defaultTarget = [];
defaultSize = 15;
defaultRGB = [1 0 0];
defaultColormap = 'default';

p = inputParser();
addParameter(p, 'target', defaultTarget);
addParameter(p, 'size', defaultSize);
addParameter(p, 'rgb', defaultRGB);
addParameter(p, 'colormap', defaultColormap);
parse(p, varargin{:});

target = p.Results.target;
sz = p.Results.size;
rgb = p.Results.rgb;
cmap = p.Results.colormap;

%% GO!
nPixels = size(canvas);

[seedY, seedX] = ind2sub(nPixels, seedIdcs);
nSeeds = length(seedIdcs);

if isempty(target)
    image(canvas, 'CDataMapping', 'scaled');
    colormap(cmap);
    hold('on');
    scatter(seedX, seedY, sz * ones(nSeeds, 1), rgb, 'filled');
    hold off;
else
    image(target, canvas, 'CDataMapping', 'scaled');
    colormap(target, cmap);
    % Does this (v) work?
    hold(target, 'on');
    scatter(target, seedX, seedY, sz * ones(nSeeds, 1), rgb, 'filled');
    hold(target, 'off');
end
end

