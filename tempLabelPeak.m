clc;clear all;close all;
load('normal2.mat')
N = 3;
time = peak_train(N).sign(:,1);
ppg  = peak_train(N).sign(:,2);
p = peak_train(N).p_idx;
f = peak_train(N).f_idx;
subplot(3,1,1)
plot(time,ppg); hold on;
plot(time(p),ppg(p),'*');
plot(time(f),ppg(f),'o');
%--



Fs = 1/(time(2)-time(1));
nwin = ceil(2*Fs);
for i = 2:length(p)-1
    corWin = ceil(0.2*Fs); % guard    
    nn = p(i):p(i)+nwin -1;
    subplot(3,1,2)
    plot(time(nn),ppg(nn));
    hold on;
    plot(time(p(i+1)),ppg(p(i+1)),'*'); 
    hold on; 
    for j=1:length(f)
        tf = time(f(j));
        t1 = time(p(i));
        t2 = time(p(i)+nwin);
        if(tf>t1 && tf<t2)
            plot(time(f(j)),ppg(f(j)),'o'); hold on;
        end
        title('Input')
        grid on
    end
    hold off;
        
    nncor = - corWin + p(i): p(i) + corWin;
    for k = 1:nwin
        cor(k) = sum( ppg(nncor).*ppg(nncor+k) );
    end
    
    subplot(3,1,3);
    plot(time(p(i)+1:p(i)+nwin),cor);         
    hold off;
    title('Previous conv');
    grid on;
    
    
end
grid on;
    