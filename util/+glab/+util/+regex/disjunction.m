function expr = disjunction(array)
%DISJUNCTION Produce a regex expression expressing a disjunction of an array of patterns.
%   Detailed explanation goes here

%%
expr = ['(' strjoin(array, '|') ')'];

end

