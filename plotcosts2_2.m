function plotcosts2_2(pop)

    costs = [pop.warranty_profit;pop.emission];
    
    scatter([-costs(1, :)], [costs(2, :)],15,"black");
       set(gca,'fontname','times','FontSize',15)
    xlabel('Warranty profit');
    ylabel('Environmental emissions');
   % zlabel('emission');
    box on

    %title('Pareto解集');
    grid on;

end