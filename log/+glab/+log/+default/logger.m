function l = logger(varargin)
%LOGGER Summary of this function goes here
%   Detailed explanation goes here

%% Input parsing
defaultThreshold = glab.log.DEBUG;

p = inputParser();
addParameter(p, 'threshold', defaultThreshold);
parse(p, varargin{:});

thr = p.Results.threshold;

%% Go
log = @(lvl, msg)glab.log.default.log(thr, lvl, msg);

l = struct(...
	'log', log, ...
    'debug', @(msg)log(glab.log.DEBUG, msg), ...
    'info', @(msg)log(glab.log.INFO, msg), ...
    'warning', @(msg)log(glab.log.WARNING, msg), ...
    'error', @(msg)log(glab.log.ERROR, msg), ...
    'critical', @(msg)log(glab.log.CRITICAL, msg) ...
);
end

