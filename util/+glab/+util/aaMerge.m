function c = aaMerge(a, b)
%AAMERGE Merge two associate arrays (scalar struct arrays)
% c = aaMerge(a, b)
%   Merge the two associative arrays `a` and `b`, with the value in `b` for
%   overlapping fields taking precedence.

c = a;
fieldNames = fieldnames(b);
for i = 1:length(fieldNames)
    fieldName = a{i};
    c.(fieldName) = b.(fieldName);
end
end

