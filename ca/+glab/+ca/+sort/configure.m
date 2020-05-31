function db = configure(db)
%OPTIONSLOOP Summary of this function goes here
%   Detailed explanation goes here

%%
choices = { ...
    'Toggle background' ...
    'Toggle source boundaries' ...
    'Toggle source shading' ...
    'Browse sources' ...
    'Batch sort sources' ...
};
prompt = 'What do you want to do?';

%%
glab.ca.sort.banner('CONFIGURE');

glab.ca.sort.showLocs(...
    db, ...
    db.focus, ...
    [(1:db.focus - 1) (db.focus + 1:db.const.nSrcs)] ...
);
glab.ca.sort.showTraces(db, db.focus);

choice = glab.ui.console.picker(choices, prompt);

if choice == 1
    db.showRef = 1 - db.showRef;
elseif choice == 2
    db.showBdrs = 1 - db.showBdrs;
elseif choice == 3
    db.showShading = 1 - db.showShading;
elseif choice == 4
    db.context = glab.ca.sort.context.BROWSE;
elseif choice == 5
    db.context = glab.ca.sort.context.BATCHSORT;
end

end

