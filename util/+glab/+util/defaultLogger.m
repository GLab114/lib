function l = defaultLogger(varargin)
%DEFAULTLOGGER Summary of this function goes here
%   Detailed explanation goes here

%%
expectedTypes = {'programmatic', 'console'};
defaultType = 'console';

p = inputParser();
addParameter(p, 'type', defaultType, ...
    @(x)any(validatestring(x, expectedTypes)));
parse(p, varargin{:});

type = p.Results.type;

%%
try
    if strcmp(type, 'programmatic')
        l = glab.log.subroutine.programmatic.Logger();
    elseif strcmp(type, 'console')
        l = glab.log.subroutine.console.Logger();
    end
catch err
    if strcmp(err.identifier, 'MATLAB:undefinedVarOrClass')
        warning('`glab.log` is not on the MATLAB path; no logging');
        l = glab.util.doNothingLogger();
    else
        throw(err);
    end
end
end

