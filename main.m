
%% 参数设置
clear
npop =  100;%种群 规模
pc = 0.8; %交叉率
nc = round(pc * npop / 2) * 2;
mu = 0.9;%变异率
maxit = 1000; %迭代次数
component_selection = 0.75; %可选模块的选择概率
configurations = [1,1,3,1,1];%1：常规；2：可选；3：可冗余。
redundant_num=4; %冗余模块的个数
lambda = 0.69;  %其中λ∈（0，1）是模型参数，较大的λ值反映了较小的失真。
% 假设产品故障概率的失真可以计算δ(ri) = exp(−(− log(r_i ))^λ )
C_m = 800;        %C_𝑚 为公司在客户选择第 𝑚 项保修策略时的预期成本。
C_r =    200;               %C_r 为公司需要承担的最低维修成本
p_m = [600,1100,1600,2100];     % 保修保费。
w_m =[1,2,3,4];             %保修时长 。
w_b = 1;            %免费保修1年。
wp_mu = 600 ;        %The scale parameter of MNL,MNL的比例参数\ multinomial logit (MNL) ,多项式logit（MNL）
%% 读取数据
data =readtable("data.xlsx");
data = data_processing(data);

%% 结果存放
%% 定义结果存放模板
empty.position = [];
empty.performance_price = [];
empty.warranty_profit = [];
empty.emission=[];
empty.rank = [];
empty.domination = [];
empty.dominated = 0;
empty.crowdingdistance = [];
pop = repmat(empty, npop, 1);
%% 生成种群
for i=1:npop
    pop(i).position = creat_code(data,configurations,component_selection,redundant_num);
end
%% 计算 "performance_price"目标函数
pop=performance_price(pop,data);

%% 计算"warranty_profit"目标函数
pop=warranty_profit(pop,data,lambda,C_m,C_r,w_b,w_m, p_m,wp_mu);

%% 计算环境排放
pop=emission(pop,data);
%% 非支配排序
[pop,F] = nondominatedsort(pop);
%% 拥挤度计算
pop = calcrowdingdistance(pop,F);
%% 主程序
for it = 1 : maxit
    popc = repmat(empty, nc/2,2);
    % 交叉
    for j = 1 : nc / 2
        p1 = tournamentsel(pop);
        p2 = tournamentsel(pop);
        [popc(j, 1).position, popc(j, 2).position] = crossover(p1.position, p2.position,data);
    end
    popc = popc(:);
    %变异
    for k = 1 : nc
        if rand(1)<=mu
            popc(k).position = mutate(data,configurations,component_selection,redundant_num,mu);
        end
    end
    popc=performance_price(popc,data);
    popc=warranty_profit(popc,data,lambda,C_m,C_r,w_b,w_m, p_m,wp_mu);
    popc=emission(popc,data);


    newpop = [pop; popc];

    [pop,F] = nondominatedsort(newpop);

    pop = calcrowdingdistance(pop,F);

    % 排序
    pop = Sortpop(pop);

    % 淘汰
    pop = pop(1: npop);

    [pop,F] = nondominatedsort(pop);

    pop = calcrowdingdistance(pop,F);

    pop = Sortpop(pop);

    % 更新第1等级
    F1 = pop(F{1});

    % 显示迭代信息
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);

    % 绘图
    figure(1);
    
    plotcosts(F1); %三维
    %%pause(0.01);
    figure(2);
    
    plotcosts2_1(F1);%二维pop.performance_price;pop.warranty_profit
    % pause(0.01);
    figure(3);

    plotcosts2_2(F1);%pop.warranty_profit;pop.emission
    %pause(0.01);
    figure(4);
    
    plotcosts2_3(F1);%pop.performance_price;pop.emission
end
% 
% n = numel(F1);
% result =F1(1).position;
% No=[];
% for i =2:n
% result1 = F1(i).position;
% 
% m =size(result,1);
% if  ~isequal(result1, result((m-4):m,:))
% result=[result;result1];
% No=[No;i];
% end
% end

%%
%lambda = 0.69;
new_pop = repmat(empty, npop, 1);
%indes =[7,26,46,24,70,86,84];
for i =1:npop
new_pop(i).position=F1(i).position;
end

%% 计算 "performance_price"目标函数
new_pop=performance_price(new_pop,data);

%% 计算"warranty_profit"目标函数
new_pop=warranty_profit(new_pop,data,lambda,C_m,C_r,w_b,w_m, p_m,wp_mu);

%% 计算环境排放
new_pop=emission(new_pop,data);
%% 非支配排序
AA =zeros(npop,15);
for j= 1:npop
AA(j,1)=new_pop(j).warranty_profit;
end
j=1;
for wp_mu =100:50:800
    j=j+1;
    new_pop=warranty_profit(new_pop,data,lambda,C_m,C_r,w_b,w_m, p_m,wp_mu);
    for i =1:npop
       
            AA(i,j)=new_pop(i).warranty_profit;
        
    end  
end
AA = -AA;


