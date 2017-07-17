clear
close all

raw = load('series.txt');
raw = raw(:,2);

a = 1:1024;
b = a/512;


h = figure;

yyaxis right
plot(b,raw,'k','LineWidth',4)
ylim([min(raw) max(raw)])
ylabel('U(\muV)')

C = linspecer(20);
yyaxis left
hold on
for k = 1:20
    
    [sigma] = sigmoidTrans(raw,0.1*k);
    plot(b,sigma,'color',C(k,:),'marker','none','linestyle','-','LineWidth',4)
    

end
hold off

left_color = [0 0 0];
right_color = [0 0 0];
set(h,'defaultAxesColorOrder',[left_color; right_color]);

xlim([min(b) max(b)])
ylabel({'U*'})
xlabel('Time (s)')
ylim([min(sigma) max(sigma)])
xlim([min(b) max(b)])

set(gca,'FontSize',18,'FontName','Times')

legend('v = 0.1','v = 0.2','v = 0.3','v = 0.4','v = 0.5','v = 0.6',...
    'v = 0.7','v = 0.8','v = 0.9','v = 1.0','v = 1.1','v = 1.2','v = 1.3',...
    'v = 1.4','v = 1.5','v = 1.6','v = 1.7','v = 1.8','v = 1.9','v = 2.0',...
    'Raw','location','bestoutside');

set(gca,'FontSize',18,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters sig_trans_comp.eps
print -dpng sig_trans_comp.png
