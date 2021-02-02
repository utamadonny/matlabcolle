syms lxx lyy lzz lxz p q r p_dot q_dot r_dot

l=[lxx 0 -lxz; 0 lyy 0 ; -lxz 0 lzz];

l*[p_dot; q_dot; r_dot]+cross([p;q;r],l*[p; q; r])