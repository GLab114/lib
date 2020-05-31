function s = lvl(event)
%LVL Summary of this function goes here
%   Detailed explanation goes here

if event.lvl < glab.log.DEBUG
    r = '<DEBUG';
elseif event.lvl == glab.log.DEBUG
    r = 'DEBUG';
elseif event.lvl < glab.log.INFO
    r = '<INFO';
elseif event.lvl == glab.log.INFO
    r = 'INFO';
elseif event.lvl < glab.log.WARNING
    r = '<WARN';
elseif event.lvl == glab.log.WARNING
    r = 'WARN';
elseif event.lvl < glab.log.ERROR
    r = '<ERROR';
elseif event.lvl == glab.log.ERROR
    r = 'ERROR';
elseif event.lvl < glab.log.CRITICAL
    r = '<CRIT';
elseif event.lvl == glab.log.CRITICAL
    r = 'CRIT';
elseif event.lvl > glab.log.CRITICAL
    r = '>CRIT';
end

s = pad(['[' r ']'], 8);
end

