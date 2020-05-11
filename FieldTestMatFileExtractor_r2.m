%% FED Field test data processing script 
clc;clear all

MainDir = {'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Asymmetric'};
Subdir = dir(MainDir{:});
Subdir = Subdir(contains({Subdir.name},{'Thunderbolt'}));


d1 = '2020-5-7 6:00:00';
d2 = '2020-5-12 6:00:00';
t = datetime(d1,'InputFormat','yyyy-MM-dd HH:mm:ss')
t1 = datetime(d2,'InputFormat','yyyy-MM-dd HH:mm:ss')
tstart = t;
tend = t1;
CleanDate1 = datenum(t);
CleanDate2 = datenum(t1);
addpath('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts')
Params = ReadParams('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts\UsefulOverlays_FiltFiles\FieldTest_Parameters_Chrysler.txt');
cnt = 1;


% To run just one truck folder, use this override and edit lines 31,32 and
% evaluate lines 31-36 only
TruckfolderOverride = 'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Temp Data\VHO\T1295';

for j = 1:numel(Subdir)
    
    %     Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
    Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
    
    for k = 1:numel(Truckfolders)
        cd('C:\Users\pb875\Documents\GitHub\Scripts')
        %Override folder structure
                DataDir = strcat(strcat(TruckfolderOverride,'\Matfiles')); %% Where the matfiles are saved
                SaveDir = strcat(TruckfolderOverride); %%Location to save plots and workspace
%         DataDir = strcat(strcat(Truckfolders(k).folder,'\',Truckfolders(k).name,'\Matfiles')); %% Where the matfiles are saved
%         SaveDir = strcat(Truckfolders(k).folder,'\',Truckfolders(k).name); %%Location to save plots and workspace
        FieldTestMatExtractor_r3(DataDir,SaveDir,CleanDate1,CleanDate2,Params,tstart,tend);
        cnt =cnt+1;
        
    end
end

