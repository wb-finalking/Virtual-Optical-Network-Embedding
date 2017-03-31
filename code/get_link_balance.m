function link_balance = get_link_balance(E_sub,E_sub_slot)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
global N;

[ln,col,value]=find(tril(E_sub));
rate=[];

for i=1:size(ln,1)
    rate=[rate,(N-sum(E_sub_slot(ln(i),col(i),:)))/N];
end

link_balance=std(rate);

end

