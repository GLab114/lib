classdef Logger < glab.log.subroutine.Logger
    %LOGGER Mutable state to simplify the syntax for programmatic storage 
    %of logging events. Useful for async logging.
    
    properties
        % I wanted this to be called `events`, but something is up with
        % MATLAB so that's a no-no. I'll just wrap it in a getter
        e = [];
    end
    
    methods
        function obj = Logger()
            %LOGGER Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function [] = handle(obj, event)
            % Handling implementation
            obj.e = [obj.e event];
        end
        
        function e = events(obj)
            % Pointless getter because MATLAB wouldn't let me name my
            % variable the way I wanted to
            e = obj.e;
        end
    end
end

