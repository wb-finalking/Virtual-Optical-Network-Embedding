function E_sub = get_E_sub( nodeNumber , LinkNumber)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    E_sub=zeros(nodeNumber,nodeNumber);
    for i=1:nodeNumber-1
        for j=i+1:nodeNumber
            E_sub(i,j)=floor(rand()+LinkNumber/(nodeNumber*(nodeNumber-1)/2));
        end
    end
    E_sub=E_sub+E_sub';

    for i=1:nodeNumber
       if(sum(E_sub(i,:))<2)
          seq=find(E_sub(i,:)==0);
          seqNum=ceil(rand()*size(seq,2));
          E_sub(i,seq(seqNum))=1;
          E_sub=E_sub+E_sub';
          E_sub=ceil(E_sub/2);
       end
    end
end

