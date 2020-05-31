function [] = blockUntilInput( key )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
while true
    if ~exist('key', 'var')
        key = '';
    end
    
    if isempty(key)
        prompt = 'Enter anything to continue...';
        disp(prompt);
        x = input(': ', 's');
        return
    else
        prompt = ['Enter ''' key ''' to continue...'];
        disp(prompt);
        x = input(': ', 's');
        if strcmp(x, key)
            return
        end
    end
end
end

