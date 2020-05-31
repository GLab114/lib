classdef MutableState
    %MUTABLESTATE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        e = {};
    end
    
    methods
        function obj = MutableState()
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        function
    end
end

