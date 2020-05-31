classdef Logger < handle
    %LOGGER Interface for the console and programmatic subroutine loggers.
    %This class is not-concrete, is abstract, etc..
    
    properties
    end
    
    methods
        function obj = Logger()
            %LOGGER Construct an instance of this class
        end
        
        function [] = log(obj, arg1, arg2, arg3)
            if nargin == 4
                type = arg1;
                lvl = arg2;
                msg = arg3;
                
                expectedTypes = {'update' 'enter' 'exit'};
                validatestring(type, expectedTypes);
                
                event = glab.log.event(lvl, msg);
                event.type = type;
            elseif nargin == 2
                event = arg1;
            end
            obj.handle(event);
        end
        
        function [] = srU(obj, lvl, msg)
            obj.log('update', lvl, msg);
        end
        
        function [] = srE(obj, lvl, msg)
            obj.log('enter', lvl, msg);
        end
        
        function [] = srX(obj)
            obj.log('exit', -1, '');
        end
        
        function [] = debug(obj, msg)
            obj.srU(glab.log.DEBUG, msg);
        end
        
        function [] = debugSrE(obj, msg)
            obj.srE(glab.log.DEBUG, msg)
        end
        
        function [] = info(obj, msg)
            obj.srU(glab.log.INFO, msg);
        end
        
        function [] = infoSrE(obj, msg)
            obj.srE(glab.log.INFO, msg)
        end   
        
        function [] = warning(obj, msg)
            obj.srU(glab.log.WARNING, msg);
        end
        
        function [] = warningSrE(obj, msg)
            obj.srE(glab.log.WARNING, msg)
        end     
        
        function [] = error(obj, msg)
            obj.srU(glab.log.ERROR, msg);
        end
        
        function [] = errorSrE(obj, msg)
            obj.srE(glab.log.ERROR, msg)
        end   
        
        function [] = critical(obj, msg)
            obj.srU(glab.log.CRITICAL, msg);
        end
        
        function [] = criticalSrE(obj, msg)
            obj.srE(glab.log.CRITICAL, msg)
        end   
    end
end

