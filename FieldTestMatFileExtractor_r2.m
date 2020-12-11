%% FED Field test data processing script 
clc;clear all

%Get Path to folders 
MainDir = {'C:\Users\pb875\Desktop\RandomDesktopStuff\CDAT\Chrysler\Temp Data'};
Subdir = dir(MainDir{:});
Subdir = Subdir(contains({Subdir.name},{'VSO'}));

%Provide date range to filter data files 
d1 = '2020-5-1 6:00:00';
d2 = '2020-5-12 6:00:00';
t = datetime(d1,'InputFormat','yyyy-MM-dd HH:mm:ss')
t1 = datetime(d2,'InputFormat','yyyy-MM-dd HH:mm:ss')
tstart = t;
tend = t1;
CleanDate1 = datenum(t);
CleanDate2 = datenum(t1);

%Determine what parameters to extract from files, based on external list 
addpath('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts')
Params = ReadParams('C:\Users\pb875\OneDrive - Cummins\Programs\Scripts\UsefulOverlays_FiltFiles\FieldTest_Parameters_Chrysler.txt');
cnt = 1;


%This can be used as an override , if there is a particular truck to
%process. ( instead of all directories)
SpecificTrucks = {'T5683'};

%Loop through subfolders and process data files 
for j = 1:numel(Subdir)
    
  
    Truckfolders = dir(strcat(Subdir(j).folder,'\',Subdir(j).name,'\T*'));
    Truckfolders = Truckfolders(contains({Truckfolders.name},SpecificTrucks));
    
    for k = 1:numel(Truckfolders)
        cd('C:\Users\pb875\Documents\GitHub\Scripts')
        DataDir = strcat(strcat(Truckfolders(k).folder,'\',Truckfolders(k).name,'\Matfiles')); %% Where the matfiles are saved
        SaveDir = strcat(Truckfolders(k).folder,'\',Truckfolders(k).name); %%Location to save plots and workspace
        FieldTestMatExtractor_r3(DataDir,SaveDir,CleanDate1,CleanDate2,Params,tstart,tend);
        cnt =cnt+1;
        
    end
end

