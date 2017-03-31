function node_balance = get_node_balance(V_sub)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
global Csmax;

node_balance=std((Csmax-V_sub)./Csmax);

end

