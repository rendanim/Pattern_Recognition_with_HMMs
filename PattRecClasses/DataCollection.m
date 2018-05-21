clc
clear

%% Collect drawing
clc
clear all;
% Write 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, +, -, *, /, (, )
n_X = 5;

for j=5
    User='Sud';
    clear X;
    X = cell(n_X ,1);
    if(j==10)
        continue;    
    end
    Name = ['./Data/Characters',User,num2str(j),'.mat'];
    disp('New Character');
for i = 1 : n_X
    X(i,1) = {DrawCharacter(10)};
    disp(i);
end
    save(Name, 'X','n_X');
    
end

%% check nosy plots
  
fn = ['./Data/Characters','Huijie',num2str(15),'.mat'];
load(fn);
  %n_X=a.n_X;
for i = 1 : n_X
    
    x_temp  = cell2mat(X(i));
    %figure(i);
    %plot(x_temp(1,:),x_temp(2,:));
    DisplayCharacter(x_temp);
    %AnimateCharacter(x_temp);
    
end

%% Remove Nosy characters

fn = ['./Data/Characters','Huijie',num2str(13),'.mat'];
fnclean= ['./Data/Characters','Huijie',num2str(13),'.mat'];
load(fn);
faux_data = [9]; %C1
for i = faux_data
    X(i) = cell(1);
end
n_X=n_X-1;
save(fnclean, 'X','n_X');

%% Create database for each character
clear all;

Names={'Huijie','Rendani','Sud'};
Numbers=0:15;
for k=0:14
    if(k==10)
        continue;
    end
    
    for l=1:size(Names,2)
        file=['./Data/','Characters',Names{l},num2str(k),'.mat'];
        
     load(file);
     data{l}= X; 
     
    end
  featurefile=['./Database/',num2str(k),'.mat'];  
  save(featurefile, 'data','n_X');
end

