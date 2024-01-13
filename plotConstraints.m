function stop = plotConstraints(x, optimValues, state)
    persistent iters cvals ceqvals % Retain these values throughout the optimization
    stop = false;

    switch state
        case "init"
            iters = [];
            cvals = [];
            ceqvals = [];
        case "iter"
            % Call your constraints function
            [c, ceq] = constraints_IDF_coup(x);

            iters = [iters optimValues.iteration];
            cvals = [cvals; c];
            ceqvals = [ceqvals; ceq];

            figure;

            % Plotting Inequality Constraints
            subplot(2, 1, 1);
            plot(iters, cvals, '-o');
            title('Inequality Constraints');
            xlabel('Iteration');
            ylabel('Constraint Value');
            legend('Buffet', 'Tank Volume', 'Wing Loading');
            grid on;

            % Plotting Consistency Constraints
            subplot(2, 1, 2);
            plot(iters, ceqvals, '-o');
            title('Consistency Constraints');
            xlabel('Iteration');
            ylabel('Constraint Value');
            legend('L/D', 'W_{structural}', 'W_{fuel}');
            grid on;

            drawnow; % Ensure the figure is updated during optimization
        case "done"
    end
end