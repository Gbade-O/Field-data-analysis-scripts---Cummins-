function Capability = FieldTestMatExtractor_r4( TrucksDir,MainDir,CleanDatebegin,CleanDateEnd,Params,tstart,tend )
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
CylAve = {};
NoDecisions =0;

%% Assign data from each matfile into a variable
for j = 1:numel(MAT)
    
    cd(MAT(j).folder)
    listOfVariables = who('-file',MAT(j).name);
    Params_ind = ismember(Params,listOfVariables);
    
    
    load(strcat(MAT(j).folder,'\',MAT(j).name),Params{:},'H_FED_q*')
    
    time{i,cnt} = PC_TStamp_Datenum.';
    time_1s{i,cnt} = PC_TStamp_Datenum_1_Sec_Screen_2.';
    time_10s{i,cnt} = PC_TStamp_Datenum_10_Sec.';
    time_200s{i,cnt} = PC_TStamp_Datenum_200ms.';
    %         MeanInjPrs{i,cnt} = IFM_hp_EOCMeanInjPressure_200ms.';
    Residual{i,cnt} = IFM_hp_Residual.';
    Leakage{i,cnt} = IFM_r_ParasiticLeakage.';
    %         ValidDrop{i,cnt} = IFM_s_ValidPressureDrop_200ms.';
    %         Coolant_Temp{i,cnt} = Coolant_Temperature_200ms.';
    Pumping{i,cnt} = P_BPD_ct_IFMPumping_1_Sec_Screen_2.';
    %         Leakage_IFM{i,cnt} =   P_BPD_ct_IFMLeakage_1_Sec_Screen_2.';
    Cycle{i,cnt} = P_BPD_ct_IFMTotalCycle_1_Sec_Screen_2.';
    Cmd{i,cnt} = APC_hp_Cmd_200ms.';
    Fdbk{i,cnt} = APC_hp_Fdbk_200ms.';
    Total_fueling{i,cnt} = Total_Fueling_200ms.';
    Engine_Speed2{i,cnt} = Engine_Speed_1_Sec_Screen_2.';
    Engine_Speed_1s{i,cnt} = Engine_Speed.';
    Engine_Speed200ms{i,cnt} = Engine_Speed_200ms.';
    %         Mot_flag{i,cnt} = CBM_Mot_Flag_200ms.';
    %         EstFuel{i,cnt} = IFM_q_EOCEstFueling_200ms.';
    %         TestCylNum{i,cnt} = IFM_ct_EOCTestCylNum_200ms.';
    %         CCPO{i,cnt} = Combustion_Control_Path_Owner_200ms.';
    %         Gear{i,cnt} = CANC_Current_Gear_200ms.';
    %         ENGState{i,cnt} = Current_Engine_State_200ms.';
    %         DLAtime{i,cnt} = DLA_Timestamp.';
    %         DLAtime_1s{i,cnt} = DLA_Timestamp_1_Sec_Screen_2.';
    %         DLAtime_10s{i,cnt} = DLA_Timestamp_10_Sec.';
    %         DLAtime_200s{i,cnt} = DLA_Timestamp_200ms.';
    PRV_cmd{i,cnt} = PRV_i_Cmd_200ms.';
    PRV_fdbk{i,cnt} = PRV_i_Fdbk_200ms.';
    %         APC_qr{i,cnt} = APC_qr_Cmd_200ms.';
    IMA_cmd{i,cnt} = H_IMA_i_Cmd_200ms.';
    IMA_fdbk{i,cnt} = H_IMA_i_Fltr_200ms.';
    SetPump{i,cnt} = P_BPD_ct_SetIfmPumpErr_10_Sec.';
    KeyCycles{i,cnt} = OBD_Number_Of_Key_Cycles_10_Sec.';
    VehSpeed{i,cnt} = Vehicle_Speed_200ms.';
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
    %
    
    %         DosingFuel{i,cnt} = P_FED_q_DosingFuelAdj_10_Sec.';
    %         CompensationOntime{i,cnt} = P_FED_ti_AveOntimeErrorBias.';
    %         CompensationFuel{i,cnt}= P_FED_q_AveFuelingErrorBias.';
    cnt = cnt+1;
end


cd(MainDir)

%% Concatenate daily matfiles, into one long data vector 
time = cat(2,time{:});
time_1s = cat(2,time_1s{:});
% Coolant = cat(2,Coolant_Temp{:});
time_10s =cat(2,time_10s{:});
time_200s=cat(2,time_200s{:});
% MeanInjPrs= cat(2,MeanInjPrs{:});
Residual = cat(2,Residual{:});
Leakage= cat(2,Leakage{:});
% ValidDrop= cat(2,ValidDrop{:});
Pumping =  cat(2,Pumping{:});
% Leakage_IFM=  cat(2,Leakage_IFM{:});
Cycle= cat(2,Cycle{:});
Cmd= cat(2,Cmd{:});
Fdbk = cat(2,Fdbk{:});
Total_fueling = cat(2,Total_fueling{:});
Engine_Speed = cat(2,Engine_Speed2{:});
Engine_Speed_1s = cat(2,Engine_Speed_1s{:});
Engine_Speed200ms = cat(2,Engine_Speed200ms{:});
% Mot_flag = cat(2,Mot_flag{:});
% EstFuel = cat(2,EstFuel{:});
% TestCylNum= cat(2,TestCylNum{:});
% DosingFuel = cat(2,DosingFuel{:});
% CompensationOntime = cat(2,CompensationOntime{:});
% CompensationFuel=  cat(2,CompensationFuel{:});
% CCPO= cat(2,CCPO{:});
% Gear= cat(2,Gear{:});
% ENGState= cat(2,ENGState{:});
% DLAtime = cat(2,DLAtime{:});
% DLAtime_1s = cat(2,DLAtime_1s{:});
% DLAtime_10s= cat(2,DLAtime_10s{:});
% DLAtime_200s= cat(2,DLAtime_200s{:});
PRV_cmd = cat(2,PRV_cmd{:});
PRV_fdbk= cat(2,PRV_fdbk{:});
% APC_qr= cat(2,APC_qr{:});
IMA_cmd = cat(2,IMA_cmd{:});
IMA_fdbk = cat(2,IMA_fdbk{:});
SetPump = cat(2,SetPump{:});
KeyCycles = cat(2,KeyCycles{:});
VehSpeed = cat(2,VehSpeed{:});
FedTime = cat(2,FedTime{:});

CylAvgs = [];
for k = 1:6
    temp = CylAve(k,:);
    CylAvgs = cat(1,CylAvgs,cat(2,temp{:}));
end

%% calculate capability AFS
% want to compare capability for BPD measurements *logged* only

% look for changes in IFM total cycle counter; if counter changes, check
% 1. if this was due to a gap in the log (check timestamps); if so ignore
% 2. if the engine speed is > 1950
%       if yes, update the IFM total cycle / pump counters for the "oldcal"
%               case only
%       if no, update the IFM total cycle / pump counters for the "oldcal"
%               AND "newcal" case
% 3. anytime either the "oldcal" or "newcal" total cycle counter rolls
% over, log the value of the pump counter and datetime, then reset counters

cycleLimit = 25;

% convert PC Timestamp to datetime
time_1 = Timestamp(time_1s,0);

% initialize counters
oldcal_pumpCount = 0;
oldcal_cycleCount = 0;
newcal_pumpCount = 0;
newcal_cycleCount = 0;

% initialize capability parameters
capability_oldcal_counter = [];
capability_oldcal_datetime = [];
capability_newcal_counter = [];
capability_newcal_datetime = [];

% find where Cycle changes
cycleChangeInds = find(diff(Cycle) ~= 0) + 1;

% investigate each change event
for j = 1:length(cycleChangeInds)
    ind = cycleChangeInds(j);
    
    if seconds(time_1(ind) - time_1(ind-1)) > 2
        % gap in the log; we don't know what speed the last measurements
        % were taken at; skip this update
        continue
    end
    
    newCycles = Cycle(ind) - Cycle(ind-1);
    if newCycles < 0
        newCycles = newCycles + cycleLimit;
        newPumpEvts = Pumping(ind); % we know there are at least this many; don't know exactly
    else
        newPumpEvts = Pumping(ind) - Pumping(ind-1);
    end
    
    % update oldcal counters
    oldcal_cycleCount = oldcal_cycleCount + newCycles;
    if oldcal_cycleCount > cycleLimit
        oldcal_cycleCount = oldcal_cycleCount - cycleLimit;
        if newPumpEvts > oldcal_cycleCount
            % some pumps in the old cycle, some in the new
            oldcal_pumpCount = oldcal_pumpCount + (newPumpEvts - oldcal_cycleCount);
            
            capability_oldcal_counter = cat(1,capability_oldcal_counter,oldcal_pumpCount);
            
            oldcal_pumpCount = oldcal_cycleCount;
        else
            % assume all pumps in new cycle
            capability_oldcal_counter = cat(1,capability_oldcal_counter,oldcal_pumpCount);
            
            oldcal_pumpCount = newPumpEvts;
        end
        
        capability_oldcal_datetime = cat(1,capability_oldcal_datetime,time_1(ind));
        
    else
        oldcal_pumpCount = oldcal_pumpCount + newPumpEvts;
    end
    
    % update newcal counters
    engSpd = Engine_Speed(ind);
    if engSpd < 1950
        newcal_cycleCount = newcal_cycleCount + newCycles;
        if newcal_cycleCount > cycleLimit
            newcal_cycleCount = newcal_cycleCount - cycleLimit;
            if newPumpEvts > newcal_cycleCount
                % some pumps in the old cycle, some in the new
                newcal_pumpCount = newcal_pumpCount + (newPumpEvts - newcal_cycleCount);

                capability_newcal_counter = cat(1,capability_newcal_counter,newcal_pumpCount);

                newcal_pumpCount = newcal_cycleCount;
            else
                % assume all pumps in new cycle
                capability_newcal_counter = cat(1,capability_newcal_counter,newcal_pumpCount);

                newcal_pumpCount = newPumpEvts;
            end

            capability_newcal_datetime = cat(1,capability_newcal_datetime,time_1(ind));

        else
            newcal_pumpCount = newcal_pumpCount + newPumpEvts;
        end
        
    end
    
end
%% IUPR analysis AFS
% for each OBD Key Cycle (should be roughly equivalent to OBD Op Cycle)
% logged, see how much motoring time would be available to IFM with the old
% cal vs. with the new cal. Also track when FED made a decision on all
% cylinders, and track how much motoring time that took. Ignore
% CtrlPathOwner, so this total motoring time will potentially include times
% when enable conditions weren't met, or FED didn't have arbitration.

C_IFM_ti_MaxZeroFuelTime = 20;
C_IFM_n_MinSpeed = 850;
C_IFM_n_MinVehicleSpeed = 32;

% % convert PC Timestamps to datetime % slow
% time_10s = Timestamp(time_10s,0);
% time_200s = Timestamp(time_200s,0);

% initialize IUPR tracking data
iupr_keyCycle = [];
iupr_startTime = [];
iupr_endTime = [];
iupr_oldCalMotTime = [];
iupr_newCalMotTime = [];
iupr_MotTimeToFedDec = [];

% find all key cycles, and start and end times
firstInd = find(~isnan(KeyCycles),1,'first');
lastInd = firstInd;
currKeyCycle = KeyCycles(firstInd);

for j = (firstInd+1):length(KeyCycles)
    if ~isnan(KeyCycles(j))
        if KeyCycles(j) ~= currKeyCycle
            
            iupr_keyCycle = cat(1,iupr_keyCycle,currKeyCycle);
            iupr_startTime = cat(1,iupr_startTime,time_10s(firstInd));
            iupr_endTime = cat(1,iupr_endTime,time_10s(lastInd));
            
            firstInd = j;
            lastInd = j;
            currKeyCycle = KeyCycles(j);
            
        else
            lastInd = j;
        end
    end
    
end

iupr_keyCycle = cat(1,iupr_keyCycle,currKeyCycle);
iupr_startTime = cat(1,iupr_startTime,time_10s(firstInd));
iupr_endTime = cat(1,iupr_endTime,time_10s(lastInd));

% calculate motoring times for each cycle
for j = 1:length(iupr_keyCycle)
    
    % subset arrays for this key cycle
    inds200ms = iupr_startTime(j) <= time_200s & time_200s <= iupr_endTime(j);
    if ~any(inds200ms)
        iupr_oldCalMotTime = cat(1,iupr_oldCalMotTime,nan);
        iupr_newCalMotTime = cat(1,iupr_newCalMotTime,nan);
        iupr_MotTimeToFedDec = cat(1,iupr_MotTimeToFedDec,nan);
        continue
    end
    cycTime200ms = time_200s(inds200ms);
    cycEngSpd = Engine_Speed200ms(inds200ms);
    cycFuel = Total_fueling(inds200ms);
    cycVehSpd = VehSpeed(inds200ms);
    
    indsFed = iupr_startTime(j) <= FedTime & FedTime <= iupr_endTime(j);
    cycTimeFed = FedTime(indsFed);
    cycCylAvgs = CylAvgs(:,indsFed);
    
    % find when FED made a decision (if it did)
    efiDecisionInd = find(all(cycCylAvgs ~= 0,1) & all(cycCylAvgs ~= cycCylAvgs(:,1),1),1,'first');
    if isempty(efiDecisionInd)
        efiDecisionTime = nan;
    else
        efiDecisionTime = cycTimeFed(efiDecisionInd);
    end
    
    % look for motoring events
    totMotTimeOldCal = 0;
    totMotTimeNewCal = 0;
    
    zeroFuelTime = 0;
    
    fedDecFound = 0;
    loggedPriorToFedDec = 0;
    totMotToFed = nan;
    
    for k = 1:length(cycTime200ms)
        
        if ~loggedPriorToFedDec && cycTime200ms(k) < efiDecisionTime
            % data timestamps aren't in order for some reason, so make sure
            % we have some data logged prior to FED making a decision
            loggedPriorToFedDec = 1;
        end
        
        if ~fedDecFound && loggedPriorToFedDec && cycTime200ms(k) >= efiDecisionTime
            totMotToFed = totMotTimeOldCal;
            fedDecFound = 1;
        end
        
        if cycFuel(k) > 0
            zeroFuelTime = 0;
        elseif ~isnan(cycFuel(k))
            % motoring
            zeroFuelTime = zeroFuelTime + 0.2;
            
            if zeroFuelTime <= C_IFM_ti_MaxZeroFuelTime && cycVehSpd(k) > C_IFM_n_MinVehicleSpeed && cycEngSpd(k) > C_IFM_n_MinSpeed
                % valid motoring time for old cal
                totMotTimeOldCal = totMotTimeOldCal + 0.2;
                
                if cycEngSpd(k) < 1950
                    % valid motoring time for new cal
                    totMotTimeNewCal = totMotTimeNewCal + 0.2;
                    
                end
                
            end
             
        end
        
    end
    
    iupr_newCalMotTime = cat(1,iupr_newCalMotTime,totMotTimeNewCal);
    iupr_oldCalMotTime = cat(1,iupr_oldCalMotTime,totMotTimeOldCal);
    iupr_MotTimeToFedDec = cat(1,iupr_MotTimeToFedDec,totMotToFed);
    
end

%% Structs 
% iupr_startTime = Timestamp(iupr_startTime,0);
% iupr_endTime = Timestamp(iupr_endTime,0);

NewFolder = strcat('Capability-',datestr(datetime('today')));
mkdir(MainDir,NewFolder)
cd(strcat(MainDir,'\',NewFolder))



Capability = struct('Old_TimeAxis',capability_oldcal_datetime,'Old_PumpingCnts',capability_oldcal_counter,... 
    'New_TimeAxis',capability_newcal_datetime,'New_PumpingCnts',capability_newcal_counter,...
    'Old_Mot',iupr_oldCalMotTime,'New_Mot',iupr_newCalMotTime,'TimetoDec',iupr_MotTimeToFedDec,'KeyCycles',iupr_keyCycle,'Name',MAT(1).name(1:10))


addpath('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts') 

%% Entering the plot section
% time_40s = Timestamp(time_10s,0).';
% time_1 = Timestamp(time_1s,0);
% time_200 = Timestamp(time_200s,0);
% time_0 = Timestamp(time,0);

save workspace 
% 
% NewFolder = strcat('Capability-',datestr(datetime('today')));
% mkdir(MainDir,NewFolder)
% cd(strcat(MainDir,'\',NewFolder))
% save workspace 
% 
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
% Color_Vec = [ 'k', 'g' ,'b', 'm', 'r','c'];
% max_fuel =0;
% min_fuel =0;
% figure(1)
% ag(1)=subplot(3,1,1)
% for i = 1:6
%     
%     Cyl = cat(2,CylAve{i,:});
%     max_fuel = max(Cyl);
%     min_fuel = min(Cyl);
%     
%     if(max_fuel < max(Cyl))
%         max_fuel = max(Cyl);
%     end
%     
%     if(min_fuel > min(Cyl))
%         min_fuel = min(Cyl);
%     end
%     
%     cnt = 1;
%     for j = 1:length(Cyl)-1
%         if(Cyl(j+1) ~=Cyl(i))
%             unique_idx(cnt) = j;
%             cnt = cnt +1;
%         end
%     end
%     plot(time_40s,Cyl(1:length(time_40s)),strcat(Color_Vec(i),'o'))
%     hold on
% end
% xlim([tstart tend])
% yticks([floor(min_fuel)-1 :2:ceil(max_fuel)+1])
% ylim([ floor(min_fuel)-1  ceil(max_fuel)+1])
% ylabel('FED Decisions (mg/strk)')
% title('FED Decisions vs Time')
% legend('Cyl1','Cyl2','Cyl3','Cyl4','Cyl5','Cyl6')
% hold off
% suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:5),tstart,tend))
% 
% ag(2)=subplot(312)
% plot(time_200,Coolant);
% ylim([30 95])
% xlim([tstart tend])
% ylabel('Coolant Temp')
% title('Cooolant vs Time')
% 
% ag(3)=subplot(313)
% minD = floor(min(DosingFuel));
% maxD = ceil(max(DosingFuel));
% if(maxD>30)
%     maxD = ceil(max(CompensationFuel));
%     minD = floor(min(CompensationFuel));
% end
% minC = floor(min(CompensationOntime));
% maxC = ceil(max(CompensationOntime));
% plot(time_40s,DosingFuel(1:length(time_40s)),'o')
% hold on
% plot(time_0,CompensationFuel,'o')
% ylabel('Dosing Fuel Adjustment(mg/strk)')
% yticks(minD-.5:1:maxD+.5)
% ylim([minD-0.5 maxD+0.5])
% yyaxis right
% plot(time_0,CompensationOntime,'-')
% ylabel('AveErrorOntimeBias')
% title('Compensation')
% yticks(minC-.5*minC:0.001:maxC+.5*maxC)
% legend('DosingFuelAdj','AveFuelErrorBias','AveErrorOntimeBias')
% xlim([tstart tend])
% linkaxes(ag,'x');
% savefig(strcat(MainDir,'\',NewFolder,'\','FEDTimeSeries.fig'))
% close(gcf)
% 
% figure(2)
% for i = 1:6
%     
%     Cyl = cat(2,CylAve{i,:});
%     cnt = 1;
%     for j = 1:length(Cyl)-1
%         if(Cyl(j+1) ~=Cyl(i))
%             unique_idx2(cnt) = j;
%             cnt = cnt +1;
%         end
%     end
%     Cyl2 = Cyl(unique_idx2);
%     cylind = find(~(Cyl2 ==0));
%     Cyl = Cyl2(cylind);
%     subplot(2,3,i)
%    h1= histfit(Cyl);
%    d = fitdist(Cyl.','normal');
%    
%     hold on
%     plot(d.mean*ones(1,max(h1(1).YData)),1:max(h1(1).YData),'r--','LineWidth',3)
%     ylim([ 0 max(h1(1).YData)+100])
%     minA = min(h1(1).YData)-1;
%     maxB =max(h1(1).YData)+1;
%     xlim([-10 10])
%     xticks([-10:1:10])
%     title(strcat('Cylinder',int2str(i),'Distribution'))
%     legend('Cylinder distribution','Mean of distribution')
%     
% end
% xlabel('FED Decisions(mg/strk)')
% ylabel('Frequency')
% suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:5),tstart,tend))
% savefig(strcat(MainDir,'\',NewFolder,'\','CylDistribution.fig'))
% close(gcf)
% 
% 
% 
% 
% 
% figure(3)
% ind = find( ValidDrop == 1);
% MeanInjPrs2 = MeanInjPrs(ind);
% for i = 1:6
%     TestCyl = TestCylNum(ind);
%     EstFuel2 = EstFuel(ind);
%     time_2002 = time_200(ind);
%     ind2 = find( TestCyl == i-1);
%     MeanInjPrs3 = MeanInjPrs2(ind2);
%     ay(i)=subplot(2,3,i)
%     plot(time_2002(ind2),EstFuel2(ind2),'o')
%     hold on
%     plot(time_2002(ind2),20*ones(1,numel(time_2002(ind2))),'r--')
%     ylim([0 60])
%     yticks([0:4:60])
%     ylabel('Estimated Fueling')
%     title('Estimated Fueling vs MeanInjPressure')
%     hold on
%     yyaxis right
%     plot(time_2002(ind2),MeanInjPrs3,'k+')
%     ylim([0 1300])
%     yticks([0:50:1300])
%     xlim([tstart tend])
%     ylabel('Mean Injection Pressure')
%     legend(strcat('Cyl',int2str(i)),'Commanded Fueling','MeanInjPrs')
%     
% end
% 
% 
% suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:5),tstart,tend))
% linkaxes(ay,'x','y');
% savefig(strcat(MainDir,'\',NewFolder,'\','EstFuelvsMeanInjPrs.fig'))
% close(gcf)
% 
% 
% figure(4)
% unique_idx =0;
% cnt =1;
% for j = 1:length(Residual)-1
%     if(Residual(j+1) ~=Residual(j))
%         unique_idx(cnt) = j;
%         cnt = cnt +1;
%     end
% end
% subplot(211)
% plot(Engine_Speed_1s(unique_idx),Residual(unique_idx),'o')
% hold on
% plot(Engine_Speed_1s(unique_idx),40*ones(1,length(unique_idx)),'r--')
% xlabel('Engine Speed')
% ylabel('Residual')
% title('Residuals vs EngineSpeed')
% ylim([0 120])
% xlim([850 2800])
% xticks([850:150:2800])
% legend('Residuals','Threshold')
% 
% subplot(212)
% Residual2 = Residual(unique_idx);
% indo = Residual2 < 80;
% Residual3 = Residual2(indo);
% indo2 = find(~(Residual3 <1));
% 
% h=histfit(Residual3(indo2))
% hold on
% plot(40*ones(1,max(h(1).YData)),1:max(h(1).YData),'r--','LineWidth',3)
% xlabel('Residuals')
% ylabel('Frequency')
% xlim([ -20 80])
% title('Histogram of Residuals')
% legend('Residuals','Residual Threshold')
% suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:10),tstart,tend))
% 
% savefig(strcat(MainDir,'\',NewFolder,'\','ResidualsVsEngineSpeed.fig'))
% close(gcf)
% 
% % 
% figure(5)
% plot(time_40s,SetPump,time_1,Cycle,time_1,Pumping,'o')
% hold on
% line(time_1,21*ones(1,numel(time_1)))
% xlabel('Time -s')
% ylabel('Counts')
% title(sprintf('%s, BPD Pumping counts from %s to %s',MAT(1).name(1:10),tstart,tend))
% legend('Set BPD fault','P BPD ct IFMTotalCycle', 'P BPD ct IFMPumping','Threshold')
% savefig(strcat(MainDir,'\',NewFolder,'\','BPDPLot.fig'))
% close(gcf)
% 
% 
% figure(6)
% ind = find( ValidDrop == 1);
% MeanInjPrs2 = MeanInjPrs(ind);
% for i = 1:6
%     TestCyl = TestCylNum(ind);
%     EstFuel2 = EstFuel(ind);
%     time_2002 = time_200(ind);
%     ind2 = find( TestCyl == i-1);
%     MeanInjPrs3 = MeanInjPrs2(ind2);
%     
%     plot(time_2002(ind2),EstFuel2(ind2),'o')
%    hold on
%    
% end
% 
% plot(time_2002(ind2),20*ones(1,numel(time_2002(ind2))),'r--')
% ylim([0 60])
% yticks([0:4:60])
% ylabel('Estimated Fueling')
% 
% hold on
% yyaxis right
% plot(time_2002,MeanInjPrs2,'k+')
% ylim([0 1300])
% yticks([0:50:1300])
% xlim([tstart tend])
% ylabel('Mean Injection Pressure')
% title('Estimated Fueling vs MeanInjPressure')
% legend('Cyl1','Cyl2','Cyl3','Cyl4','Cyl5','Cyl6','Commanded Fueling','MeanInjPrs')
% 
% 
% 
% suptitle(sprintf('%s, from %s to %s',MAT(1).name(1:5),tstart,tend))
% savefig(strcat(MainDir,'\',NewFolder,'\','EstFuelvsMeanInjPrs_r2.fig'))
% close(gcf)
% 
% 
% 
% figure(6)
% addpath('C:\Users\pb875\Documents\GitHub\Scripts')
% run InDepth_plot.m
% savefig(strcat(MainDir,'\',NewFolder,'\','InDepth2'))
% close(gcf)

% % 
% % %% Adding a new section for capability 


end

