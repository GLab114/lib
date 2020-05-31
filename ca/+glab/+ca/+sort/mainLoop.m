function status = mainLoop(db)
%MAINLOOP Summary of this function goes here
%   Detailed explanation goes here

while true
    glab.ca.sort.autosave(db);
    
    if db.context == glab.ca.sort.context.BATCHSORT
        db = glab.ca.sort.batchSort(db);
    elseif db.context == glab.ca.sort.context.BROWSE
        db = glab.ca.sort.browse(db);
    elseif db.context == glab.ca.sort.context.COMPARE
        db = glab.ca.sort.compare(db);
    elseif db.context == glab.ca.sort.context.CONFIGURE
        db = glab.ca.sort.configure(db);
    elseif db.context == glab.ca.sort.context.FINISH
        status = db.status;
        break
    end
    
    db.asvCtr = db.asvCtr + 1;
end
end

