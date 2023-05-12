function plotcosts2_3(pop)

    costs = [pop.performance_price;pop.emission];
    
    scatter([costs(1, :)], [costs(2, :)],15,"black");
       set(gca,'fontname','times','FontSize',15)
    xlabel('Performance-price');
    ylabel('Environmental emissions');
   % zlabel('emission');
    box on

    %title('Pareto解集');
    grid on;

end