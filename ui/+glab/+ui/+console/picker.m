function choice = picker( choices, prompt )
    %PICKER Summary of this function goes here
    %   Detailed explanation goes here
    nChoices = length(choices);
    
    if ~exist('prompt', 'var')
        prompt = 'Here are your choices: ';
    end
    
    % Display choices
    disp(prompt);
    for i = 1:nChoices
        disp([num2str(i) ') ' choices{i}]); 
    end

    % Choose choice
    choice = glab.ui.console.getAndValidate(@validateChoice, ...
        'validatorVarargin', {nChoices}...
    );
end

function val = validateChoice(val, nChoices)
    if floor(val) ~= val || length(val) ~= 1 || val < 1 || ...
            val > nChoices
        error(['Please choose an integer value between 1 and '...
            num2str(nChoices)]);
    end
end

