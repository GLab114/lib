function srcLocs = prune(srcLocs, minCompWeight)
%PRUNE Summary of this function goes here
%   Detailed explanation goes here

%%
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
    
end

