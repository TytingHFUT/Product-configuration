function [code] = creat_code(data,configurations,component_selection,redundant_num)
%创建编码
%%  由配置类型"configurations"生成二进制代码
types = get_instances_num(data);
type = max(data.type); %模块个数
A=zeros(type,max(types));
for i = 1:type
    if configurations(i) == 1   %常规
        A(i,(9-randi(types(i)))) = 1;
    elseif configurations(i)==2 %可选
        if rand(1)>=component_selection
            A(i,(max(types)+1-randi(types(i)))) = 1;
        end
    else
        while sum(A(i,:))<=redundant_num
            BB=max(types)+1-randperm(types(i),randi(types(i)));
            CCC =randi(size(BB,2));
            DDD = randi(redundant_num);
            A(i,BB(CCC))=DDD;

            if sum(A(i,:))>redundant_num
                A(i,BB(CCC))=0;
                A(i,BB(CCC))=redundant_num-sum(A(i,:));
                break
            end

            %A(i,max(types)+1-randperm(types(i),randi(types(i)))) = 1;

        end
    end
end
code = A;
end