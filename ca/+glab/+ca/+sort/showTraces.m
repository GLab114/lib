function [] = showTraces(db, idcs)
%SHOWTRACES Summary of this function goes here
%   Detailed explanation goes here

%%
hBot = db.botWin.handle;

%%
cla(hBot, 'reset');
pbaspect(hBot, 'auto');

hold(hBot, 'on')
% Recordings
for i = 1:length(db.const.gapStarts)
    xline(hBot, db.const.gapStarts(i), '--');
end

% Overlays
hP = [];
for i = 1:length(idcs)
    hP(i) = plot(hBot, db.const.srcTraces(:, idcs(i))); %#ok<AGROW>
end

% Calling with empty output args fixes a matlab bug where the legend
% doesn't show the right colors
% MATLAB, get it together
[~, ~] = legend(hP, db.const.srcNames(idcs));
grid(hBot, 'on');
xlabel(hBot, 'Frame');
ylabel(hBot, 'DF/F');

end

