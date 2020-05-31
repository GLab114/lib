function [val, dim] = inSize(extent, sz)
%INSIZE Determine whether an extent lies within the bounds of a theoretical array with specified size.
val = true;
dim = [];
for i = 1:length(extent)
    dimExt = extent{i};
    vlb = dimExt(1) < 1;
    vub = dimExt(2) > sz(i);
    if ~isempty(dimExt) && (vlb || vub)
        val = false;
        dim = i;
        break
    end
end
end

