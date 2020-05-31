function [] = autosave(db)
%AUTOSAVE Summary of this function goes here
%   Detailed explanation goes here

%%
if ~isempty(db.const.asvFilePath)
    if mod(db.asvCtr, db.const.asvFreq) == 0
        status = db.status;
        disp('Autosaving...');
        glab.util.matSave(db.const.asvFilePath, status);
    end
end

end

