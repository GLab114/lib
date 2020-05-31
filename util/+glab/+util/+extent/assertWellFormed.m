function [] = assertWellFormed(extent)
%ASSERTWELLFORMED Throw an error if extent is ill-formed, else pass silently.

for i = 1:length(extent)
    dimExt = extent{i};
    b1 = (length(dimExt) == 2) && (dimExt(1) < dimExt(2)) && ...
        (dimExt(1) > 0) && all(floor(dimExt) == dimExt);
    b2 = (length(dimExt) == 1) && ...
        (dimExt(1) == glab.lib.util.extent.EMPTY) || ...
        (dimExt(1) == glab.lib.util.extent.FULL);
    if ~(b1 || b2)
        error(['Extent is ill-formed in dimension ' num2str(i)]);
    end
end
end

