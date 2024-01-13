
Cl_initial = load('Cl_values_initial_design.dat');
Cl_optimised = load('Cl_values_optimised_design.dat');

disp(width(Cl_initial));

old_span = 21.6;
new_span = 24.4192;

old_span_list = linspace(0,old_span,14);
new_span_list = linspace(0,new_span,14);

% Plot the first airfoil with red crosses
figure;
plot(old_span_list, Cl_initial, 'r-', 'DisplayName', 'Initial Cl design');
hold on;

% Plot the second airfoil with a blue continuous line
plot(new_span_list, Cl_optimised, 'b-', 'DisplayName', 'Optimised Cl design');

% Set plot limits
%axis([0, 1, -1.5, 1.5]);

% Add legend
legend('Location', 'Best');
xlabel('Wing span [m]');
ylabel('C Cl [m]');
title('Design Cl Comparison');
grid on;

%Cd design


Cd_initial = load('Cd_values_initial_design.dat');
Cd_optimised = load('Cd_values_optimised_design.dat');

disp(width(Cd_initial));

old_span = 21.6;
new_span = 24.4192;

old_span_list = linspace(0,old_span,14);
new_span_list = linspace(0,new_span,14);

% Plot the first airfoil with red crosses
figure;
plot(old_span_list, Cd_initial, 'r-', 'DisplayName', 'Initial Cl design');
hold on;

% Plot the second airfoil with a blue continuous line
plot(new_span_list, Cd_initial, 'b-', 'DisplayName', 'Optimised Cl design');

% Set plot limits
%axis([0, 1, -1.5, 1.5]);

% Add legend
legend('Location', 'Best');
xlabel('Wing span [m]');
ylabel('C Cd [m]');
title('Design Cd Comparison');
grid on;


%critical Cl


Cl_initial = load('Cl_values_initial_critical.dat');
Cl_optimised = load('Cl_values_optimised_critical.dat');

disp(width(Cl_initial));

old_span = 21.6;
new_span = 24.4192;

old_span_list = linspace(0,old_span,14);
new_span_list = linspace(0,new_span,14);

% Plot the first airfoil with red crosses
figure;
plot(old_span_list, Cl_initial, 'r-', 'DisplayName', 'Initial Cl critical');
hold on;

% Plot the second airfoil with a blue continuous line
plot(new_span_list, Cl_optimised, 'b-', 'DisplayName', 'Optimised Cl critical');

% Set plot limits
%axis([0, 1, -1.5, 1.5]);

% Add legend
legend('Location', 'Best');
xlabel('Wing span [m]');
ylabel('C Cl [m]');
title('critical Cl Comparison');
grid on;