function dxdt = replicator_dynamic(t,x,A)
fi = A*x;   %xidot = xi(fi(x)-phi) where phi=sum(xifi)
phi = transpose(x)*fi;   %xidot also = xi(t)((Ax)i-xAx)
dxdt = x.*(fi - phi);    %sub all terms into replicator equation above
end