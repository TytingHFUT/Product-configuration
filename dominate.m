function z = dominate(p, q)

c1 = [p.performance_price,p.warranty_profit,p.emission];
c2 =[q.performance_price,q.warranty_profit,q.emission];

z = all(c1 <= c2) && any(c1 < c2);


end