function FieldTestMatExtractor_r3( TrucksDir,MainDir,CleanDatebegin,CleanDateEnd,Params,tstart,tend )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%S = dir(fullfile(TrucksDir{i}));
i=1;
cnt = 1;
folder  = '';
Dir = TrucksDir;
cd(Dir);
MAT = dir('**/*.mat');
MAT = MAT(find(([MAT.datenum]>=CleanDatebegin & [MAT.datenum]<CleanDateEnd)));

%% Assign data from each matfile into a variable
for j = 1:numel(MAT)
    
    cd(MAT(j).folder)
    listOfVariables = who('-file',MAT(j).name);
    Params_ind = ismember(Params,listOfVariables);
    Params = Params(Params_ind);
    
    load(strcat(MAT(j).folder,'\',MAT(j).name),Params{:},'H_FED_q_*','H_FED_ct_*')
    time{i,cnt} = PC_TStamp_Datenum.';
    time_1s{i,cnt} = PC_TStamp_Datenum_1_Sec_Screen_2.';
    time_10s{i,cnt} = PC_TStamp_Datenum_10_Sec.';
    time_200s{i,cnt} = PC_TStamp_Datenum_200ms.';
    MeanInjPrs{i,cnt} = IFM_hp_EOCMeanInjPressure_200ms.';
    ValidDrop{i,cnt} = IFM_s_ValidPressureDrop_200ms.';
    Coolant_Temp{i,cnt} = Coolant_Temperature_200ms.';
    Pumping{i,cnt} = P_BPD_ct_IFMPumping_1_Sec_Screen_2.';
    Leakage_IFM{i,cnt} =   P_BPD_ct_IFMLeakage_1_Sec_Screen_2.';
    Cycle{i,cnt} = P_BPD_ct_IFMTotalCycle_1_Sec_Screen_2.';
    Cmd{i,cnt} = APC_hp_Cmd_200ms.';
    Fdbk{i,cnt} = APC_hp_Fdbk_200ms.';
    Total_fueling{i,cnt} = Total_Fueling_200ms.';
    Engine_Speed2{i,cnt} = Engine_Speed_1_Sec_Screen_2.';
    Engine_Speed_1s{i,cnt} = Engine_Speed_200ms.';
    Mot_flag{i,cnt} = CBM_Mot_Flag_200ms.';
    EstFuel{i,cnt} = IFM_q_EOCEstFueling_200ms.';
    TestCylNum{i,cnt} = IFM_ct_EOCTestCylNum_200ms.';
    CCPO{i,cnt} = Combustion_Control_Path_Owner_200ms.';
    Gear{i,cnt} = CANC_Current_Gear_200ms.';
    ENGState{i,cnt} = Current_Engine_State_200ms.';
    DLAtime{i,cnt} = DLA_Timestamp.';
    DLAtime_1s{i,cnt} = DLA_Timestamp_1_Sec_Screen_2.';
    DLAtime_10s{i,cnt} = DLA_Timestamp_10_Sec.';
    DLAtime_200s{i,cnt} = DLA_Timestamp_200ms.';
    PRV_cmd{i,cnt} = PRV_i_Cmd_200ms.';
    PRV_fdbk{i,cnt} = PRV_i_Fdbk_200ms.';
    APC_qr{i,cnt} = APC_qr_Cmd_200ms.';
    IMA_cmd{i,cnt} = H_IMA_i_Cmd_200ms.';
    IMA_fdbk{i,cnt} = H_IMA_i_Fltr_200ms.';
    SetPump{i,cnt} = P_BPD_ct_SetIfmPumpErr_10_Sec.';
    
    if ismember('H_FED_q_CylAveFuelingErrors0_10_Sec',listOfVariables)
        for k = 1:6
            CylAve{k,cnt} = eval(['H_FED_q_CylAveFuelingErrors',int2str(k-1),'_10_Sec']).';
        end
        FedTime{i,cnt} = PC_TStamp_Datenum_10_Sec.';
    elseif ismember('H_FED_q_CylAveFuelingErrors0_200ms',listOfVariables)
        for k = 1:6
            CylAve{k,cnt} = eval(['H_FED_q_CylAveFuelingErrors',int2str(k-1),'_200ms']).';
        end
        FedTime{i,cnt} = PC_TStamp_Datenum_200ms.';
    end
    
    if ismember('IFM_hp_Residual_200ms',listOfVariables)
        Residual{i,cnt} = IFM_hp_Residual_200ms.';
        ResidualTime{i,cnt} = PC_TStamp_Datenum_200_Sec.';
    elseif ismember('IFM_hp_Residual',listOfVariables)
        Residual{i,cnt} = IFM_hp_Residual.';
        ResidualTime{i,cnt} = PC_TStamp_Datenum_10_Sec.';
    end
    
    if ismember('IFM_r_ParasiticLeakage_200ms',listOfVariables)
        Leakage{i,cnt} = IFM_hp_Residual_200ms.';
        LeakageTime{i,cnt} = PC_TStamp_Datenum_200_Sec.';
    elseif ismember('IFM_r_ParasiticLeakage',listOfVariables)
        Leakage{i,cnt} = IFM_hp_Residual.';
        LeakageTime{i,cnt} = PC_TStamp_Datenum_10_Sec.';
    end
 
    DosingFuel{i,cnt} = P_FED_q_DosingFuelAdj_10_Sec.';
    CompensationOntime{i,cnt} = P_FED_ti_AveOntimeErrorBias.';
    CompensationFuel{i,cnt}= P_FED_q_AveFuelingErrorBias.';
    cnt = cnt+1;
    
    
end



%% Concatenate daily matfiles, into one long data vector 
time = cat(2,time{:});
time_1s = cat(2,time_1s{:});
Coolant = cat(2,Coolant_Temp{:});
time_10s =cat(2,time_10s{:});
time_200s=cat(2,time_200s{:});
MeanInjPrs= cat(2,MeanInjPrs{:});
Residual = cat(2,Residual{:});
Leakage= cat(2,Leakage{:});
ValidDrop= cat(2,ValidDrop{:});
Pumping =  cat(2,Pumping{:});
Leakage_IFM=  cat(2,Leakage_IFM{:});
Cycle= cat(2,Cycle{:});
Cmd= cat(2,Cmd{:});
Fdbk = cat(2,Fdbk{:});
Total_fueling = cat(2,Total_fueling{:});
Engine_Speed = cat(2,Engine_Speed2{:});
Engine_Speed_1s = cat(2,Engine_Speed_1s{:});
Mot_flag = cat(2,Mot_flag{:});
EstFuel = cat(2,EstFuel{:});
TestCylNum= cat(2,TestCylNum{:});
DosingFuel = cat(2,DosingFuel{:});
CompensationOntime = cat(2,CompensationOntime{:});
CompensationFuel=  cat(2,CompensationFuel{:});
CCPO= cat(2,CCPO{:});
Gear= cat(2,Gear{:});
ENGState= cat(2,ENGState{:});
DLAtime = cat(2,DLAtime{:});
DLAtime_1s = cat(2,DLAtime_1s{:});
DLAtime_10s= cat(2,DLAtime_10s{:});
DLAtime_200s= cat(2,DLAtime_200s{:});
PRV_cmd = cat(2,PRV_cmd{:});
PRV_fdbk= cat(2,PRV_fdbk{:});
APC_qr= cat(2,APC_qr{:});
IMA_cmd = cat(2,IMA_cmd{:});
IMA_fdbk = cat(2,IMA_fdbk{:});
SetPump = cat(2,SetPump{:});
FedTime= cat(2,FedTime{:});
ResidualTime = cat(2,ResidualTime{:});
LeakageTime = cat(2,LeakageTime{:});




cd('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts')
%% Entering the plot section
time_40s = Timestamp(time_10s,0).';
time_1 = Timestamp(time_1s,0);
time_200 = Timestamp(time_200s,0);
time_0 = Timestamp(time,0);
FedTime=  Timestamp(FedTime,0);
ResidualTime = Timestamp(FedTime,0);
LeakageTime = Timestamp(FedTime,0);

NewFolder = strcat('Capability-',datestr(datetime('today')));
mkdir(MainDir,NewFolder)
cd(strcat(MainDir,'\',NewFolder))
save workspace 

% index = find(Engine_Speed<1950);
% index_1s = find(Engine_Speed_1s<1950)
% Resid = Residual(index_1s);
% TimeAxis = time_1(index);
% BPDCounts = Pumping(index);
% eRPM = Engine_Speed_1s(index_1s);
% unique_idx =0;
% cnt =1;
% for j = 1:length(Resid)-1
%     if(Resid(j+1) ~=Resid(j))
%         unique_idx(cnt) = j;
%         cnt = cnt +1;
%     end
% end
% 
% Capability = struct('TimeAxis',TimeAxis,'PumpingCnts',BPDCounts,'Name',MAT(1).name(1:10),'Residuals',Resid(unique_idx),'EngineSpeed',eRPM(unique_idx));

% % DLAtimevec = Timestamp(DLAtime,0);
% % DLAtime_1svec = Timestamp(DLAtime_1s,0);
% % DLAtime_10svec= Timestamp(DLAtime_10s,0);
% % DLAtime_200svec= Timestamp(DLAtime_200s,0);
% % [newCool,axislength] = DownSample(Coolant,200e-3,10);
% % time_40s = time_40s(1:axislength);
% fix = find( ~(time_40s > datetime(2020,03,22,23,59,00)));
% 

tstart = MAT(1).date;
tend =MAT(end).date;
Color_Vec = [ 'k', 'g' ,'b', 'm', 'r','c'];
max_fuel =0;
min_fuel =0;
figure(1)
ag(1)=subplot(3,1,1)
for i = 1:6
    
    Cyl = cat(2,CylAve{i,:});
    max_fuel = max(Cyl);
    min_fuel = min(Cyl);
    
    if(max_fuel < max(Cyl))
        max_fuel = max(Cyl);
    end
    
    if(min_fuel > min(Cyl))
        min_fuel = min(Cyl);
    end
    
    cnt = 1;
    for j = 1:length(Cyl)-1
        if(Cyl(j+1) ~=Cyl(i))
            unique_idx(cnt) = j;
            cnt = cnt +1;
        end
    end
    plot(FedTime,Cyl(1:length(FedTime)),strcat(Color_Vec(i),'o'))
    hold on
end
xlim([tstart tend])
yticks([floor(min_fuel)-1 :2:ceil(max_fuel)+1])
ylim([ floor(min_fuel)-1  ceil(max_fuel)+1])
ylabel('FED Decisions (mg/strk)')
title('FED Decisions vs Time')
legend('Cyl1','Cyl2','Cyl3','Cyl4','Cyl5','Cyl6')
hold off
suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))

ag(2)=subplot(312)
plot(time_200,Coolant);
ylim([30 95])
xlim([tstart tend])
ylabel('Coolant Temp')
title('Cooolant vs Time')

ag(3)=subplot(313)
minD = floor(min(DosingFuel));
maxD = ceil(max(DosingFuel));
if(maxD>30)
    maxD = ceil(max(CompensationFuel));
    minD = floor(min(CompensationFuel));
end
minC = floor(min(CompensationOntime));
maxC = ceil(max(CompensationOntime));
plot(time_40s,DosingFuel(1:length(time_40s)),'o')
hold on
plot(time_0,CompensationFuel,'o')
ylabel('Dosing Fuel Adjustment(mg/strk)')
yticks(minD-.5:1:maxD+.5)
ylim([minD-0.5 maxD+0.5])
yyaxis right
plot(time_0,CompensationOntime,'-')
ylabel('AveErrorOntimeBias')
title('Compensation')
yticks(minC-.5*minC:0.001:maxC+.5*maxC)
legend('DosingFuelAdj','AveFuelErrorBias','AveErrorOntimeBias')
xlim([tstart tend])
linkaxes(ag,'x');
savefig(strcat(MainDir,'\',NewFolder,'\','FEDTimeSeries.fig'))
close(gcf)

figure(2)
for i = 1:6
    
    Cyl = cat(2,CylAve{i,:});
    cnt = 1;
    for j = 1:length(Cyl)-1
        if(Cyl(j+1) ~=Cyl(i))
            unique_idx2(cnt) = j;
            cnt = cnt +1;
        end
    end
    Cyl2 = Cyl(unique_idx2);
    cylind = find(~(Cyl2 ==0));
    Cyl = Cyl2(cylind);
    subplot(2,3,i)
   h1= histfit(Cyl);
   d = fitdist(Cyl.','normal');
   
    hold on
    plot(d.mean*ones(1,max(h1(1).YData)),1:max(h1(1).YData),'r--','LineWidth',3)
    ylim([ 0 max(h1(1).YData)+100])
    minA = min(h1(1).YData)-1;
    maxB =max(h1(1).YData)+1;
    xlim([-10 10])
    xticks([-10:1:10])
    title(strcat('Cylinder',int2str(i),'Distribution'))
    legend('Cylinder distribution','Mean of distribution')
    
end
xlabel('FED Decisions(mg/strk)')
ylabel('Frequency')
suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))
savefig(strcat(MainDir,'\',NewFolder,'\','CylDistribution.fig'))
close(gcf)





figure(3)
ind = find( ValidDrop == 1);
MeanInjPrs2 = MeanInjPrs(ind);
for i = 1:6
    TestCyl = TestCylNum(ind);
    EstFuel2 = EstFuel(ind);
    time_2002 = time_200(ind);
    ind2 = find( TestCyl == i-1);
    MeanInjPrs3 = MeanInjPrs2(ind2);
    ay(i)=subplot(2,3,i)
    plot(time_2002(ind2),EstFuel2(ind2),'o')
    hold on
    plot(time_2002(ind2),20*ones(1,numel(time_2002(ind2))),'r--')
    ylim([0 60])
    yticks([0:4:60])
    ylabel('Estimated Fueling')
    title('Estimated Fueling vs MeanInjPressure')
    hold on
    yyaxis right
    plot(time_2002(ind2),MeanInjPrs3,'k+')
    ylim([0 1300])
    yticks([0:50:1300])
    xlim([tstart tend])
    ylabel('Mean Injection Pressure')
    legend(strcat('Cyl',int2str(i)),'Commanded Fueling','MeanInjPrs')
    
end


suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))
linkaxes(ay,'x','y');
savefig(strcat(MainDir,'\',NewFolder,'\','EstFuelvsMeanInjPrs.fig'))
close(gcf)


figure(4)
unique_idx =0;
cnt =1;
for j = 1:length(Residual)-1
    if(Residual(j+1) ~=Residual(j))
        unique_idx(cnt) = j;
        cnt = cnt +1;
    end
end

subplot(211)
plot(Engine_Speed_1s(unique_idx),Residual(unique_idx),'o')
hold on
plot(Engine_Speed_1s(unique_idx),40*ones(1,length(unique_idx)),'r--')
xlabel('Engine Speed')
ylabel('Residual')
title('Residuals vs EngineSpeed')
ylim([0 120])
xlim([850 2800])
xticks([850:150:2800])
legend('Residuals','Threshold')

subplot(212)
Residual2 = Residual(unique_idx);
indo = Residual2 < 80;
Residual3 = Residual2(indo);
indo2 = find(~(Residual3 <1));

h=histfit(Residual3(indo2))
hold on
plot(40*ones(1,max(h(1).YData)),1:max(h(1).YData),'r--','LineWidth',3)
xlabel('Residuals')
ylabel('Frequency')
xlim([ -20 80])
title('Histogram of Residuals')
legend('Residuals','Residual Threshold')
suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))

savefig(strcat(MainDir,'\',NewFolder,'\','ResidualsVsEngineSpeed.fig'))
close(gcf)


figure(5)
plot(time_40s,SetPump,time_1,Cycle,time_1,Pumping,'o')
hold on
line(time_1,21*ones(1,numel(time_1)))
xlabel('Time -s')
ylabel('Counts')
title(sprintf('%s, BPD Pumping counts from %s to %s',MAT(1).name(1:10),tstart,tend))
legend('Set BPD fault','P BPD ct IFMTotalCycle', 'P BPD ct IFMPumping','Threshold')
savefig(strcat(MainDir,'\',NewFolder,'\','BPDPLot.fig'))
close(gcf)


figure(6)
ind = find( ValidDrop == 1);
MeanInjPrs2 = MeanInjPrs(ind);
for i = 1:6
    TestCyl = TestCylNum(ind);
    EstFuel2 = EstFuel(ind);
    time_2002 = time_200(ind);
    ind2 = find( TestCyl == i-1);
    MeanInjPrs3 = MeanInjPrs2(ind2);
    
    plot(time_2002(ind2),EstFuel2(ind2),'o')
   hold on
   
end

plot(time_2002(ind2),20*ones(1,numel(time_2002(ind2))),'r--')
ylim([0 60])
yticks([0:4:60])
ylabel('Estimated Fueling')

hold on
yyaxis right
plot(time_2002,MeanInjPrs2,'k+')
ylim([0 1300])
yticks([0:50:1300])
xlim([tstart tend])
ylabel('Mean Injection Pressure')
title('Estimated Fueling vs MeanInjPressure')
legend('Cyl1','Cyl2','Cyl3','Cyl4','Cyl5','Cyl6','Commanded Fueling','MeanInjPrs')



suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))
savefig(strcat(MainDir,'\',NewFolder,'\','EstFuelvsMeanInjPrs_r2.fig'))
close(gcf)



addpath('C:\Users\pb875\Documents\GitHub\Scripts')
run InDepth_plot.m
savefig(strcat(MainDir,'\',NewFolder,'\','InDepth.fig'))
close(gcf)

% 
% %% Adding a new section for capability 


end

