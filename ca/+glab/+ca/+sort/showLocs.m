function [] = showLocs(db, focus, secFocus)
%SHOWLOCS Summary of this function goes here
%   Detailed explanation goes here

%%
secFocus = reshape(secFocus, [], 1);

%%
hTop = db.topWin.handle;
cla(hTop, 'reset');
colormap(hTop, 'gray');
hold(hTop, 'on');

if db.showRef
    image(hTop, db.const.ref * 64);
    alpha = 0.5;
else
    alpha = 1;
end
if db.showShading
    red = normalize(db.const.srcLocs(:, :, focus), 'range');
    if isempty(secFocus)
        blue = zeros(db.const.nPixels2);
    else
        blue = db.const.srcLocs(:, :, secFocus);
        blue = (blue - min(blue, [], [1 2])) ./ ...
            (max(blue, [], [1 2]) - min(blue, [], [1 2]));
        blue = max(blue, [], 3);
    end
    C = cat(3, red, zeros(db.const.nPixels2), blue);
    image(hTop, 'CData', C, 'AlphaData', alpha * max(red, blue));
end
if db.showBdrs
    focBdr = db.const.srcBdrs(:, :, focus);
    secFocBdrs = max(db.const.srcBdrs(:, :, secFocus), [], 3);    
    if isempty(secFocBdrs)
        secFocBdrs = 0;
    end
    C = repmat(focBdr * 0.5, 1, 1, 3);
    A = max(focBdr, secFocBdrs);
    image(hTop, 'CData', C, 'AlphaData', A);
end

% Labeling
scatter(...
    hTop, ...
    db.const.srcModes([focus; secFocus], 1), ...
    db.const.srcModes([focus; secFocus], 2), ...
    10, 'k', 'filled' ...
);

for i = 1:length(secFocus) + 1
    if i == 1
        j = focus;
    else
        j = secFocus(i - 1);
    end
    name = db.const.srcNames{j};
    if db.status(j) == glab.ca.sort.status.ACCEPTED
        statusLite = '\surd';
        statusFull = 'accepted';
    elseif db.status(j) == glab.ca.sort.status.UNDECIDED
        statusLite = '?';
        statusFull = 'undecided';
    elseif db.status(j) == glab.ca.sort.status.REJECTED
        statusLite = 'x';
        statusFull = 'rejected';
    end
    label = [name '; ' statusLite];
    text(...
        hTop, ...
        db.const.srcModes(j, 1), ...
        db.const.srcModes(j, 2), ...
        label, 'color', 'k', ...
        'Clipping', 'off' ...
    );
end
hold(hTop, 'off');
title(hTop, [name '; ' statusFull]);

end
