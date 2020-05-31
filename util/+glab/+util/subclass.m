function val = subclass(obj, superclass)
%SUBCLASS Return true if a MATLAB object is a subclass of a superclass.
% v1.0.0 | nGelwan | 2018
% Usage:
% val::bool = glab.util.subclass(obj::any, superclass::string);
%   Return true if `obj` is a subclass of the class specified by
%   `superclass`.

%%
val = any(strcmp(superclass, superclasses(obj)));

end

