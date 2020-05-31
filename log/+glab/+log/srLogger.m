function l = srLogger(lvl)
%SRLOGGER Summary of this function goes here
%   Detailed explanation goes here
if ~exist('lvl', 'var')
    lvl = glab.log.INFO;
end
l = glab.log.subroutine.console.Logger( ...
    'threshold', lvl ...
);
end

