function pop = performance_price(pop,data)

npop =size(pop,1); %获取种群个数
Da=readtable("CRs.xlsx"); % KC 的含义：1. must-be(SM); 2.  attractive attributes
%(𝑆𝐴)  3.one-dimensional attributes(𝑆𝑂)
[types,indexs] = get_instances_num(data);
%% 遍历数据，计算性能—价格 函数值
rows = size(pop(1).position,1);
for k = 1:npop
    position=pop(k).position;
    total = 0;
    for i =1: rows
        index=find(position(i,max(types)+1-types(i):max(types))~=0)+indexs(i)-types(i); %在data中的位置。
       index_inner = find(position(i,:)~=0);
        for j = 1:size(index,2)
            temp =[data.safety(index(j)),data.disassembly(index(j)),data.charging_efficiency(index(j)),...
                data.reliability(index(j)), data.Operating_convenience(index(j))];
            x =sum(temp.*data.execution_level(index(j)));
            performance=Kano_(x,Da);
            KK =data.cost(index(j))*position(i,index_inner(j))*((5- performance)/5);
        end
        total =total+KK;
    end
    pop(k).performance_price= total;

end


end