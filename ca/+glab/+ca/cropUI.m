function rect = cropUI(ref)
% CROPUI Minimal user interface for cropping.

%%
rect = mainLoop(ref);

end


function rect = mainLoop(ref)
rect = [];

choices = {...
    'Crop' ...
    'Done' ...
};
prompt = 'What do you want to do?';

fig = figure();
while true
    fig = show(fig, ref, rect);

    choice = glab.ui.console.picker(choices, prompt);

    if choice == 1
        rect = cropLoop([], ref, fig);
    elseif choice == 2
        % Done
        if isvalid(fig)
            close(fig);
        end
        break
    end
end

end


function rect = cropLoop(rect, ref, fig)
nPixels2 = size(ref);

choices = {...
    'Set top right corner' ...
    'Set bottom left corner' ...
    'Done' ...
};
prompt = 'What do you want to do?';

left = nan;
right = nan;
bottom = nan;
top = nan;
while true
    rect = [top left bottom right];

    fig = show(fig, ref, rect);
    
    choice = glab.ui.console.picker(choices, prompt);
    
    if choice == 1
        % Set top right corner
        fig = show(fig, ref, rect);
        
        [x, y] = ginput(1);
        x = min(max(round(x), 1), nPixels2(2));
        y = min(max(round(y), 1), nPixels2(1));  
        
        if isnan(right)
            right = x;
        elseif x == left
            right = nan;
            left = nan;
        elseif x < left
            right = left;
            left = x;
        elseif x > left
            right = x;
        end
        if isnan(top)
            top = y;
        elseif y == bottom
            bottom = nan;
            top = nan;
        elseif y < bottom
            top = bottom;
            bottom = y;
        elseif y > bottom
            top = y;
        end
    elseif choice == 2
        % Set bottom left corner
        fig = show(fig, ref, rect);
        
        [x, y] = ginput(1);
        x = min(max(round(x), 1), nPixels2(2));
        y = min(max(round(y), 1), nPixels2(1));
        
        if isnan(left)
            left = x;
        elseif x == right
            right = nan;
            left = nan;
        elseif x < right
            left = x;
        elseif x > right
            left = right;
            right = x;
        end
        if isnan(bottom)
            bottom = y;
        elseif y == top
            bottom = nan;
            top = nan;
        elseif y < top
            bottom = y;
        elseif y > top
            bottom = top;
            top = y;
        end
    elseif choice == 3
        break
    end
end

end


function val = validateChoice(val, nChoices)
    if floor(val) ~= val || length(val) ~= 1 || val < 1 || ...
            val > nChoices
        error(['Please choose an integer value between 1 and '...
            num2str(nChoices)]);
    end
    
end


function fig = show(fig, ref, rect)
    if ~isvalid(fig)
        fig = figure();
    end
    clf(fig, 'reset');
    
    hold('off');
    image(ref, 'CDataMapping', 'scaled');
    hold('on');
    
    % Show rect
    if ~isempty(rect)
        top = rect(1);
        left = rect(2);
        bottom = rect(3);
        right = rect(4);

        color = 'red';
        if ~any(isnan([left right top bottom]))
            line([left left; ...
                  left right; ...
                  right right; ...
                  right left], ...
                 [top bottom; ...
                  bottom bottom; ...
                  bottom top; ...
                  top top], ...
                  'LineWidth', 2, ...
                  'Color', color ...
             );
        end
    end
    
end
