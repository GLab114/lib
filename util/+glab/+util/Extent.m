classdef Extent
    %EXTENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dims
        nDims
    end
    
    methods
        function obj = Extent(dims)
            obj.dims = dims;
            obj.nDims = length(dims);
        end
        
        function idcs = toIdcs(obj, sz)
        end
        
        function val = inSize(obj, sz)
        end
        
        function val = trivial(obj)
            val = false;
            for i = 1:obj.nDims
                dim = obj.dims{i};
                if ~dim.empty
                    val = true;
                    break
                end
            end
        end
        
        function [int1, int2] = intersect(extent1, extent2)
            nDims = max(extent1.nDims, extent2.nDims); %#ok<PROPLC>
            
            for i = 1:nDims
                
            end
        end
        
        function obj = reifyAgainstExtent(obj, extent)
            
        end
        
        function obj = reifyAgainstSize(obj, sz)
            if obj.trivial
                error(['Cannot reify trivial ' obj.toString()]);
            end
            if ~obj.inSize(sz)
                error(['Cannot reify ' obj.toString() ' against ' ...
                    num2str(sz) '; former not contained within latter']);
            end
            
            for i = 1:obj.nDims
                d = obj.dims{i};
                
                if d.isFull()
                    d.ub = sz(i);
                end
                
                obj.dims{i} = d;
            end
        end
        
        function str = toString(obj)
            c = cell(1, obj.nDims);
            for i = 1:obj.nDims
                d = obj.dims{i};
                if d.isEmpty()
                    c{i} = '[]';
                else
                    c{i} = [num2str(d.lb) ':' num2str(d.ub)];
                end
            end
            
            str = ['Extent<' strjoin(c, ', ') '>'];
        end
    end
end

