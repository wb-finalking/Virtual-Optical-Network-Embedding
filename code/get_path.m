function  finalPath = get_path(path , bandwidth_v , t1 , t2 , V_v , E_v , V_sub , E_sub , E_sub_slot)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

    E_sub_backup=E_sub;
    success=0;
    
    vessel_path=[];
    vessel_RCL=[];
    
    vessel_path=[vessel_path,{path}];
    vessel_RCL=[vessel_RCL,get_RCL( path , bandwidth_v , t1 , t2 , E_v , E_sub , E_sub_slot )];
    
    for i=1:length(path)-1
        E_sub=E_sub_backup;
        E_sub(path(i),path(i+1))=0;
        E_sub(path(i+1),path(i))=0;
        
        [dist,pathBuffer,pred] = graphshortestpath(sparse(E_sub),t1,t2,'directed',false)
        if(length(pathBuffer)~=0)
            vessel_path=[vessel_path,{pathBuffer}];
            vessel_RCL=[vessel_RCL,get_RCL( pathBuffer ,bandwidth_v , t1 , t2 , E_v , E_sub , E_sub_slot )];
        end
    end
    
    [ minRCL ,num ]=min(vessel_RCL);
    finalPath=cell2mat(vessel_path(num));


end

