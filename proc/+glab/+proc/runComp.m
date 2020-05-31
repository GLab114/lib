function results = runComp(compOrFn, nOut, varargin)
%RUNCOMP Run a computation.
% v0.1.0 | N Gelwan | 2020-05
%   Dispatches on whether the first argument is a function handle or a
%   glab.ppln.AbsComp subclass.
%
%   NOTE: If you get confused reading through the source of this function,
%   refer to https://www.mathworks.com/matlabcentral/answers/96038-how-can-i-capture-an-unknown-number-of-output-arguments-in-a-cell-array-in-matlab-7-5-r2007b#answer_216954
%   and see how the unintelligible incantation below actually corresponds
%   to capturing a variable number of outputs from a MATLAB function. Sigh.
%
%   Usage:
%   result::b = runComp(fn::a->b, nOut::int, args::cell(a))
%
%   result::b = ...
%       runComp(comp::glab.ppln.Comp(a->b), nOut::int, args::cell(a))
%
%   Errors:
%   GLaB:InputError - if first argument is not a "computation" (function
%   handle or glab.ppln.AbsComp subclass.

%%
results = cell(nOut, 1);
if glab.util.subclass(compOrFn, 'glab.proc.AbsComp')
    [results{:}] = compOrFn.run(varargin);
elseif isa(compOrFn, 'function_handle')
    % Did I mess up somewhere? This seems to work, however...
    args = varargin{1};
    [results{:}] = compOrFn(args{:});
else
    error('GLaB:InputError', '`CompOrFn` is not a computation.');
end

end

