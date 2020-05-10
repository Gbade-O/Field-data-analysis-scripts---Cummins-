%% FED Field test data processing script 
clc;clear all

MainDir = {'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric'};
Subdir = dir(MainDir{:});
Subdir = Subdir(contains({Subdir.name},{'VHO','VSO'}));


d1 = '2020-5-4 6:00:00';
d2 = '2020-5-7 6:00:00';
t = datetime(d1,'InputFormat','yyyy-MM-dd HH:mm:ss')
t1 = datetime(d2,'InputFormat','yyyy-MM-dd HH:mm:ss')
tstart = t;
tend = t1;
CleanDate1 = datenum(t);
CleanDate2 = datenum(t1);
TruckfolderOverride = 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Temp Data\Thunderbolt\T4066';
Params = ReadParams('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts\UsefulOverlays_FiltFiles\FieldTest_Parameters_Chrysler.txt');
cnt = 1;
for j = 1:numel(Subdir)
    
%     Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
      Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
    
    for k = 1:numel(Truckfolders)
        cd('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts')
        DataDir = strcat(strcat(TruckfolderOverride,'\Matfiles')); %% Where the matfiles are saved
        SaveDir = strcat(TruckfolderOverride); %%Location to save plots and workspace
        FieldTestMatExtractor_r3(DataDir,SaveDir,CleanDate1,CleanDate2,Params,tstart,tend);
        cnt =cnt+1;
        
    end
end

       

   %%CRINL
        % C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\CRINL\T1017_DJ22_KG551017_59082725
        %'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\CRINL\T1503'
        
        % Symmetric
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\VSO\T6143'
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\VSO\T7487'
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\VHO\T6211',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\VHO\T9761',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\VHO\T2195'
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Symmetric\Thunderbolt\T2151'
        
        %Kestrel Line up
        %'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VSO\T3269'
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\Thunderbolt\T2170',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\Thunderbolt\T4046',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VSO\T1078_DJ21_LG101078_59347746',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VSO\T1503',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VSO\T7761',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VHO\T9724',
        % 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Kestrel\VHO\T9755'};
       
      
      
 
 
 
% %%  subplot(313)
% %  plot(
% %  
% 
%  
%  
%         
% %     figure(2)
% %     subplot(2,3,i)
% %     histogram(Cyl(unique_idx))
% %     info = fitdist(Cyl(unique_idx).','Normal');
% %     text(5,4500,strcat('Mean:', int2str(info.mu)))
% %     hold on
% %     text(5,4250,strcat('Std dev:', int2str(info.sigma)))
% %     xlim([ -10 15])
% %     ylim([0 7000])
% %     title(sprintf('Cylinder %d',i))
% % %     plot(time_10s,Cyl,strcat(Color_Vec(i),'o'))
% % %     hold on
% % %    
% % end
% 
% legend('Cyl1','Cyl2','Cyl3','Cyl4','Cyl5','Cyl6')
% hold off
%     title(sprintf('T9724, from %s to %s',MAT(1).date,MAT(end).date))
%     
% ind = find(ValidDrop == 1);
% % figure(2)
% % plot(Coolant(ind),Leakage(ind),'o')
% cnt =1;
% for i = 2:length(Residual)-1
%     if(Residual(i) ~= Residual(i-1))
%         ind(cnt) = i;
%         cnt =cnt+1;
%     end
% end
% plot(Coolant(ind),Residual(ind),'o')
% 
% plot(Residual(ind),Leakage(ind),'o')
%             
%             
%                             
%                     
%  plot(time_1s,Pumping,'ko')
%  hold on
%  plot(time_1s,Cycle)
%  ylim([0 25])
%  xlabel('ECM Run Time')
%  ylabel('FED decisions with pumping')
%  title(sprintf('Data from %s to %s',MAT(1).date, MAT(end).date))
%  legend('P BPD Ct IFMPumping','P BPD ct IFMTotalCycle')
%                     
%                     
%  motoring_ind = find( Total_fueling == 0)  ;
%  plot(time_200s(motoring_ind),Cmd(motoring_ind))
%  hold on
%  plot(time_200s(motoring_ind),Fdbk(motoring_ind))
%  legend('Cmd','Fdbk')
%                     
%                     
% 
%  plot(time(ind),Engine_Speed(ind))
%  ylabel('Engine Speed')
%  hold on
%  yyaxis right
%  plot(time(ind),Residual(ind),'o')
%  ylabel('Residuals')
%  xlabel('time')
%  ylim([ 0 100])
%  legend('Engine Speed','Residuals')
%  
%                     
%                                        
%                     
%                     
%                     
%                     
%                     
%                     
%                     
%                     
%                     
%                     
%                     
% %                     
% %                 m = matfile( strcat(MAT(j).folder,'\',MAT(j).name));
% %                 for k = 1: 6
% %                 try
% %                     if(strcmp(folder,MAT(j).folder)==0)
% %                         cd(MAT(j).folder);
% %                         folder = MAT(j).folder;
% %                     end
% %                     
% 
%     
%    
% %     Count = 1;
% %     FED_MAT = CylData(:,:,i);
% %     ind = find( cellfun('isempty',FED_MAT(1,:)) == 1);
% %     FED_MAT(:,ind) = [];
% % 
% %      
% %         
% %    for n = 1:6
% %     
% %         FED{n,1} = transpose(cat(1,FED_MAT{n,:}));
% %         for m = 1:numel(FED{n,1})-1
% %             if(FED{n,1}(m+1) == FED{n,1}(m))
% %                 Filt(m) = 0;
% %             else
% %                 Filt(m) = 1;
% %             end
% %         end
% %         
% %         ind = find( Filt == 1) + 1;
% %         Data = FED{n,1}(ind);
% %         Decision = find( Data <= -6);
% %         if( Decision > 4)
% %             for p = 1:numel(Data)-2
% %                 if((Data(p)<=-6) && (Data(p+2) <= -6))
% %                     Count = Count +1;
% %                 end
% %             end
% %         else
% %             %%fprintf('Not enough failed points on Cylinder %d, Truck %s\n',n,S(i).folder);
% %         end
% %         Cylinder(n).MIL = Count -1;
% %         
% %    end
% %             
% %     Truck(i).CylData = Cylinder;
% %     Truck(i).Name = TrucksDir{i}(76:86)
% %    
% %     Count = 1;
% %    end
% % 
% %             
% %             
% %             
% %    
% %             
