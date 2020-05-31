function nplLoc = locReducedComplement(r, srcLocs)
%LOCREDUCEDCOMPLEMENT Summary of this function goes here
%   Detailed explanation goes here

%%
d = bwdist(max(srcLocs, [], 3) > 0);
nplLoc = (d >= r);

end

