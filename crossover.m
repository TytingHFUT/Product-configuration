function [y1, y2] = crossover(x1, x2,data)
%x1 =p1.position;
%x2 =p2.position;
 y1=x1;
 y2=x2;
[rows , columns] = size(x1);
%y1 =zeros(rows,columns);
%y2=y1;
types = get_instances_num(data);
for i = 1:rows
   
    r = randi([1,  types(i)- 1], 1);
     index = columns+1-randperm(r, r);
     y1(i,columns+1-r:columns)=x1(i,index);
     y2(i,columns+1-r:columns)=x2(i,index);
   
end

end