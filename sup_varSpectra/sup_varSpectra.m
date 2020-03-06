clear
close all

raw = load('series.txt');
electr = raw(:,2);

segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9;
stdScale = 0.5:0.1:1.5;

alpha = zeros(qf-qi+1,length(stdScale));
falpha = zeros(qf-qi+1,length(stdScale));


colours = [1,58,186;
           65,181,198;
           255,98,206;
           0,159,237;
           190,45,107;
           0,123,218;
           231,146,172;
           0,59,162;
           196,192,254;
           125,0,106;
           0,37,92;
           184,82,217]/255;

for k = 1:length(stdScale)

x = (electr - mean(electr))/(stdScale(k)*std(electr));
sigma = 1./(1 + exp(-x));

[alpha(:,k),falpha(:,k),~,~,~,~,~,~,~,~]=...
    ChhabraJensen_Yuj_w0(sigma,qi:dq:qf,Io:Np);

end

figure
set(0,'DefaultTextInterpreter', 'latex')
hold on
for i = 1:length(stdScale)
plot(alpha(:,i),falpha(:,i),'Color',colours(i,:), 'LineWidth', 2)
end

for i = 1:length(stdScale)
scatter(alpha(18,i),falpha(18,i), 300, 'MarkerEdgeColor', colours(i,:))
end
hold off
box on
ylim([0.1 1.1])
xlabel('$\alpha^{\dagger}$')
ylabel('$f (\alpha)^{\dagger}$')
legend('0.5','0.6','0.7','0.8','0.9','1.0','1.1','1.2','1.3','1.4','1.5')
set(gca,'FontSize',24, 'FontName', 'Times')
