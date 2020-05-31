function [] = assertInSize(extent, sz)
%ASSERTINSIZE Throw an error if an extent goes beyond the bounds of a theoretical array with given size, otherwise, pass silently.

[val, i] = glab.lib.util.extent.inSize(extent, sz);
if ~val
    dimExt = extent{i};
    error(['Extent out-of-bounds in dimension ' num2str(i) ...
        '; Must be within [' nu2mstr(dimExt(1)) ', ' ...
        num2str(dimExt(2)) ']']);
end
end

