function varargout = always(fn, varargin)
%ALWAYS Wrap a function with values that it always returns. For
%like-functional programming.
% Use the `'args'` kwarg to pass a cell of arguments to the function, use
% the `'always'` kwarg and pass a cell to specify outputs. This function 
% uses the input parser, so it might not be fast. I don't know the 
% specifics of that.
%%
defaultAlways = {};
defaultArgs = {};

p = inputParser();
addParameter(p, 'always', defaultAlways, @iscell);
addParameter(p, 'args', defaultArgs, @iscell);
parse(p, varargin{:});

%%
fn(p.Results.args{:});
varargout = p.Results.always;
end

