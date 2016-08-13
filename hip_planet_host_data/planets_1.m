format long
clc
clear

%For this code to work the list obtained from the archive must be ordered by HIP numbers
%Getting the Information/File of the confirmed planets from Nasa Exo-planet Archive

Planet_info_1 = urlread('http://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exoplanets&select=pl_hostname,hd_name,hip_name,pl_pnum,pl_letter&order=hip_name&format=csv');

%writing the data to a file and formatting
dlmwrite('Planet_info_1.csv',Planet_info_1,''); %writing the extracted data in csv format
fid=fopen('Planet_info_1.csv');
temp_cell = textscan(Planet_info_1,'%s %s %s %s %s','HeaderLines',1,'Delimiter',',', 'EndOfLine','\n'); %scanning the text file using a specific Delimiter, here its ','
temp_structure = cell2struct(temp_cell,{'pl_hostname','hd_name','hip_name','pl_pnum','pl_letter'},2);  %Converting the extracted cells into a structure and storing the information as required
fclose(fid);

%Extracting HIP numbers from the file and formating it to append naming for the files to be extracted from the exo-planet archive%

hip_name = getfield(temp_structure,'hip_name'); %extracting and storing hip names of the stars
pl_hostname = getfield(temp_structure,'pl_hostname'); %extracting and storing host names of the stars

%Logic to count the number of HIP stars data
for i=1:length(pl_hostname)
    A = hip_name(i,1);
    B = strcmp(A,''); %string comparision very usefull
    if B == 0 
        j=j+1;
    else
        j;
    end
end

%Display the number of HIP stars data we can extract
hip_stars_number = real(j);
temp_hipstars_number_data = sprintf('The total number of Hipparcos stars data we can extract are %d',hip_stars_number);
disp(temp_hipstars_number_data);

%Renaming the stars as per our need, here to generate the url link with proper string formatting
hip_number_formated = cell(hip_stars_number,1);
for i=1:hip_stars_number
    
 A=hip_name(i,1);
 B=char(A);
  if length(B) == 7
  C=B(5:7);
  D=strcat('0000',C);
  E=cellstr(D);
  hip_number_formated(i)=E;
  
 elseif length(B) == 8
  C=B(5:8);
  D=strcat('000',C);
  E=cellstr(D);
  hip_number_formated(i)=E;
  
 elseif length(B) == 9
   C=B(5:9);
   D=strcat('00',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
  
 elseif length(B) == 10
   C=B(5:10);
   D=strcat('0',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
 
  elseif length(B) == 11
   C=B(5:9);
   D=strcat('00',C);
   E=cellstr(D);
   hip_number_formated(i)=E;
      
 end
 
end

%Generating URLs for collecting the data
%example URL %http://exoplanetarchive.ipac.caltech.edu/data/ExoData/0099/0099894/data/UID_0099894_PLC_001.tbl

url_links = cell(hip_stars_number,1); % intializing cell for saving url links of HIP data
hip_info = cell(hip_stars_number,1); % intialzing cell for saving the HIP data obtained 
planet_number = cell(hip_stars_number,1); % intialzing cell for saving the HIP star data for the number of planets in the system


planet_number = getfield(temp_structure,'pl_pnum'); %extracting planet numbers from the intial data


%Logic to creat the url link and extract the HIP photometry data for all HIP stars 
for i=1:hip_stars_number   
 temp = sprintf('http://exoplanetarchive.ipac.caltech.edu/data/ExoData/%.4s/%s/data/UID_%s_PLC_001.tbl',char(hip_number_formated(i,1)),char(hip_number_formated(i,1)),char(hip_number_formated(i,1)));
 %disp(temp);
 url_links(i) = cellstr(temp);
 temp1 = urlread(char(url_links(i)));
 hip_info(i) = cellstr(temp1);
 %writing  the files to the Directory
 X = sprintf( 'HIP%s_%s.tbl',char(hip_number_formated(i)),char(planet_number(i)));
 dlmwrite(X,hip_info(i),'');
end


%Total number of HIP stars, because the data files are same for multiple planetary system 
hip_stars_actual_number = length(dir('*.tbl'));
temp_hipstars_number = sprintf('The total number of Hipparcos stars data actually is %d',hip_stars_actual_number);
disp(temp_hipstars_number);

hip_number_planet = cell(hip_stars_actual_number,1);


















