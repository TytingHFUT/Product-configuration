function plotcosts(pop)

    costs = [pop.performance_price;pop.warranty_profit;pop.emission];
    
    scatter3([costs(1, :)], [-costs(2, :)], [costs(3, :)],15,"black");
    set(gca,'fontname','times','FontSize',15)
    xlabel('Performance-price');
    ylabel('Warranty profit');
    zlabel('Environmental emissions');
    box on

    %title('Pareto解集');
    grid on;

end