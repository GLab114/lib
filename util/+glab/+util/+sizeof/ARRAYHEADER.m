function val = ARRAYHEADER()
%ARRAYHEADER An overestimate of the size of the header of a MATLAB array on the heap.
% MATLAB stores its arrays with a small block of memory extraneous to the
% data, where information like the size and dtype are kept. I couldn't find
% a reference on the details of that, so I'm overestimating that at 1 KB.
val = glab.lib.util.sizeof.KB;
end

