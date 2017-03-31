function nodeIndex = get_nodeIndex( V_sub , E_sub , E_sub_slot )
global Csmax;
global N;

nodeIndex=zeros(1,size(V_sub,2));
for i=1:size(V_sub,2)
   L=0;
   vector = find(E_sub(i,:)==1);
   CG=0;
   CN=0;
   for j=1:size(vector,2)-1
       for k=j+1:size(vector,2)
           CG=CG+getCG(i,vector(j),vector(k),E_sub_slot);
           CN=CN+getCN(i,vector(j),vector(k),E_sub_slot);
       end
   end
   for j=1:size(vector,2)
       L=L+getL(i,vector(j),E_sub,E_sub_slot);
   end
   nodeIndex(i)=(V_sub(i)/Csmax(i))*(CG/(size(vector,2)*(size(vector,2)+1)/2))*(CN/(size(vector,2)*(size(vector,2)+1)/2))*(1/(L/size(vector,2)+1));
end

end

