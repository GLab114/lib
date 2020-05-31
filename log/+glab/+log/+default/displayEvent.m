function [] = displayEvent(thresh, event)
%DISPLAYEVENT Summary of this function goes here
%   Detailed explanation goes here

%%
if event.lvl - thresh >= 0
    disp([ ...
        glab.log.fmt.dt(event) ...
        glab.log.fmt.lvl(event) ...
        event.msg ...
    ]);
end
end

