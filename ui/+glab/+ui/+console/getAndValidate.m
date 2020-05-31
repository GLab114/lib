function val = getAndValidate(validator, varargin)
%GETANDVALIDATE Prompts user for input, validates, and returns the 
% validated input.

%% Input parsing
defaultPrompt = '';
defaultValidatorVarargin = {};
defaultIsChar = false;

p = inputParser();
addParameter(p, 'prompt', defaultPrompt, @ischar);
addParameter(p, 'validatorVarargin', defaultValidatorVarargin, @iscell);
addParameter(p, 'isChar', defaultIsChar, @islogical);
parse(p, varargin{:});

prompt = p.Results.prompt;
validatorVarargin = p.Results.validatorVarargin;
isChar = p.Results.isChar;
%%

valid = false;
while ~valid
    if ~isempty(prompt)
        disp(prompt);
    end
    
    if isChar
        val = input(': ', 's');
    else
        try
            val = input(': ');
        catch ME
            disp(ME.message);
        end
    end
    
    try
        val = validator(val, validatorVarargin{:});
        break
    catch ME
        disp(ME.message);
    end
end
end

