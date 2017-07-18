clear
close all

%% PARAMETERS

s = -5:0.1:5;
sigma = [];
C = linspecer(20);

%% PLOTTING A FAMILY OF SIGMOID FUNCTIONS

for k = 1:20
    
    v = 0.1*k;
    x = s;
    sigma(:,k) = 1./(1 + exp(-v*x));
    plot(s,sigma(:,k),'color',C(k,:),'LineWidth',4);
    hold on
    
end

hold off

legend('v = 0.1','v = 0.2','v = 0.3','v = 0.4','v = 0.5','v = 0.6',...
    'v = 0.7','v = 0.8','v = 0.9','v = 1.0','v = 1.1','v = 1.2','v = 1.3',...
    'v = 1.4','v = 1.5','v = 1.6','v = 1.7','v = 1.8','v = 1.9','v = 2.0',...
    'location','bestoutside');

title('Family of sigmoid curves')
xlabel('x')
ylabel('\sigma(x)')

set(gca,'FontSize',18,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters sigmoids.eps
print -dpng sigmoids.png