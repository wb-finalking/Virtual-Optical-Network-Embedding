function  CA=get_CA( E_v , V_sub , E_sub , E_sub_slot )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    
    a=get_a(V_sub , E_sub , E_sub_slot);
    q=get_q( E_v , V_sub , E_sub , E_sub_slot );

    CA=V_sub.*a.*q;

end

