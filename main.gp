g = Mod(6, 682492462409094395392022581537473179285250139967739310024802121913471471);
A = 245036439927702828116237663546936021015004354074422410966568949608523157;
n = 682492462409094395392022581537473179285250139967739310024802121913471471;

babystepgiantstep(gen, A1, mod) = {
	B = sqrtint(mod) + 1;
	small = Map();
	for(i=0, B-1, mapput(small, gen^i, i););
	genb = gen^(-B);
	v = 1;
	for(j=0, B+1,
	c = genb^j;
	val = A1*c;
	if(mapisdefined(small, val, &v), return(j*B + v);););
}

PHsimple(gen, h, p, e) = {
	x = 0;
	gam = gen^(p^(e-1));
	for(k=0, e-1,
		hk = ((gen^(-x))*h)^(p^(e-1-k));
		d = babystepgiantstep(gam, hk, p);
		x = x + d*(p^k);
	);
	return(x);
}

PH(gen, A2, m) = {
	f = factor(m-1);
	t = matsize(f)[1];
	liste = vector(t);
	for(k = 1, t,
		p = f[k, 1];
		e = f[k, 2];
		gk = gen^((m-1)/(p^e));
		h = Mod(A2, m)^((m-1)/(p^e));
		ak = PHsimple(gk, lift(h), p, e);
		liste[k] = Mod(ak, p^e);
	);
	a = lift(Mod(lift(chinese(liste)), m));
	return(a);
}

print(PH(g, A, n));
