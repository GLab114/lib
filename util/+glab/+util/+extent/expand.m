function extent = expand(extent, sz)
%EXPAND Expand abbreviated dimensions of an extent to fill a given size.
for i = 1:length(sz)
    dimExt = extent{i};
    
    if len(dimExt) == 0
        dimExt = [1 sz(i)];
    elseif len(dimExt) == 1
        dimExt = [dimExt dimExt]; %#ok<AGROW>
    end
    
    extent{i} = dimExt;
end

end

