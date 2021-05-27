set O;		# operations
set P;		# products
param T;	# periods

param r{o in O, p in P};	# production rates (inverse)
param v{p in P, t in 1..T};	# sales prices per product/period
param S;        # Operational cost 5000 solarcoins
param h;	    # unit inventory cost per period
param b;        # backlog cost 2 solarcoins

var s{p in P, t in 0..T} >= 0;	# inventory
var z{p in P, t in 1..T} >= 0;	# production
var bl{p in P, t in 0..T} >= 0; # backlog
var x{p in P, t in 1..T} >= 0;  # qty of product sold in that week

#

maximize profit: sum {p in P, t in 1..T} x[p,t]*v[p,t] - sum {p in P, t in 1..T} h*s[p,t] - sum{p in P, t in 1..T} bl[p,t] * b;

s.t.
Occupation {o in O, t in 1..T}:
  sum {p in P} z[p,t]/r[o,p] <= 1;

BOM {p in P, t in 1..T}:
  z[p,t] + s[p,t-1] + bl[p,t-1] = x[p,t] + s[p,t] + bl[p,t];
  
#MustSellAll:
#  sum {p in P, t in 1..T} (s[p,t] + bl[p,t]) = 0;
  
Inits {p in P}: 
  s[p,0] = 0;
  
InitBL {p in P}:
  bl[p,0] = 0;

end;
