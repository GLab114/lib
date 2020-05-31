function status = autoSort(srcLocs, srcTraces, varargin)
%CLEANUP Summary of this function goes here
%   Detailed explanation goes here

%%
defaultTraceMinSup = 1e-6;
defaultLocMinAreaZ = 2;
defaultLocMinIsoperimeterZ = 3;
defaultLogger = glab.util.defaultLogger();

p = inputParser();
addParameter(p, 'traceMinSup', defaultTraceMinSup, ...
    @(x)isscalar(x));
addParameter(p, 'locMinAreaZ', defaultLocMinAreaZ, ...
    @(x)(x > 0));
addParameter(p, 'locMinIsoperimeterZ', defaultLocMinIsoperimeterZ, ...
    @(x)(x > 0));
addParameter(p, 'logger', defaultLogger ...
    );
parse(p, varargin{:});

traceMinSup = p.Results.traceMinSup;
locMinAreaZ = p.Results.locMinAreaZ;
locMinIsoperimeterZ = p.Results.locMinIsoperimeterZ;
l = p.Results.logger;

%%
nInitSrcs = size(srcTraces, 2);
nSrcs = nInitSrcs;
status = ones(nSrcs, 1) * glab.ca.sort.status.UNDECIDED;

%%

if ~isempty(traceMinSup)
    l.debugSrE('Rejecting sources with sub-threshold traces');

    subThreshMask = max(srcTraces, [], 1) < traceMinSup;
    status(subThreshMask) = glab.ca.sort.status.REJECTED;
    
    l.debug(['Rejected ' num2str(sum(subThreshMask)) ' sources']);
    nSrcs = sum(status == glab.ca.sort.status.UNDECIDED);
    
    l.srX();
end

%%
% Note that the area we're dealing with here assumes
% compactness, for which thresholding is at least necessary
if ~isempty(locMinAreaZ)
    l.debugSrE('Chopping-off right tail area distribution');
    
    areas = cellfun(@(x)sum(x(:) > 0), num2cell(srcLocs, [1 2]));
    areaOutlierMask = areas - mean(areas) > locMinAreaZ * std(areas);
    status(areaOutlierMask) = glab.ca.sort.status.REJECTED;
    
    l.debug(['Rejected ' num2str(sum(areaOutlierMask)) ' sources']);
    nSrcs = sum(status == glab.ca.sort.status.UNDECIDED);
    
    l.srX();
end

%%
% Note that the isoperimetric ratio we're dealing with here assumes
% compactness, for which thresholding is at least necessary
if ~isempty(locMinIsoperimeterZ)
    l.debugSrE(['Chopping-off right tail of isoperimetric ratio ' ...
        'distribution']);
    
    areas = cellfun(@(x)sum(x(:) > 0), num2cell(srcLocs, [1 2]));
    peris = cellfun(@perimeter, num2cell(srcLocs, [1 2]));
    iprs = (peris .^ 2) ./ areas;
    iprOutlierMask = iprs - mean(iprs) > locMinIsoperimeterZ * std(iprs);
    status(iprOutlierMask) = glab.ca.sort.status.REJECTED;
    
    l.debug(['Rejected ' num2str(sum(iprOutlierMask)) ' sources']);
    nSrcs = sum(status == glab.ca.sort.status.UNDECIDED);
    
    l.srX();
end

%%

l.debug(['Rejected ' num2str(nInitSrcs - nSrcs) ' sources; ' ...
    num2str(nSrcs) ' remain undecided']);
end


function p = perimeter(src)
B = bwboundaries(src > 0, 'noholes');
if length(B) > 1
    error('Source has too many components, what''s up?');
end
b = B{1};

p = size(b, 1);
end

