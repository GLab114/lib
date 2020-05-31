function success = acquire(path, varargin)
%ACQUIRE Acquire a lockfile
% If there is no lock present, acquire one. If there is a lock present,
% check ownership. If ownership is stale, acquire. If the owner is the
% current process, acquire. Otherwise, fail.

%%
defaultThrowError = false;
defaultLockfileName = glab.lib.lockfile.DEFAULTNAME;

p = inputParser();
addParameter(p, 'throwError', defaultThrowError, ...
    @(x)islogical(x) && isscalar(x));
addParameter(p, 'lockfileName', defaultLockfileName ...
    );
parse(p, varargin{:});

throwError = p.Results.throwError;
lockfileName = p.Results.lockfileName;

%%
lockfilePath = fullfile(path, lockfileName);

success = glab.lib.lockfile.canOwn(lockfilePath);
if success
    currPID = glab.lib.util.pid.curr();
    writeLock(lockfilePath, currPID);
else
    if throwError
        error('Does not own lock');
    end
end

end


function writeLock(lockfilePath, currPID)
    fid = fopen(lockfilePath, 'w');
    
    if fid == -1
        error('Unexpected error acquiring lock; check permissions');
    end
    
    fwrite(fid, currPID, 'int32');
    fclose(fid);
end

