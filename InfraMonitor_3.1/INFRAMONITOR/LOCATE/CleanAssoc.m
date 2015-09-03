function [assoc,toassoc] = CleanAssoc(associn)
%
% Removes associations containing duplicate arrivals
%
% Stephen Arrowsmith (arrows@lanl.gov)
% Copyright (c) 2012, Los Alamos National Security, LLC
% All rights reserved.
% 
% Copyright 2012. Los Alamos National Security, LLC. This software was produced under U.S.
% Government contract DE-AC52-06NA25396 for Los Alamos National Laboratory (LANL), which is
% operated by Los Alamos National Security, LLC for the U.S. Department of Energy. The U.S.
% Government has rights to use, reproduce, and distribute this software.  NEITHER THE
% GOVERNMENT NOR LOS ALAMOS NATIONAL SECURITY, LLC MAKES ANY WARRANTY, EXPRESS OR IMPLIED,
% OR ASSUMES ANY LIABILITY FOR THE USE OF THIS SOFTWARE.  If software is modified to produce
% derivative works, such modified software should be clearly marked, so as not to confuse it
% with the version available from LANL.
% 
% Additionally, redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list
% 		  of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this
% 	      list of conditions and the following disclaimer in the documentation and/or
% 	      other materials provided with the distribution.
% Neither the name of Los Alamos National Security, LLC, Los Alamos National
% 	      Laboratory, LANL, the U.S. Government, nor the names of its contributors may be
% 	      used to endorse or promote products derived from this software without specific
% 	      prior written permission.
% THIS SOFTWARE IS PROVIDED BY LOS ALAMOS NATIONAL SECURITY, LLC AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
% EVENT SHALL LOS ALAMOS NATIONAL SECURITY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
% OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
% WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

global assoc

allAssoc = []; allNo = []; toassoc = 0;
for i = 1:numel(associn)
    thisAssoc = cat(2,associn(i).arrays',associn(i).atimes');
    thisNo = repmat(i,size(thisAssoc,1),1);
    
    [c,ia,ib] = intersect(thisAssoc,allAssoc,'rows');
    
    if (numel(ib) ~= 0)
        toassoc = 1;
        nos = unique(allNo(ib));
        for j = 1:numel(nos)
            associn(nos(j)).arrays = 0;
            associn(nos(j)).atimes = 0;
            associn(nos(j)).baz = 0;
        end
        associn(i).arrays = 0;
        associn(i).atimes = 0;
        associn(i).baz = 0;
    end
    allAssoc = cat(1,allAssoc,thisAssoc);
    allNo = cat(1,allNo,thisNo);
end

j = numel(assoc);
for i = 1:numel(associn)
    if (numel(associn(i).atimes)~= 1)
        j=j+1;
        assoc(j).arrays = associn(i).arrays;
        assoc(j).atimes = associn(i).atimes;
        assoc(j).baz = associn(i).baz;
    end
end