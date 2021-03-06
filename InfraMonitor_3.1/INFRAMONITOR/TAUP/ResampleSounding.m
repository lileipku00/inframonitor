function [z,t,u,v] = ResampleSounding(dz,soundingfile)
% ResampleSounding - Resamples atmospheric sounding data onto a regularly
% spaced profile
%
% dz is the desired vertical sampling in km
%
% e.g.,
% [z,t,u,v] = ResampleSounding(0.1,'Wells_ELKO_Sounding.met');
%
% (Note: Use WriteMetFile.m to store results in a met file)
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
% ·         Redistributions of source code must retain the above copyright notice, this list
% 		  of conditions and the following disclaimer.
% ·         Redistributions in binary form must reproduce the above copyright notice, this
% 	      list of conditions and the following disclaimer in the documentation and/or
% 	      other materials provided with the distribution.
% ·         Neither the name of Los Alamos National Security, LLC, Los Alamos National
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

x = load(soundingfile,'-ascii');

z1 = (0:dz:200);

[u1,i1] = min(abs(min(x(:,1))-z1));
[u2,i2] = min(abs(max(x(:,1))-z1));

z = (z1(i1):dz:z1(i2));
t = spline(x(:,1),x(:,2),z);
u = spline(x(:,1),x(:,3),z);
v = spline(x(:,1),x(:,4),z);

% Plotting resampling results:
figure

subplot(1,3,1)
plot(x(:,2),x(:,1),'o-')
hold on
plot(t,z,'ro-')
xlabel('Temp (K)')
ylabel('Elev (km)')

subplot(1,3,2)
plot(x(:,3),x(:,1),'o-')
hold on
plot(u,z,'ro-')
xlabel('Zonal wind (m/s)')
ylabel('Elev (km)')

subplot(1,3,3)
plot(x(:,4),x(:,1),'o-')
hold on
plot(v,z,'ro-')
xlabel('Meridional wind (m/s)')
ylabel('Elev (km)')
