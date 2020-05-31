classdef ExtentDim
    %EXTENTDIM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lb
        ub
    end
    
    methods
        function obj = ExtentDim(lb, ub)
            if ~(isempty(lb) && isempty(ub)) && ...
                    (isempty(lb) || isempty(ub))
                error('If dimension is empty, both extents must be empty');
            elseif ~(lb > 0)
                error('Extent dimension must not index below zero');
            elseif ~(lb < ub)
                error(['Extent dimension must have lower-bound less ' ...
                    'than upper-bound.']);
            end
            
            obj.lb = lb;
            obj.ub = ub;
        end
        
        function val = isEmpty(obj)
            val = isempty(obj.lb) && isempty(obj.ub);
        end
        
        function val = isFull(obj)
            val = (obj.lb == 1) && (obj.ub == Inf);
        end
    end
    
    methods (Static = true)       
        function obj = empty()
            obj = glab.lib.util.Extent([], []);
        end
        
        function obj = full()
            obj = glab.lib.util.Extent(1, Inf);
        end
    end
end

