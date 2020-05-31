function db = batchSort(db)
%BATCHSORT Summary of this function goes here
%   Detailed explanation goes here

%%
choices = {...
    'Accept sources' ...
    'Reject sources' ...
    'Set sources to undecided' ...
    'Focus source' ...
    'Show sources' ...
    'Show all sources' ...
    'Show all accepted sources' ...
    'Show all undecided sources' ...
    'Hide sources' ...
    'Hide all sources' ...
    'Hide all rejected sources' ...
    'Hide all accepted sources' ...
    'Browse sources' ...
    'Compare sources' ...
    'Configure sorting UI' ...
    'Finish sorting' ...
};
prompt = 'What do you want to do?';

%%
glab.ca.sort.banner('BATCH SORT');

glab.ca.sort.showLocs(db, db.focus, db.secFocus);
glab.ca.sort.showTraces(db, db.focus);

choice = glab.ui.console.picker(choices, prompt);

if choice == 1
    % Accept
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.status(idcs) = glab.ca.sort.status.ACCEPTED;
    end
elseif choice == 2
    % Reject
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.status(idcs) = glab.ca.sort.status.REJECTED;
    end
elseif choice == 3
    % Undecide
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.status(idcs) = glab.ca.sort.status.UNDECIDED;
    end
elseif choice == 4
    % Focus
    idx = glab.ca.sort.inputSrcs(db, false);
    if isempty(idx)
        % Nothing
    else
        db.focus = idx;
    end
elseif choice == 5
    % Show sources
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        db.secFocus = [db.secFocus; idcs];
    end
elseif choice == 6
    % Show all sources
    db.secFocus = (1:db.const.nSrcs)';
elseif choice == 7
    % Show all accepted sources
    db.secFocus = ...
        [db.secFocus; find(db.status == glab.ca.sort.status.ACCEPTED)];
elseif choice == 8
    % Show all undecided sources
    db.secFocus = ...
        [db.secFocus; find(db.status == glab.ca.sort.status.UNDECIDED)];
elseif choice == 9
    % Hide sources
    idcs = glab.ca.sort.inputSrcs(db, true);
    if isempty(idcs)
        % Nothing
    else
        [~, rmIdcs] = intersect(db.secFocus, idcs);
        db.secFocus(rmIdcs) = [];
    end
elseif choice == 10
    % Hide all sources
    db.secFocus = [];
elseif choice == 11
    % Hide all rejected sources
    [~, rmIdcs] = intersect(...
        db.secFocus, ...
        find(db.status == glab.ca.sort.status.REJECTED) ...
    );
    db.secFocus(rmIdcs) = [];
elseif choice == 12
    % Hide all accepted sources
    [~, rmIdcs] = intersect(...
        db.secFocus, ...
        find(db.status == glab.ca.sort.status.ACCEPTED) ...
    );
    db.secFocus(rmIdcs) = [];
elseif choice == 13
    % Browse
    db.context = glab.ca.sort.context.BROWSE;
    db.secFocus = [];
elseif choice == 14
    % Compare sources
    db.context = glab.ca.sort.context.COMPARE;
    db.secFocus = [];
elseif choice == 15
    % Configure
    db.context = glab.ca.sort.context.CONFIGURE;
elseif choice == 16
    db.context = glab.ca.sort.context.FINISH;
end

db.secFocus(db.secFocus == db.focus) = [];
db.secFocus = unique(db.secFocus);

end

