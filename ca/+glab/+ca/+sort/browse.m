function db = browse(db)
%BROWSE Summary of this function goes here
%   Detailed explanation goes here

%%

%%
listRadius = 5;
choices = {...
    'Previous source' ...
    'Reject source' ...
    'Next source' ...
    ['Jump back ' num2str(listRadius) ' sources'] ...
    'Accept source' ...
    ['Jump forwards ' num2str(listRadius) ' sources'] ...
    'Jump to first undecided source' ...
    'Jump to next undecided source' ...
    'Show nearby sources' ...
    'Set source status to undecided' ...
    'Jump to source' ...
    'Compare sources' ...
    'Batch sort sources' ...
    'Configure sorting UI' ...
    'Finish sorting' ...
};
prompt = 'What do you want to do?';

%% Go
glab.ca.sort.banner('BROWSE');

listLocal = idxLocal(listRadius, db.const.nSrcs, db.focus);
glab.ca.sort.showInfo(db, listLocal, true);
glab.ca.sort.showLocs(db, db.focus, []);
glab.ca.sort.showTraces(db, db.focus);

choice = glab.ui.console.picker(choices, prompt);
if choice == 1
    % Previous source
    db.focus = max(1, db.focus - 1);
elseif choice == 2
    % Reject source
    db.status(db.focus) = glab.ca.sort.status.REJECTED;
    db.focus = min(db.const.nSrcs, db.focus + 1);
elseif choice == 3
    % Next source
    db.focus = min(db.const.nSrcs, db.focus + 1);
elseif choice == 4
    % Jump back 5 cells
    db.focus = max(1, db.focus - 5);
elseif choice == 5
    % Accept source
    db.status(db.focus) = glab.ca.sort.status.ACCEPTED;
    db.focus = min(db.const.nSrcs, db.focus + 1);
elseif choice == 6
    % Jump forwards 5 source
    db.focus = min(db.const.nSrcs, db.focus + 5);
elseif choice == 7
    % Jump to first undecided
    idx = find(db.status == glab.ca.sort.status.UNDECIDED, 1);
    if ~isempty(idx)
        db.focus = idx;
    end
elseif choice == 8
    % Jump to next undecided 
    idx = find(logical(...
        (db.status == glab.ca.sort.status.UNDECIDED) .* ...
        ((1:db.const.nSrcs) > db.focus)' ...
    ), 1);
    if ~isempty(idx)
        db.focus = idx;
    end
elseif choice == 9
    % Show nearby cells and trace overlays shortcut
    eucLocal = ...
        glab.ca.sort.getNearby(db, db.focus, db.filterRejected);
    glab.ca.sort.showLocs(db, db.focus, eucLocal);
    glab.ca.sort.showTraces(db, [db.focus; eucLocal]);
    glab.ui.console.blockUntilInput();
elseif choice == 10
    % Set undecided
    db.status(db.focus) = glab.ca.sort.status.UNDECIDED;
elseif choice == 11
    % Jump to cell
    j = glab.ca.sort.inputSrcs(db, false);
    if j == 0
        % Nothing
    else
        db.focus = j;
    end
elseif choice == 12
    % Compare cells
    db.context = glab.ca.sort.context.COMPARE;
elseif choice == 13
    % Batch sort
    db.context = glab.ca.sort.context.BATCHSORT;
elseif choice == 14
    % Adjust options
    db.context = glab.ca.sort.context.CONFIGURE;
elseif choice == 15
    % Done
    db.context = glab.ca.sort.context.FINISH;
end

end

function idcs = idxLocal(radius, nSrcs, idx)
if radius == 0
    idcs = (1:nSrcs)';
else
    idcs = (max(1, idx - radius):min(nSrcs, idx + radius))';
end

end