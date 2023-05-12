function new_pop=emission(pop,data)
npop = size(pop,1);
[types,indexs] = get_instances_num(data);
[row , column] = size(pop(1).position);
for i =1:npop
    temp =pop(i).position;
    total = 0;
    for j=1:row
        index=find(temp(j,column+1-types(j):column)~=0)+indexs(j)-types(j); %在data中的位置。
        index_inner = find(temp(j,:)~=0);
        for k =1:size(index,2)
          total =total+  (data.e1(index(k))+data.e2(index(k)))* temp(j, index_inner(k));
        end
    end
    pop(i).emission = total;
end
new_pop=pop;
end