function val = ifelse(predicate, ifClause, elseClause)
%IFELSE An inline alternative for conditional program flow.
% v1.0.0 | nGelwan | 2018
% val = ifelse(predicate, ifClause, elseClase)
%   Evaluate `ifClause` as `val` if `predicate` is true, otherwise
%   evalueate `elseClause` as `val`. For use in anonymouse functions, or
%   whatever.

%%
if predicate
    val = ifClause;
else
    val = elseClause;
end

end

