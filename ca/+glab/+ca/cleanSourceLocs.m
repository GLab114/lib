function [srcLocs, srcTraces] = ...
    clean(srcLocs, srcTraces, minZ, minCompWeight, varargin)
%CLEAN Summary of this function goes here
%   Detailed explanation goes here

%%
defaultLogger = glab.ppln.util.defaultLogger();

p = inputParser();
addParameter(p, 'logger', defaultLogger ...
    );
parse(p, varargin{:});

l = p.Results.logger;

%%
if ~isempty(minZ)
    l.debugSrE('Thresholding source locales');

    srcLocs(...
        srcLocs < (mean(srcLocs, [1 2]) + ...
            minZ * std(srcLocs, [], [1 2])) ...
    ) = 0;

    l.srX();
end

%%
if ~isempty(minCompWeight)
    l.debugSrE('Pruning insignificant components');
    
    for i = 1:size(srcLocs, 3)
        src = srcLocs(:, :, i);
        srcMask = src > min(src(:));
        CC = bwconncomp(srcMask, 4);

        if CC.NumObjects > 1
            area = cell2mat(cellfun(@length, CC.PixelIdxList, ...
                'UniformOutput', false));
            compWeight = area / sum(area);

            smallMask = compWeight < minCompWeight;

            srcMask(cell2mat(CC.PixelIdxList(smallMask)')) = 0;
            srcLocs(:, :, i) = src .* srcMask;
        end
    end

    noSrcMask = all(srcLocs == 0, [1 2]);
    
    srcLocs(:, :, all(srcLocs == 0, [1 2])) = [];
    srcTraces(:, noSrcMask) = [];
    
    l.debug(['Removed ' num2str(sum(noSrcMask)) ' sources; '...
        num2str(size(srcLocs, 3)) ' remain']);
    
    l.srX();
end

end

