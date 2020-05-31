function j = inputSrcs(db, multi)
%INPUTSRC Summary of this function goes here
%   Detailed explanation goes here

%%
if multi
    multiMsg = '(s). Multiple sources may be separated by whitespace.';
else
    multiMsg = '.';
end
prompt = ['Input source name' multiMsg ' Enter nothing to abort.'];

j = glab.ui.console.getAndValidate(...
    @srcValidator,...
    'isChar', true,...
    'validatorVarargin', {db.const.srcNames, multi},...
    'prompt', prompt...
);

end


function idcs = srcValidator(input, varargin)
srcNames = varargin{1};
multi = varargin{2};
if isempty(input)
    idcs = [];
else
    each = split(input);
    nEach = length(each);
    if nEach > 1 && ~multi
        error('Please only enter a single source name.');
    end
    idcs = zeros(nEach, 1);
    for i = 1:length(each)
        name = upper(each{i});
        idx = find(strcmp(name, srcNames), 1);
        if isempty(idx)
            error(['Source ''' name ''' could not be found. ' ...
                'Please try again.']);
        end
        idcs(i) = idx;
    end
end
end