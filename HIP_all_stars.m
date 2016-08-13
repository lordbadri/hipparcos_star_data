format long
clc
clear

%Display the number of HIP stars data we can extract
%hip_stars_number = 118209;
hip_stars_number =118322;
hip_name=linspace(1,hip_stars_number,hip_stars_number);
hip_name=hip_name';
%hip_name_f=zeros(hip_stars_number,1);

hip_name_f=(hip_name);
%for i=1:1:hip_stars_number
 %hip_name_f(i)=num2str(hip_name(i));
%end
 
temp_hipstars_number_data = sprintf('The total number of Hipparcos stars data we can extract are %d',hip_stars_number);
disp(temp_hipstars_number_data);

%Renaming the stars as per our need, here to generate the url link with proper string formatting
hip_number_formated = cell(hip_stars_number,1);
for i=1:hip_stars_number
    
 A=hip_name_f(i,1);
 %if i~=672
  B=sprintf('%d',A);
  if length(B) == 1
   C=B;%(1:2);
   D=strcat('000000',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
  
  elseif length(B) == 2
   C=B;%(1:3);
   D=strcat('00000',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
  
  elseif length(B) == 3
   C=B;%(1:4);
   D=strcat('0000',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
  
  elseif length(B) == 4
   C=B;%(1:5);
   D=strcat('000',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
 
  elseif length(B) == 5
   C=B;%(1:6);
   D=strcat('00',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
  
  elseif length(B) == 6
   C=B;%(1:7);
   D=strcat('0',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
 %else
   %  i+1;
 %end
  end
 
 
end

%Generating URLs for collecting the data
%example URL %http://exoplanetarchive.ipac.caltech.edu/data/ExoData/0099/0099894/data/UID_0099894_PLC_001.tbl

url_links = cell(hip_stars_number,1); % intializing cell for saving url links of HIP data
hip_info = cell(hip_stars_number,1); % intialzing cell for saving the HIP data obtained 
missing_star=[];
j=0;
%Logic to creat the url link and extract the HIP photometry data for all HIP stars 
for i=1:hip_stars_number 
   % if i==672 || i==1569
       % i+1
    %else
    try
        i
        temp = sprintf('http://exoplanetarchive.ipac.caltech.edu/data/ExoData/%.4s/%s/data/UID_%s_PLC_001.tbl',char(hip_number_formated(i,1)),char(hip_number_formated(i,1)),char(hip_number_formated(i,1)));
        %disp(temp);
        url_links(i) = cellstr(temp);
        temp1 = urlread(char(url_links(i)));
        hip_info(i) = cellstr(temp1);
        %writing  the files to the Directory
        X = sprintf( 'HIP%s.tbl',char(hip_number_formated(i)));
        dlmwrite(X,hip_info(i),'');
    catch exception
       % j+1;
       % missing_star(j)=i;
    continue
    end
 
end


%Total number of HIP stars, because the data files are same for multiple planetary system 
hip_stars_actual_number = length(dir('*.tbl'));
temp_hipstars_number = sprintf('The total number of Hipparcos stars data actually is %d',hip_stars_actual_number);
disp(temp_hipstars_number);

