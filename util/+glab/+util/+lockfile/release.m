function success = release(path, varargin)
%RELEASE Release ownership of a lock.
% 

%%
defaultLockfileName = glab.lib.lockfile.DEFAULTNAME;
defaultThrowError = false;

p = inputParser();
addParameter(p, 'lockfileName', defaultLockfileName ...
    );
addParameter(p, 'throwError', defaultThrowError, ...
    @(x)islogical(x) && isscalar(x));
parse(p, varargin{:});

lockfileName = p.Results.lockfileName;
throwError = p.Results.throwError;

%%
lockfilePath = fullfile(path, lockfileName);

success = glab.lib.lockfile.canOwn(lockfilePath);
if success
    delete(lockfilePath)
else
    if throwError
        error('Does not own lock');
    end
end

end

