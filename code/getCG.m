function  CG = getCG(ts,td1,td2,E_sub_slot)

    global N;

    for i=1:N
        delta(i)=E_sub_slot(ts,td1,i)&E_sub_slot(ts,td2,i);
    end
    CG=0;
    for i=1:N-1
        CG=CG+abs(delta(i)-delta(i+1));
    end
    
    CG=(N-CG)/N;

end

