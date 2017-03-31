clear,clc
global N;%total bandwidth
global maxPheromone;
global minPheromone;
global lamda;%get_arrivalTime
global MU;%get_survivalTime
global min_node_resource;%get_V_sub
global max_node_resource;%get_V_sub
global min_vertex;%gererate_Gv_vertex
global max_vertex;%gererate_Gv_vertex
global min_vertexResource;%gererate_Gv_vertex
global max_vertexResource;%gererate_Gv_vertex
global min_bandwidth;%gererate_Gv_link
global max_bandwidth;%gererate_Gv_link
global Csmax;%maximum computing source on a node
N=150;
maxPheromone=1.5;
minPheromone=0.5;
lamda=0;
MU=35;%get_survivalTime
min_node_resource=300;%get_V_sub
max_node_resource=400;%get_V_sub
min_vertex=2;%gererate_Gv_vertex
max_vertex=5;%gererate_Gv_vertex
min_vertexResource=1;%gererate_Gv_vertex
max_vertexResource=3;%gererate_Gv_vertex
min_bandwidth=1;%gererate_Gv_link
max_bandwidth=5;%gererate_Gv_link
Csmax=get_V_sub(14);%maximum computing source on a node
%全局变量的声明与赋值

timeUnit=100;
countAll=0;%record requirement number
countSuccess=0;%record success number
V_sub=Csmax;%record current computing resource of node on substract
E_sub=get_E_sub(14,21);%record link state from node i to node j on substract
E_sub_slot=ones(14,14,N);
V_v=[];%record resource require on node on virtual networking
E_v=[];%record link band require from node i to node j on virtual networking
vessel_node=[];%record computing resource occupied by a virtual networking on substract networking
vessel_slot=[];%record slot resource occupied by a virtual networking on substract networking
vessel_survivalTime=[];%record the survival time of a virtual networking
vessel_virtualEdge=[];%record the bandwidth requirement of a virtual networking
success=0;
success_rate=[];
node_balance=[];
link_balance=[];
BSRate=[];
mean_BSRate=[];
OFSR=[];

countSuccess2=0;%record success number
V_sub2=Csmax;%record computing resource of node on substract
E_sub2=E_sub;%record link state from node i to node j on substract
E_sub_slot2=E_sub_slot;
vessel_node2=[];%record computing resource occupied by a virtual networking on substract networking
vessel_slot2=[];%record slot resource occupied by a virtual networking on substract networking
vessel_survivalTime2=[];%record the survival time of a virtual networking
vessel_virtualEdge2=[];%record the bandwidth requirement of a virtual networking
success2=0;
success_rate2=[];
node_balance2=[];
link_balance2=[];
BSRate2=[];
mean_BSRate2=[];
OFSR2=[];

countSuccess3=0;%record success number
V_sub3=Csmax;%record computing resource of node on substract
E_sub3=E_sub;%record link state from node i to node j on substract
E_sub_slot3=E_sub_slot;
vessel_node3=[];%record computing resource occupied by a virtual networking on substract networking
vessel_slot3=[];%record slot resource occupied by a virtual networking on substract networking
vessel_survivalTime3=[];%record the survival time of a virtual networking
vessel_virtualEdge3=[];%record the bandwidth requirement of a virtual networking
success3=0;
success_rate3=[];
node_balance3=[];
link_balance3=[];
BSRate3=[];
mean_BSRate3=[];
OFSR3=[];

countSuccess4=0;%record success number
V_sub4=Csmax;%record computing resource of node on substract
E_sub4=E_sub;%record link state from node i to node j on substract
E_sub_slot4=E_sub_slot;
vessel_node4=[];%record computing resource occupied by a virtual networking on substract networking
vessel_slot4=[];%record slot resource occupied by a virtual networking on substract networking
vessel_survivalTime4=[];%record the survival time of a virtual networking
vessel_virtualEdge4=[];%record the bandwidth requirement of a virtual networking
success4=0;
success_rate4=[];
node_balance4=[];
link_balance4=[];
BSRate4=[];
mean_BSRate4=[];
OFSR4=[];

for k=1:5
    
    lamda=lamda+5;
    
    for i=1:timeUnit

        %return the resource after usage
        seqNum=find(vessel_survivalTime==0);
        for j=1:size(seqNum,2)
            %%%%%%V_sub=V_sub+cell2mat(vessel_node(seqNum(j)));
            V_sub=V_sub+vessel_node(seqNum(j));
            E_sub_slot=E_sub_slot+cell2mat(vessel_slot(seqNum(j)));
            vessel_node(seqNum(j),:)=[];
            vessel_slot(seqNum(j))=[];
            vessel_virtualEdge(seqNum(j))=[];
            BSRate(seqNum(j))=[];

            vessel_survivalTime(seqNum(j))=[];
            seqNum=seqNum-1;
        end  

        seqNum=find(vessel_survivalTime2==0);
        for j=1:size(seqNum,2)
            V_sub2=V_sub2+vessel_node2(seqNum(j));
            E_sub_slot2=E_sub_slot2+cell2mat(vessel_slot2(seqNum(j)));
            vessel_node2(seqNum(j),:)=[];
            vessel_slot2(seqNum(j))=[];
            BSRate2(seqNum(j))=[];

            vessel_survivalTime2(seqNum(j))=[];
            seqNum=seqNum-1;
        end

        seqNum=find(vessel_survivalTime3==0);
        for j=1:size(seqNum,2)
            V_sub3=V_sub3+vessel_node3(seqNum(j));
            E_sub_slot3=E_sub_slot3+cell2mat(vessel_slot3(seqNum(j)));
            vessel_node3(seqNum(j),:)=[];
            vessel_slot3(seqNum(j))=[];
            BSRate3(seqNum(j))=[];

            vessel_survivalTime3(seqNum(j))=[];
            seqNum=seqNum-1;
        end
        
        seqNum=find(vessel_survivalTime4==0);
        for j=1:size(seqNum,2)
            V_sub4=V_sub4+vessel_node4(seqNum(j));
            E_sub_slot4=E_sub_slot4+cell2mat(vessel_slot4(seqNum(j)));
            vessel_node4(seqNum(j),:)=[];
            vessel_slot4(seqNum(j))=[];
            BSRate4(seqNum(j))=[];

            vessel_survivalTime4(seqNum(j))=[];
            seqNum=seqNum-1;
        end

        reqNum=poissrnd(lamda,1,1);%require number in a unit time
        for j=1:reqNum
            V_v=gererate_Gv_vertex();
            E_v=gererate_Gv_link(size(V_v,2));
            countAll=countAll+1;
    %         success=0;
    %         success2=0;
    %         success3=0;

            %%%% result_node : store the occupied  computing resource of a virtual networking on substract networking   
            %%%% result_link_slot : store the occupied  slot resource of a virtual networking on substract networking  
            [ success , result_node , result_link_slot , V_sub , E_sub_slot ] = antAlgrithum(V_v,E_v,V_sub,E_sub,E_sub_slot);
            [ success2 , result_node2 , result_link_slot2 , V_sub2 , E_sub_slot2 ] = greedyAlgrithum(V_v,E_v,V_sub2,E_sub2,E_sub_slot2);
            [ success3 , result_node3 , result_link_slot3 , V_sub3 , E_sub_slot3 ] = RC_SP_FF( V_v,E_v,V_sub3,E_sub3,E_sub_slot3 );
            [ success4 , result_node4 , result_link_slot4 , V_sub4 , E_sub_slot4 ] = ACT_VNE( V_v,E_v,V_sub4,E_sub4,E_sub_slot4 );

            survivalTime=get_survivalTime();%for accordance
            if success==1
                %%%vessel_node=[vessel_node;{result_node}];
                vessel_node=[vessel_node;result_node];
                vessel_slot=[vessel_slot,{result_link_slot}];
                vessel_virtualEdge=[vessel_virtualEdge,{E_v}];
                BSRate=[BSRate,get_BSRate( E_v , result_link_slot )];
                vessel_survivalTime=[vessel_survivalTime,survivalTime];
                if(size(vessel_node,1)~=0)
                    countSuccess=countSuccess+1;
                end
            end
            if success2==1
                vessel_node2=[vessel_node2;result_node2];
                vessel_slot2=[vessel_slot2,{result_link_slot2}];
                vessel_virtualEdge2=[vessel_virtualEdge2,{E_v}];
                BSRate2=[BSRate2,get_BSRate( E_v , result_link_slot2 )];
                vessel_survivalTime2=[vessel_survivalTime2,survivalTime];
                countSuccess2=countSuccess2+1;
            end

            if success3==1
                vessel_node3=[vessel_node3;result_node3];
                vessel_slot3=[vessel_slot3,{result_link_slot3}];
                vessel_virtualEdge3=[vessel_virtualEdge3,{E_v}];
                BSRate3=[BSRate3,get_BSRate( E_v , result_link_slot3 )];
                vessel_survivalTime3=[vessel_survivalTime3,survivalTime];
                countSuccess3=countSuccess3+1;
            end
            
            if success4==1
                vessel_node4=[vessel_node4;result_node4];
                vessel_slot4=[vessel_slot4,{result_link_slot4}];
                vessel_virtualEdge4=[vessel_virtualEdge4,{E_v}];
                BSRate4=[BSRate4,get_BSRate( E_v , result_link_slot4 )];
                vessel_survivalTime4=[vessel_survivalTime4,survivalTime];
                countSuccess4=countSuccess4+1;
            end
        end

        %count unit time
        vessel_survivalTime=vessel_survivalTime-1;
        vessel_survivalTime2=vessel_survivalTime2-1;
        vessel_survivalTime3=vessel_survivalTime3-1;
        vessel_survivalTime4=vessel_survivalTime4-1;
    end
%show graph    
%    if(i==1000||i==2000||i==3000||i==4000||i==5000||i==6000||i==7000||i==8000||i==9000||i==10000)
        success_rate=[success_rate,countSuccess/countAll];     
        node_balance=[node_balance,get_node_balance(V_sub)];
        link_balance=[link_balance,get_link_balance(E_sub,E_sub_slot)];
        %BSRate=[BSRate,get_BSRate( E_v , result_link_slot )]; 
        mean_BSRate=[mean_BSRate,sum(BSRate)/size(BSRate,2)];
       % OFSR=[OFSR,sum(BSRate)/(N*sum(sum(E_sub)))];
        OFSR=[OFSR,sum(BSRate)];

        success_rate2=[success_rate2,countSuccess2/countAll];     
        node_balance2=[node_balance2,get_node_balance(V_sub2)];
        link_balance2=[link_balance2,get_link_balance(E_sub2,E_sub_slot2)];
        mean_BSRate2=[mean_BSRate2,sum(BSRate2)/size(BSRate2,2)];
        %OFSR2=[OFSR2,sum(BSRate2)/(N*sum(sum(E_sub2)))];
        OFSR2=[OFSR2,sum(BSRate2)];

        success_rate3=[success_rate3,countSuccess3/countAll];     
        node_balance3=[node_balance3,get_node_balance(V_sub3)];
        link_balance3=[link_balance3,get_link_balance(E_sub3,E_sub_slot3)];
        mean_BSRate3=[mean_BSRate3,sum(BSRate3)/size(BSRate3,2)];
        %OFSR3=[OFSR3,sum(BSRate3)/(N*sum(sum(E_sub3)))];
        OFSR3=[OFSR3,sum(BSRate3)];
        
        success_rate4=[success_rate4,countSuccess4/countAll];     
        node_balance4=[node_balance4,get_node_balance(V_sub4)];
        link_balance4=[link_balance4,get_link_balance(E_sub4,E_sub_slot4)];
        mean_BSRate4=[mean_BSRate4,sum(BSRate4)/size(BSRate4,2)];
        %OFSR4=[OFSR4,sum(BSRate4)/(N*sum(sum(E_sub4)))];
        OFSR4=[OFSR4,sum(BSRate4)];
  %  end
    
end

%%%%%%%%%%%%% show result %%%%%%%%%%%
x=[5:5:25];

figure(1);
plot(x,ones(1,length(success_rate2))-success_rate2,'ks-')
hold on
plot(x,ones(1,length(success_rate3))-success_rate3,'k-^')
plot(x,ones(1,length(success_rate4))-success_rate4,'k-*')
plot(x,ones(1,length(success_rate))-success_rate,'k-o')
hold off
axis([5 25 0.3 0.85])
%grid minor
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'},'Location','SouthEast');
% ylabel('Blocking Probability');
% xlabel('Traffic Load');
ylabel('阻塞率');
xlabel('虚拟网络平均到达速率');

figure(2);
plot(x,node_balance2,'ks-')
hold on
plot(x,node_balance3,'k-^')
plot(x,node_balance4,'k-*')
plot(x,node_balance,'k-o')
hold off
% axis([0 30 0 1])
grid minor
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'},'Location','East');
ylabel('Node Balance');
xlabel('Traffic Load');

figure(3);
plot(x,link_balance2,'ks-')
hold on
plot(x,link_balance3,'k-^')
plot(x,link_balance4,'k-*')
plot(x,link_balance,'k-o')
hold off
axis([5 25 0.18 0.35])
%grid minor
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'});
% ylabel('Link Load Balance');
% xlabel('Traffic Load');
ylabel('链路负载平衡');
xlabel('虚拟网络平均到达速率');

figure(4);
plot(x,OFSR2,'ks-')
hold on
plot(x,OFSR3,'k-^')
plot(x,OFSR4,'k-*')
plot(x,OFSR,'k-o')
hold off
% axis([0 30 0 1])
grid minor
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'},'Location','East');%continous contiguity and node adaptive algorithm
ylabel('Occupied Frequency Slot');
xlabel('Traffic Load');

figure(5);
plot(x,mean_BSRate2,'ks-')
hold on
plot(x,mean_BSRate3,'k-^')
plot(x,mean_BSRate4,'k-*')
plot(x,mean_BSRate,'k-o')
hold off
% axis([0 30 0 1])
grid minor
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'},'Location','East');%continous contiguity and node adaptive algorithm
ylabel('Occupied Frequency Slot Ratio');
xlabel('Traffic Load');

% y=[mean_BSRate2',mean_BSRate3',mean_BSRate4',mean_BSRate'];
% b=bar(y);
% legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'});
% grid minor
% %ch = get(b,'children');
% set(gca,'XTickLabel',{'5','10','15','20','25'})
% %set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
% applyhatch(b,'\.x.');
% xlabel('Occupied Frequency Slot Ratio ');
% ylabel('Traffic Load');

figure(6);
y=[mean_BSRate2',mean_BSRate3',mean_BSRate4',mean_BSRate'];
bar(y,1);
% ylabel('Occupied Frequency Slot Ratio ');
% xlabel('Traffic Load');
ylabel('虚拟网络占用的物理链路资源与与其需求资源的比率');
xlabel('虚拟网络平均到达速率');
%axis([0 6 0.0 100]);
legend({'Greedy-SP-FF','RC-SP-FF','ACT-VNE','CCN-ACO'});
set(gca,'XTickLabel',{'5','10','15','20','25'});
set(gcf,'color','white')
applyhatch(gcf,'+\.|x/-');
% % add=zeros(100,100);
% % for i=1:100
% %     for j=1:100
% %         add(i,j)=sum(E_sub_slot(i,j,:));
% %     end
% % end

% for i=1:length(BSRate)
%    if(BSRate(i)==0)
%        BSRate(i)=[];
%        i=i-1;
%    end
% end
% x=sum(BSRate)/length(BSRate);