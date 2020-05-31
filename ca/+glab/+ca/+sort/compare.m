function db = compare(db)
%COMPARE Summary of this function goes here
%   Detailed explanation goes here

%%
choices = {...
    'Add sources'...
    'Add nearby sources'...
    'Set sources' ...
    'Remove sources'...
    'Remove all sources'...
    'Show trace overlays'...
    'Show correlation coefficients'...
    'Show average deviations'...
    'Browse sources' ...
    'Batch sort sources' ...
    'Configure sorting UI' ...
};
prompt = 'What do you want to do?';

%%
glab.ca.sort.banner('COMPARE');

glab.ca.sort.showInfo(db, [db.focus; db.secFocus], true);

glab.ca.sort.showLocs(db, db.focus, db.secFocus);
if ~isempty(db.topWin.xlim) && ~isempty(db.topWin.ylim)
    xlim(db.topWin.handle, db.topWin.xlim);
    ylim(db.topWin.handle, db.topWin.ylim);
end

if db.botWin.view == glab.ca.sort.view.TRACES
    % Show traces
    glab.ca.sort.showTraces(db, [db.focus; db.secFocus]);
    if ~isempty(db.botWin.xlim) && ~isempty(db.botWin.ylim)
        xlim(db.botWin.handle, db.botWin.xlim);
        ylim(db.botWin.handle, db.botWin.ylim);
    end
elseif db.botWin.view == glab.ca.sort.view.CORRCOEFS
    % Show corr coefs
    glab.ppln.sort.showCorrCoefs(db, [db.focus; db.secFocus]);
elseif db.botWin.view == glab.ca.sort.view.AVGDEVS
    % Show average deviations
    glab.ppln.sort.showAvgDevs(db, [db.focus; db.secFocus]);
end

choice = glab.ui.console.picker(choices, prompt);

db.topWin.xlim = xlim(db.topWin.handle);
db.topWin.ylim = ylim(db.topWin.handle);
if db.botWin.view == glab.ca.sort.view.TRACES
    db.botWin.xlim = xlim(db.botWin.handle);
    db.botWin.ylim = ylim(db.botWin.handle);
else
    db = resetLims(db);
end

if choice == 1
    % Add cells
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.secFocus = [db.secFocus; idcs];
    end
elseif choice == 2
    % Add nearby cells
    idcs = glab.ca.sort.getNearby(db, db.focus, false);
    db.secFocus = [db.secFocus; idcs];
elseif choice == 3
    % Set cells
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.secFocus = idcs;
    end
elseif choice == 4
    % Remove cell
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        [~, rmIdcs] = intersect(db.secFocus, idcs);
        db.secFocus(rmIdcs) = [];
    end
elseif choice == 5
    % Remove all cells
    db.secFocus = [];
elseif choice == 6
    % Show trace overlays
    db.botWin.view = glab.ca.sort.view.TRACES;
elseif choice == 7
    % Show pointwise trace products
    db.botWin.view = glab.ca.sort.view.CORRCOEFS;
elseif choice == 8
    % Show average deviations
    db.botWin.view = glab.ca.sort.view.AVGDEVS;
elseif choice == 9
    % Done
    db.context = glab.ca.sort.context.BROWSE;
    db = resetAll(db);
elseif choice == 10
    db.context = glab.ca.sort.context.BATCHSORT;
elseif choice == 11
    db.context = glab.ppln.sort.context.CONFIGURE;
    db = resetAll(db);
end

db.secFocus = unique(db.secFocus);

end


function db = resetLims(db)
db.topWin.xlim = [];
db.topWin.ylim = [];
db.botWin.xlim = [];
db.botWin.ylim = [];

end


function db = resetAll(db)
db = resetLims(db);
db.secFocus = [];
db.botWin.view = glab.ca.sort.view.TRACES;

end