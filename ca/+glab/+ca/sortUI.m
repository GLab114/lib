function status = sortUI(ref, srcLocs, srcTraces, varargin)
%SORT Quality control of sources.
% v0.5.1 | nGelwan | 2019
%
% TODO: Update documentation for v0.3.0

%%
defaultStatus = [];
defaultTrcMarks = {};
defaultAsvFilePath = [];
defaultUseAsv = true;

p = inputParser();
addParameter(p, 'status', defaultStatus ...
    );
addParameter(p, 'trcMarks', defaultTrcMarks ...
    );
addParameter(p, 'asvFilePath', defaultAsvFilePath ...
    );
addParameter(p, 'useAsv', defaultUseAsv, ...
    @(x)islogical(x) && isscalar(x));
parse(p, varargin{:});

status = p.Results.status;
trcMarks = p.Results.trcMarks;
asvFilePath = p.Results.asvFilePath;

%%
nSrcs = size(srcLocs, 3);

% Ref brightness
gamma = 10;
crctRef = normalize(ref, 'range') .^ (1 / gamma);
nPixels2 = size(ref);

% Src modes
[colMaxes, colModes] = max(srcLocs, [], 1);
[~, rowModes] = max(colMaxes);
srcModes = [ ...
    reshape(rowModes, nSrcs, 1) ...
    diag(reshape(colModes(:, rowModes, :), nSrcs, nSrcs, [])) ...
];

% Src names
srcNames = arrayfun(@num2name, (1:nSrcs)', 'UniformOutput', false);

% Src bdrs
srcBdrs = zeros([nPixels2, nSrcs]);
for i = 1:nSrcs
    B = bwboundaries(srcLocs(:, :, i) > 0, 8, 'noholes');
    B = B{1};
    inds = sub2ind(nPixels2, B(:, 1), B(:, 2));
    srcBdr = zeros(nPixels2);
    srcBdr(inds) = 1;
    srcBdrs(:, :, i) = srcBdr;
end

% Load asv
if ~isempty(asvFilePath)
    try
        status = glab.util.matLoad(asvFilePath);
    catch err
        % TODO: Validate err
    end
end

% State init
db = struct();
db.const = struct( ...
    'asvFreq', 7, ...
    'asvFilePath', asvFilePath, ...
    'gapStarts', {trcMarks}, ...
    'ref', {crctRef}, ...
    'nPixels2', {nPixels2}, ...
    'nSrcs', nSrcs, ...
    'srcLocs', {srcLocs}, ...
    'srcBdrs', {srcBdrs}, ...
    'srcModes', {srcModes}, ...
    'srcTraces', {srcTraces}, ...
    'srcNames', {srcNames} ...
);
db.status = status;

db.focus = 1;
db.secFocus = [];

db.asvCtr = 1;

db.showRef = false;
db.showBdrs = false;
db.showShading = true;
db.filterRejected = true;

db.context = glab.ca.sort.context.BROWSE;

db.handles = struct();

[hF, hTop, hBot] = showInit(1000);
db.fig = hF;
db.topWin = struct();
db.topWin.handle = hTop;
db.topWin.xlim = [];
db.topWin.ylim = [];
db.botWin = struct();
db.botWin.handle = hBot;
db.botWin.view = glab.ca.sort.view.TRACES;
db.botWin.xlim = [];
db.botWin.ylim = [];

%%
status = glab.ca.sort.mainLoop(db);

end

function [hF, hIm, hTr] = showInit(figID)
hF = figure(figID);
hIm = subplot(3, 1, 1:2);
hTr = subplot(3, 1, 3);
colorbar(hIm);
end

function name = num2name(num)
l = floor(log10(num) + 1);
s = arrayfun( ...
    @num2str, padarray(num, 3 - l, 'pre')', ...
    'UniformOutput', false ...
);
name = ['S' s{:}];
end
