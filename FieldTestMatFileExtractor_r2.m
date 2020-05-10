%% FED Field test data processing script 
clc;clear all
tic
MainDir = {'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric'};
Subdir = dir(MainDir{:});
Subdir = Subdir(contains({Subdir.name},{'VSO','VHO','Thunderbolt'}));


d1 = '2020-1-1 6:00:00';
d2 = '2020-04-30 23:00:00';
t = datetime(d1,'InputFormat','yyyy-MM-dd HH:mm:ss')
t1 = datetime(d2,'InputFormat','yyyy-MM-dd HH:mm:ss')
tstart = t;
tend = t1;
CleanDate1 = datenum(t);
CleanDate2 = datenum(t1);


addpath('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts')
Params = ReadParams('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts\UsefulOverlays_FiltFiles\FieldTest_Parameters_Chrysler.txt');
cnt = 1;
for j = 1:numel(Subdir)
    
    Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
    
    for k = 1:numel(Truckfolders)
        addpath('C:\Users\pb875\Documents\GitHub\Scripts')
        DataDir = strcat(strcat(Truckfolders(k).folder,'\',Truckfolders(k).name,'\Matfiles')); %% Where the matfiles are saved
        SaveDir = strcat(strcat(Truckfolders(k).folder,'\',Truckfolders(k).name)); %%Location to save plots and workspace
        Capability(cnt) = FieldTestMatExtractor_r4(DataDir,SaveDir,CleanDate1,CleanDate2,Params,tstart,tend);
        cnt =cnt+1;
        
    end
end
toc

% %% Capability plots 
% toc
save workspace
% % %% plot AFS
% h =figure(1)
% clf
% 
% 
% for i = 1:numel(Capability)
%     
%     a=subplot(2,1,1)
%     plot(a,Capability(i).Old_TimeAxis,Capability(i).Old_PumpingCnts,'o','displayname','old cal')
%     grid on
%    hold on
%     
%     
%     a1=subplot(2,1,2)
%     plot(a1,Capability(i).New_TimeAxis,Capability(i).New_PumpingCnts,'s','displayname','new cal')
%     hold on
%     grid on
%     
%     %     ylabel('sim P_BPD_ct_IFMPumping (batch max)','Interpreter','none')
%     %
%     %     h1 = subplot(2,1,2)
%     %     hold on
%     %     histogram(Capability(i).Old_PumpingCnts,'Normalization','probability','DisplayName',sprintf('old cal (n = %d)',length(Capability(i).Old_PumpingCnts)))
%     %     histogram(Capability(i).New_PumpingCnts,'Normalization','probability','DisplayName',sprintf('new cal (n = %d)',length(Capability(i).New_PumpingCnts)))
%     %     legend show
%     %     grid on
%     %     ylabel('density (%)')
%     
% end
% 
% plot(a,xticks,21*ones(1,numel(xticks)),'r--')
% plot(a1,xticks,21*ones(1,numel(xticks)),'r--')
% legend(a1,{Capability(:).Name,'Threshold'},'Interpreter','none')
% title(a,'BPD error counter without step 3 fix')
% legend(a,{Capability(:).Name,'Threshold'},'Interpreter','none')
% title(a1,'BPD error counter with step 3 fix')
% ylabel(a1,'Error Counter')
% ylabel(a,'Error Counter')
% % toc
% % 
%% plot AFS
figure(2)
clf

colorOrder = get(gca,'ColorOrder');
for i = 3:numel(Capability)
    
    iupr_old(i) = sum(~isnan(Capability(i).TimetoDec))/size(Capability(i).KeyCycles,1);
    iupr_new(i) = sum(Capability(i).New_Mot > Capability(i).TimetoDec)/size(Capability(i).KeyCycles,1);
    
    
    
    %     a1 = subplot(2,2,1:2)
    %     b = bar(a1,[Capability(i).Old_Mot,Capability(i) .TimetoDec,Capability(i).New_Mot]);
    %     legend({'motoring time - old cal','motoring time until FED decision - old cal','motoring time - new cal'})
    %     grid on
    %     set(gca,'XTickLabel',datestr(iupr_startTime))
    %     set(gca,'XTick',get(b(1),'XData'))
    %     set(gca,'XTickLabel',iupr_keyCycle)
    %     xlabel('OBD Key Cycle')
    %     ylabel('motoring time (s)')
    %
    %     for j = 1:3
    %         b(j).FaceColor = colorOrder(j,:);
    %     end
    
    %     subplot(2,2,3)
    %     hold on
    %
    %     n = length(iupr_oldCalMotTime);
    %     g = cat(1,repmat({'old cal'},n,1),repmat({'FED decision'},n,1),repmat({'new cal'},n,1));
    %     boxplot([iupr_oldCalMotTime;iupr_MotTimeToFedDec;iupr_newCalMotTime],g,...
    %         'Orientation','horizontal','ColorGroup',{'old cal','FED decision','new cal'},'Colors',colorOrder,'BoxStyle','filled')
    %     grid on
    %     xlabel('motoring time (s)')
    %
    
    a = bar([size(Capability(i).KeyCycles,1),sum(~isnan(Capability(i).TimetoDec)),sum(Capability(i).New_Mot > Capability(i).TimetoDec)])
    set(gca,'XTickLabel',{'Total Key Cycles','Key cycles w/ FED decisions - old cal','Key cycles w/ sufficient mot. time for FED - new cal'})
    grid on
    h = suptitle(Capability(i).Name);
    h.Interpreter = 'none';
    for l = 1:numel(a.XData)
        xtips1 = a.XData(l);
        ytips1 =  a.YData(l);
        labels1 = string(a.YData(l));
        text(xtips1,ytips1,{labels1},'HorizontalAlignment','center',...
            'VerticalAlignment','bottom')
    end
    pause
    savefig(strcat('IUPR-',Capability(i).Name))
    close(gcf)
    
end 


subplot(2,1,1)
b = bar([iupr_old])
grid on
set(gca,'XTickLabel',{Capability.Name})
set(gca,'TickLabelInterpreter','none')
xlabel('Field Test Trucks')
ylabel('IUPR Estimate')
title('Base V2b calibration')

   for l = 1:numel(b.XData)
        xtips1 = b.XData(l);
        ytips1 =  b.YData(l);
        labels1 = string(b.YData(l));
        text(xtips1,ytips1,{labels1},'HorizontalAlignment','center',...
            'VerticalAlignment','bottom')
    end

subplot(2,1,2)
b1 = bar([iupr_new]);
grid on
set(gca,'XTickLabel',{Capability.Name})
set(gca,'TickLabelInterpreter','none')
xlabel('Field Test Trucks')
ylabel('IUPR Estimate')
title('Step3 V2b calibration')
suptitle('IUPR Estimates, From Jan 1st to April 30th')

   for l = 1:numel(b1.XData)
        xtips1 = b1.XData(l);
        ytips1 =  b1.YData(l);
        labels1 = string(b1.YData(l));
        text(xtips1,ytips1,{labels1},'HorizontalAlignment','center',...
            'VerticalAlignment','bottom')
   end
    
savefig('All Truck IUPR')
close(gcf)
