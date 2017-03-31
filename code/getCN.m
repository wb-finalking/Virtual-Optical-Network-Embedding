function CN = getCN(ts,td1,td2,E_sub_slot)
global N;
CN=0;
for i=1:N
    CN=CN+E_sub_slot(ts,td1,i)&E_sub_slot(ts,td2,i);
end

end

