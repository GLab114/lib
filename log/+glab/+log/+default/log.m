function event = log(thresh, lvl, msg)
%LOG Summary of this function goes here
%   Detailed explanation goes here

%%
event = glab.log.console.event(lvl, msg);
glab.log.console.default.displayEvent(thresh, event);
end

