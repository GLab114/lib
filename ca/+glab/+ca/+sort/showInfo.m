function [] = showInfo(db, idcs, highlight)
%SHOWINFO Summary of this function goes here
%   Detailed explanation goes here

%%
defaultHighlight = false;
if ~exist('highlight', 'var')
    highlight = defaultHighlight;
end

%%
fmtStatus = cell(db.const.nSrcs, 1);
fmtStatus(db.status == glab.ca.sort.status.ACCEPTED) = {'accepted'};
fmtStatus(db.status == glab.ca.sort.status.REJECTED) = {'rejected'};
fmtStatus(db.status == glab.ca.sort.status.UNDECIDED) = {'undecided'};

indicator = zeros(db.const.nSrcs, 1);
if highlight
    indicator(db.focus) = 1;
end

T = table(...
    indicator, db.const.srcNames, fmtStatus, ...
    'VariableNames', {'focus' 'source' 'status'} ...
);

disp(T(idcs, :));

end

