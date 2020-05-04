

%%
ax(1) = subplot(511)
plot(time_200,Engine_Speed_1s,time_200,Cmd,time_200,Fdbk)
hold on
yyaxis right 
plot(time_200,Total_fueling)
legend('Engine Speed','Command','Feedback','Total Fueling')
xlim([ tstart tend])

ax(2)=subplot(514)
plot(time_1,Cycle,time_1,Pumping,'o',time_1,Leakage_IFM)
hold on
line(time_1,21*ones(1,numel(time_1)))
xlabel('Time -s')
ylabel('Counts')
title(sprintf('%s, BPD Pumping counts from %s to %s',MAT(1).name(1:5),tstart,tend))
legend('P BPD ct IFMTotalCycle', 'P BPD ct IFMPumping','Leakage','Threshold')
xlim([ tstart tend])

ax(3)=subplot(512)
plot(time_200,ValidDrop,'o')
ylim([ 0 2])
hold on
yyaxis right 
plot(time_200,TestCylNum,'o')
legend('Valid Pressure drop flag','Test Cylinder number')
xlim([ tstart tend])

ax(4)=subplot(513)
plot(time_200,Residual,'o')
ylim([ 0 65])
hold on
yyaxis right 
plot(time_200,Leakage)
legend('Residuals','Parasitic Leakage')
xlim([ tstart tend])


ax(5)=subplot(515)
plot(time_200,PRV_cmd,time_200,PRV_fdbk,time_200,IMA_cmd,time_200,IMA_fdbk)
ylim([ 1 2])
yticks(1:0.2:2)
legend('PRV Cmd','PRV Fdbk','IMA_cmd','IMA_fdbk')
xlim([ tstart tend])

linkaxes(ax,'x');

% subplot(516)
% plot(time_200,Gear,time_200,ENGState)
% ylim([ 0 10])
% legend('Gear','Engine State')
% xlim([ tstart tend])


