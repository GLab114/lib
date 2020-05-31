function success = acquireBlock(path, varargin)
%ACQUIREBLOCK Summary of this function goes here
%   Detailed explanation goes here

%%
defaultLockfileName = glab.lib.lockfile.DEFAULTNAME;
defaultTimeout = [];
defaultThrowTimeoutError = false;
defaultThrowAcquireError = false;

p = inputParser();
addParameter(p, 'lockfileName', defaultLockfileName ...
    );
addParameter(p, 'timeout', defaultTimeout, ...
    @(x)isscalar(x) && (x > 0));
addParameter(p, 'throwTimeoutError', defaultThrowTimeoutError, ...
    @(x)islogical(x) && isscalar(x));
addParameter(p, 'throwAcquireError', defaultThrowAcquireError, ...
    @(x)islogical(x) && isscalar(x));
parse(p, varargin{:});

lockfileName = p.Results.lockfileName;
timeout = p.Results.timeout;
throwTimeoutError = p.Results.throwTimeoutError;
throwAcquireError = p.Results.throwAcquireError;

%%
success = true;

t = tic;
while true
    acquireSuccess = glab.lib.lockfile.acquire( ...
        path, ...
        'lockfileName', lockfileName, ...
        'throwError', throwAcquireError ...
    );
    if acquireSuccess
        return
    end
    
    if ~isempty(timeout)
        if toc(t) > timeout
            if throwTimeoutError
                error('Timeout')
            end
            success = false;
            return
        end
    end
end
end

