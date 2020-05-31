function [] = showAvgDevs(db, idcs)
%SHOWAVGDEVS Summary of this function goes here
%   Detailed explanation goes here

%%
n = length(idcs);

dev = zeros(n);
for i = 1:n
    for j = (i + 1):n
        dev(i, j) = mean(abs(db.const.srcTraces(:, i) - ...
            db.const.srcTraces(:, j)));
    end
end

%%
hBot = db.botWin.handle;
cla(hBot, 'reset');

image(hBot, dev, 'CDataMapping', 'scaled');

title(hBot, 'Average deviations');

colormap(hBot, 'winter');
colorbar(hBot);

pbaspect(hBot, [1 1 1]);

xticks(hBot, 1:n);
xticklabels(hBot, db.const.srcNames(idcs));
xtickangle(hBot, 45);
yticks(hBot, 1:n);
yticklabels(hBot, db.const.srcNames(idcs));

end