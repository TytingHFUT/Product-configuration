function new_pop=warranty_profit(pop,data,lambda,C_m,C_r,w_b,w_m, p_m,wp_mu)

npop =size(pop,1);
[types,indexs] = get_instances_num(data);
[row , column] = size(pop(1).position);
for i = 1:npop
    temp = pop(i).position;
    kk=[];
    for j =1:row
        index=find(temp(j,column+1-types(j):column)~=0)+indexs(j)-types(j); %在data中的位置。
   
        for k =1:size(index,2)
            delta_rm = exp(-(-log(data.rm(index(k))))^lambda ) ;
            v_wm = C_m*delta_rm;
            AA = exp((v_wm-p_m)/wp_mu);
            Q_m=AA/(1+sum(AA));
            c_wm =C_r*(((w_b+w_m)/data.alpha(index(k))).^data.beta(index(k))-...
                            (w_b/data.alpha(index(k)))^data.beta(index(k)));
            warranty_pro = (p_m-c_wm).*Q_m;
           
        end
        kk=[kk,sum(warranty_pro)];
    end
    pop(i).warranty_profit = -min(kk);
end
new_pop =pop;
end