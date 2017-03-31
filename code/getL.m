function  L = getL( ts , td , E_sub , E_sub_slot )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
global N;
L=(N-sum(E_sub_slot(ts,td,:)))/N;

end

