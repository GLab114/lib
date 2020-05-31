classdef Logger < glab.log.subroutine.Logger
    %LOGGER Mutable state to simplify syntax for logging to the console.
    %Abstracts logging "subroutines", in the sense that events which are
    %semantically subordinate to others will be displayed at a higher
    %indentation.
    
    properties
         subroutines = {};
         depth = 0;
         thresh = 0;
    end
    
    methods
        function obj = Logger(varargin)
            %LOGGER Construct an instance of this class
            defaultThresh = glab.log.INFO;
            
            p = inputParser();
            addParameter(p, 'threshold', defaultThresh ...
                );
            parse(p, varargin{:});
            
            thr = p.Results.threshold;
            
            %%
            obj.thresh = thr;
        end
        
        function [] = handle(obj, event)
            % Handle implemenetation
            % Pre-disp
            if strcmp(event.type, 'exit')
                if obj.depth > 0
                    t = toc(obj.parentTic());
                    msg = ['Done (' glab.log.fmt.toc(t) ')'];
                    lvl = obj.parentLevel();
                    event.msg = msg;
                    event.lvl = lvl;
                end
            end
            
            obj.updateSubroutines(event);

            if event.lvl - obj.thresh >= 0
                disp([ ...
                    glab.log.fmt.dt(event) ...
                    glab.log.fmt.lvl(event) ...
                    glab.log.fmt.indent(obj.depth) ...
                    event.msg ...
                ]);

                obj.updateDepth(event);
            end
        end
        
        function lvl = parentLevel(obj)
            if obj.depth > 0
                event = obj.subroutines{obj.depth};
                lvl = event.lvl;
            end
        end
        
        function t = parentTic(obj)
            if obj.depth > 0
                event = obj.subroutines{obj.depth};
                t = event.tic;
            end
        end
        
        function [] = updateDepth(obj, event)
            if strcmp(event.type, 'enter')
                obj.depth = obj.depth + 1;
            elseif strcmp(event.type, 'update')
            elseif strcmp(event.type, 'exit')
                if obj.depth > 0
                    obj.depth = obj.depth - 1;
                end
            end
        end
        
        function [] = updateSubroutines(obj, event)
            if strcmp(event.type, 'enter')
                obj.subroutines{obj.depth + 1} = event;
            elseif strcmp(event.type, 'update')
                obj.subroutines{obj.depth + 1} = event;
            elseif strcmp(event.type, 'exit')
                if obj.depth > 0
                    obj.subroutines(end) = [];
                end
            end
        end
    end
end

