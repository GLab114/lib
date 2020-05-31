classdef CachedComp < glab.proc.AbsComp
    %CACHEDCOMP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fn
        nOut
        cacheChkFn
        cacheReadFn
        cacheWriteFn
        logger
    end
    
    methods
        function obj = CachedComp(fn, nOut, cacheChkFn, cacheReadFn, ...
                cacheWriteFn, varargin)
            %%
            defaultLogger = glab.util.defaultLogger();
            
            p = inputParser();
            addParameter(p, 'logger', defaultLogger ...
                );
            parse(p, varargin{:});
            
            l = p.Results.logger;
            
            %%
            obj.fn = fn;
            obj.nOut = nOut;
            obj.cacheChkFn = cacheChkFn;
            obj.cacheReadFn = cacheReadFn;
            obj.cacheWriteFn = cacheWriteFn;
            obj.logger = l;
            
        end
        
        function results = run(obj, args)
            if obj.cacheChkFn()
                obj.logger.info('Using cached results');

                results = obj.cacheReadFn();

            else
                obj.logger.info('Not using cached results');

                results = glab.proc.runComp(obj.fn, obj.nOut, args);
                obj.cacheWriteFn(results);

            end

        end
    end
end

