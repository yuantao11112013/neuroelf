function display(ti)
% transimg::display  - display an image

% Version:  v0.9a
% Build:    10051716
% Date:     May-17 2010, 10:48 AM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2010, Jochen Weber
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of Columbia University nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% global variables for storage
global tiobj ...
       tiobjlup;

% check arguments
lup = find(tiobjlup == ti.L);
if numel(lup) ~= 1
    error( ...
        'transimg:ObjectRemoved', ...
        'Object removed from global storage.' ...
    );
end

% only if width/height > 0
if any([tiobj(lup).Width, tiobj(lup).Height] == 0)
    return;
end

% which object
if isempty(tiobj(lup).Handle) || ...
   ~ishandle(tiobj(lup).Handle)
    f = figure;
    x = axes;
    tiobj(lup).Handle = image(tiobj(lup).Rendered);
    set(f, 'Units', 'pixels');
    fp = get(f, 'Position');
    fp(3:4) = [tiobj(lup).Width, tiobj(lup).Height];
    set(f, 'Position', fp);
    set(f, 'Units', 'normalized', 'NumberTitle', 'off', 'Name', ...
        sprintf('transimg: %d x %d', tiobj(lup).Width, tiobj(lup).Height));
    set(x, 'Position', [0, 0, 1, 1]);
else
    set(tiobj(lup).Handle, 'CData', tiobj(lup).Rendered);
end
