%-- 2020.02.11. --%

% median
function retval = m_med(vector)
	% mintha hosszanak meghatarozasa
	n = length(vector);
	% minta rendezese
	vecstar = sort(vector);
	%kozepso elem mehatarozasahoz
	tmpind = floor(n / 2);
	%rem
	%kozepso elem meghatarozasa median szamitasa
	if (mod(n , 2) == 0)
		retval = (vecstar(tmpind) + vecstar(tmpind + 1)) / 2;
	else
		retval = vecstar(tmpind + 1);
	endif
endfunction

% atlag (empirikus kozep)
function retval = m_avg(vector)
	retval = sum(vector) / length(vector);
endfunction

% median abszolut elteres Median absolute deviation MAD
function retval = m_mad(vector)
	med = m_med(vector);
	n = length(vector);
	for i = 1 : n
		tmpmad(i) = abs(vector(i) - med);
	endfor
	retval = m_med(tmpmad);
endfunction

% minta terjedelem
function retval = m_range(vector)
	% mintha hosszanak meghatarozasa
	n = length(vector);
	% minta rendezese
	vecstar = sort(vector);
	retval = vecstar(n) - vecstar(1);
endfunction

%empirikus szorasnegyzet sn^2
function retval = m_s2n(vector)
	avg = m_avg(vector);
	n = length(vector);
	tmps2n = 0;
	for i = 1 : n
		tmps2n += (vector(i) - avg) ^ 2;
	endfor
	retval = tmps2n / n;
endfunction

%empirikus szoras sn
function retval = m_sn(vector)
	retval = sqrt(m_s2n(vector));
endfunction

%korrigalt empirikus tapasztalati szorasnegyzet sn*^2
function retval = m_s2sn(vector)
	avg = m_avg(vector);
	n = length(vector);
	tmps2sn = 0;
	for i = 1 : n
		tmps2sn += (vector(i) - avg) ^ 2;
	endfor
	retval = tmps2sn / (n - 1);
endfunction

%korrigalt empirikus tapasztalati szoras sn*
function retval = m_ssn(vector)
	retval = sqrt(m_s2sn(vector));
endfunction

%n-edik momentum
function retval = m_nmoment(vector,k)
	n = length(vector);
	retval = 0;
	p = 1 / n;
	for i = 1 : n
		retval += vector(i)^k * p;
	endfor
endfunction

%szorasi egyutthato
function retval = m_szoregyh(vector)
	retval = m_sn(vector) / m_avg(vector);
endfunction

%tapasztalati kvantilis
function retval = m_kvantils(vector,p)
	n = length(vector);
	vecstar = sort(vector);
	np = n * p;
	a = floor(np);
	b = a + 1;
	q = abs(floor(np) - np);
	retval = (1 - q) * vecstar(a) + q * vecstar(b);
endfunction

%steiner formula (ismeretlen szorasnegyzet)
function retval = m_steiner(vector,a)
	n = length(vector);
	steiner = 0;
	for i = 1 : n
		steiner += (vector(i) - a) ^ 2;
	endfor
	retval = steiner - n * (m_avg(vector) - a) ^ 2;
endfunction


%---gyakker1---
minta_elm = [-5, 9, 3, 0, -2];
minta_a = [1, 2, 4, -2, 5, 7, -10, -12, -11, 9];
minta_b = [1.2, 3.85, 1.81, 3.44, 1.92, 2.1, 2.99, 2.81, 3.27, 3.21];
k = 2;
p = 0.23;
a = 1.23;
printf("A minta realizacioja \n"); disp(minta_b);
printf("A rendezett minta \n"); disp(sort(minta_b));
printf("A minta medianja %f \n", m_med(minta_b));
printf("A minta atlaga (empirikus kozepe) %f \n", m_avg(minta_b));
printf("A minta abszolut elterese (MAD) %f \n", m_mad(minta_b));
printf("A minta terjedelme %f \n", m_range(minta_b));
printf("A minta empirikus szorasnegyzete sn^2 %f \n", m_s2n(minta_b));
printf("A minta empirikus szorasa sn %f \n", m_sn(minta_b));
printf("A minta korrigalt empirikus tapasztalati szorasnegyzete sn*^2 %f \n", m_s2sn(minta_b));
printf("A minta korrigalt empirikus tapasztalati szorasa sn* %f \n", m_ssn(minta_b));
printf("A minta %d-edik momentuma %f \n", k, m_nmoment(minta_b,k));
printf("A minta szorasi egyutthatoja %f \n", m_szoregyh(minta_b));
printf("A minta %f tapasztalati kvantilise %f \n", p, m_kvantils(minta_b,p));
printf("steiner formula (%f ismeretlen szorasnegyzet) %f \n", a, m_steiner(minta_b,a));
