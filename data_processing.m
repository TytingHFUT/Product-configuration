function new_data = data_processing(data)
%将模块对需求的效用值 除以其中的最大值。
[types,indexs] = get_instances_num(data);
for i = 1:5
    temp = max(data.execution_level((indexs(i)-types(i)+1):indexs(i)));
    temp1 =data.execution_level((indexs(i)-types(i)+1):indexs(i))./temp;
    data.execution_level((indexs(i)-types(i)+1):indexs(i))=temp1;   
end
new_data =data;
end
% for i = 1:n_data
%
%     temp =[data.safety(i),data.disassembly(i),data.charging_efficiency(i),data.reliability(i),...
%         data.Operating_convenience(i)];
%     max_temp = max(temp);
%     temp = temp./max_temp;
%     %% 分别赋值
%     data.safety(i)=temp(1);
%     data.disassembly(i)=temp(2);
%     data.charging_efficiency(i)=temp(3);
%     data.reliability(i)=temp(4);
%     data.Operating_convenience(i) = temp(5);
%
% end
