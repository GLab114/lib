function val = dtype(dtype)
%DTYPE Return the size in bytes of a MATLAB dtype.
% v0.1.0 | N Gelwan | 2020-05
%
%   Usage:
%   val::int = glab.util.sizeof.dtype(dtype::string)
%   Accepted values of `dtype` are: 'double', 'int64', 'uint64', 'single',
%   'int32', 'uint32', 'char', 'int16', 'uint16', 'logical', 'int8', and
%   'uint8'.
%
%   Errors:
%   - InputError: if `dtype` is not listed above.
%
%   Examples:
%   >> glab.util.sizeof.dtype('double')
%
%   ans =
%   
%       8

%%
switch dtype
  case {'double', 'int64', 'uint64'}
    val = 8;
  case {'single', 'int32', 'uint32'}
    val = 4;
  case {'char', 'int16', 'uint16'}
    val = 2;
  case {'logical', 'int8', 'uint8'}
    val = 1;
  otherwise
    error('InputError', 'Dtype not supported');
end

end

