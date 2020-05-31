function [] = showCorrCoefs(db, idcs)
%SHOWCORRCOEFS Summary of this function goes here
%   Detailed explanation goes here

%%
n = length(idcs);
cc = corrcoef(db.const.srcTraces(:, idcs));

%%
hBot = db.botWin.handle;
cla(hBot, 'reset');

image(hBot, cc * 64);

title(hBot, 'Correlation coefficients');

colormap(hBot, 'winter');
colorbar(...
    hBot, ...
    'Ticks', [1 16 32 48 64], ...
    'TickLabels', [0 0.25 0.5 0.75 1] ...
);

pbaspect(hBot, [1 1 1]);

xticks(hBot, 1:n);
xticklabels(hBot, db.const.srcNames(idcs));
xtickangle(hBot, 45);
yticks(hBot, 1:n);
yticklabels(hBot, db.const.srcNames(idcs));

end

