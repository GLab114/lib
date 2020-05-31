function val = prefix(prefix)
%PREFIX Return how many bytes in one unit. 
% v0.1.0 | N Gelwan | 2020-05
%   Because I can never remember what powers are what.
%
%
%
%   Usage:
%   val::int = glab.util.sizeof.prefix(prefix::string)
%   Accepted values for `prefix` are: 'B' (byte), 'k' (kilobyte), 'M'
%   (megabyte), 'G' (gigabyte), 'T' (terabyte), 'P' (petabyte), 'Ki'
%   (kibibyte), 'Mi' (mebibyte), 'Gi' (gibibyte), 'Ti' (tebibyte), and 'Pi'
%   (pebibyte). Case-insensitive.
%
%   Errors:
%   - 'InputError': if `prefix` is any value not listed above.
%
%   Examples:
%   >> glab.util.sizeof.prefix('Mi')
%
%   ans =
%
%     1048576
%
%   >> glab.util.sizeof.prefix('M')
%
%   ans =
%
%     1000000

switch lower(prefix)
    case 'b'
        val = glab.util.sizeof.B;
    case 'k'
        val = glab.util.sizeof.KB;
    case 'm'
        val = glab.util.sizeof.MB;
    case 'g'
        val = glab.util.sizeof.GB;
    case 't'
        val = glab.util.sizeof.TB;
    case 'p'
        val = glab.util.sizeof.PB;
    case 'ki'
        val = glab.util.sizeof.KiB;
    case 'mi'
        val = glab.util.sizeof.MiB;
    case 'gi'
        val = glab.util.sizeof.GiB;
    case 'ti'
        val = glab.util.sizeof.TiB;
    case 'pi'
        val = glab.util.sizeof.PiB;
    otherwise
        error('Prefix not supported');
end
end

