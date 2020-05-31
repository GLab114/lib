function b = isRunning(pid)
%RUNNING Summary of this function goes here
%   Detailed explanation goes here

% Append module to python syspath
mFilePath = which('glab.lib.util.pid.isRunning');
upDir = fileparts(mFilePath);
pySysPath = py.sys.path;
pySysPath.append(upDir);

b = py.pid.is_running(py.int(pid));
end

