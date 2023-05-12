function plotcosts2_1(pop)

    costs = [pop.performance_price;pop.warranty_profit];
    
    scatter([costs(1, :)], [-costs(2, :)],15,"black");
       set(gca,'fontname','times','FontSize',15)
    xlabel('Performance-price');
    ylabel('Warranty profit');
   % zlabel('emission');
    box on

    %title('Pareto解集');
    grid on;

end