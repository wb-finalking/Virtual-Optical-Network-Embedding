function BSRate = get_BSRate( E_v , result_link_slot )

if sum(sum(E_v))~=0
    BSRate=sum(sum(sum(result_link_slot)))/sum(sum(E_v));
else
    BSRate=0;
end

%     if sum(sum(E_v))~=0
%         BSRate=sum(sum(sum(result_link_slot)));
%     else
%         BSRate=0;
%     end

end

