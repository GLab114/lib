function b = canOwn(lockfilePath)
%CANOWN Summary of this function goes here
%   Detailed explanation goes here

currPID = glab.lib.util.pid.curr();

b = true;
if ~exist(lockfilePath, 'file')
else
    pid = readLock(lockfilePath);
    
    % Check if stale
    if ~glab.lib.util.pid.isRunning(pid)
        return
    end
    
    % Check if owns
    if pid ~= currPID
        b = false;
    end
end
end


function pid = readLock(lockfilePath)
    fid = fopen(lockfilePath, 'r');
    
    if fid == -1
        error('Unexpected error acquiring lock; check permissions');
    end
    
    pid = fread(fid, 1, 'int32');
    fclose(fid);
end