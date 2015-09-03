% ne_baz.m computes backazimuth from n,e component
% using signal generated by make_zen_signal_model.m

close all
if isempty(dbstatus);clear all;end

wl = 0.1;
swl = 0.1;

load ZEN_signal

t = ZEN_signal.ts;
Nt = ZEN_signal.Nt;
Et = ZEN_signal.Et;
npts = ZEN_signal.N;

dt = t(2)-t(1);
nw = round(wl/dt);
ns = round(swl/dt);
N = fix((npts+ns-nw)/ns)-1;
wi = repmat([1:nw+1]',1,N) + repmat([0:ns:ns*(N-1)],nw+1,1);
tk = t(wi(1,1:end)+nw);
NE = [Nt Et];

baz = zeros(N,1);
for i = 1:N
   C = cov(NE(wi(:,i),:));
   [V,D] = eig(C);                      % eig.m gives normalized eigenvalues
   [~,jj] = max(diag(D));
   thetap = rad2deg(atan2(V(2,jj),V(1,jj)));
   baz(i) = wrapTo360(thetap);
   ls = sort(diag(D),'descend');
   rect(i) = 1 - ls(2)/ls(1);
end

figure(1);
ax(1) = subplot(3,1,1);
plot(tk,baz,'o')
ax(2) = subplot(3,1,2);
plot(tk,rect,'o')
ax(3) = subplot(3,1,3);
plot(t,Nt,'r',t,Et,'b')
linkaxes(ax,'x')