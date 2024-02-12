% setupGradingEnvironment.m
%
% This script sets up the grading environment by performing the following steps:
% 1. Prompts the user to enter the path to the submissions folder.
% 2. Iterates through the files in the submissions folder.
% 3. Skips files that are not zip or m files.
% 4. Creates a folder for each submission.
% 5. Unzips zip files and moves m files to the respective submission folder.
% 6. Checks for subfolders within the submissions folder.
% 7. Moves any m files found in subfolders to the respective subfolder within the submissions folder.
% The studentSubmissions folder should be organized as follows:
% studentSubmissions
% ??? student1.zip 
% or
% ??? student2/studentFiles*.m

folder = '/rita/s0/nrb171/teaching/meteo273/SP24/exercise2/StudentSubmissions/'
folder = string(folder);

files = dir(folder);
files = string({files.name});
for file = files
    if file == "." || file == ".."
        continue
    end
    % ---------------- skip if the file is not a zip or m file --------------- %
    if contains(char(file), ".zip") == 0 && contains(char(file), ".m") == 0
        continue
    end

    % --------------------------- create the folder -------------------------- %
    name = char(file);
    indx = find(name == '_');
    name = name(1:indx(1)-1);
    if isfolder(folder + name) == 0
        mkdir(folder + name);
    end

    % ---------------------------- unzip the file ---------------------------- %
    if contains(char(file), ".zip")
        try
            %unzip the file
            unzip(folder + file, folder + name);
            %delete the zip file
            delete(folder + file);
        catch
            disp("Error unzipping " + file);
        end
    elseif contains(char(file), ".m")
        %move the file to the folder
        movefile(folder + file, folder + name);
        delete(folder + file);
    end                                                   
end

%% Check for subsubfolders 
subfolders = dir(folder);
subfolders = string({subfolders.name});
for subfolder = subfolders
    if subfolder == "." || subfolder == ".." || subfolder == ".DS_Store"
        continue
    end
    subfiles = dir(folder + subfolder+"/**/*.m*");
    for ii = 1:length(subfiles)
        if subfiles(ii).folder == folder + subfolder
            continue
        end
        movefile(subfiles(ii).folder + "/" + subfiles(ii).name, folder + subfolder);
    end

end
    
    