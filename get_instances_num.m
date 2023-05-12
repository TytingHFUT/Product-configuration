function [types,indexs] = get_instances_num(data)
%% 根据data第一列 ，分析模块实例类型，及每个类型实例属于那个模块,表格 数据处理。
type = max(data.type); %模块个数
types = zeros(1,type); %存放分类结果
lines = size(data.type,1);
for j = 1:type
    index = find(data.type==j) ;

    while isnan(data.type(index+1))
        index =index+1;
        if index == lines
            break
        end
    end
    types(j)=index;
    if  j ==type
        types(j)=lines;
    end
end

temp =[0,types];
indexs=types;
for i  = 1: type
    types(i) = temp(i+1)-temp(i);
end
end