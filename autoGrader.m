% goes through all children directories and analyzes every line in the file.
% Those that start with "%!" are the beginning of point deductions the number
% within the "()" is the deduction. Add up these
% deductions and return the total for each file. Then write a file with the


rootdir = '/rita/s0/nrb171/teaching/meteo273/SP24/exercise1/StudentSubmissions/';
folderList = dir(fullfile(rootdir, '**/*.*'));  %get list of files and folders in any subfolder
folderList = {folderList.folder}
%convert folderlist into string array
folderList = string(folderList);
folderList = unique(folderList); %remove duplicates
folderList = folderList(2:end); %remove . and ..

%loop through all folders
for folder = folderList
    gradeFiles(folder+"/", rootdir);
end



% This is the main function that calls the other functions
function [] = gradeFiles(pwd, rootdir)
    % Get the list of all files in the current directory
    cd (pwd);

    files = dir;
    % Get the number of files in the current directory
    numFiles = length(files);
    % Initialize the total
    total = NaN;
    total2 = [];
    % Loop through all the files in the current directory
    for i = 1:numFiles
        % Get the name of the file
        fileName = files(i).name;
        % Get the extension of the file
        [pathstr, name, ext] = fileparts(fileName);
        % If the file is a .m file
        if strcmp(ext, '.m')
            % Get the total for the file
            total = nansum([total,gradeFile(fileName)]);
            total2=[total2,gradeFile(fileName)];
        end
    end

    % Write the total to a file
    if total <= 0
        name=strsplit(pwd,"/");
        name=name(end-1);
        disp(name+", "+ string(100+total)+", "+strjoin(string(total2) + ", , "))
        writeTotal(string(100+round(total,2)));
    end

    cd (rootdir);

end


% This function gets the total for a file
function [total] = gradeFile(fileName)
    % Open the file
    file = fopen(fileName);
    % Initialize the total
    total = 0;
    % Loop through all the lines in the file
    while ~feof(file)
        % Get the next line
        line = fgetl(file);
        % If the line contains a %!
        if strfind(line, '%!')
            % Get the number in the parentheses
            num = getNum(line);
            % Add the number to the total
            total = total + num;
        end
    end
    %disp(fileName+", "+ string(total))
    % Close the file
    fclose(file);
end

% This function gets the number in the parentheses
function [num] = getNum(line)
    % Get the index of the first parenthesis
    index = strfind(line, '(');
    % Get the index of the second parenthesis
    index2 = strfind(line, ')');

    if isempty(index) || isempty(index2) 
        fprintf(line)
        warning("No parenthesis found")
        num = 0;
        return
    end
    % Get the number in the parentheses
    num = str2num(line(index+1:index2-1));
end

% This function writes the total to a file
function [] = writeTotal(total)
    % Open the file
    file = fopen("total.txt", 'w');
    % Write the total to the file
    fprintf(file, total);
    % Close the file
    fclose(file);
end
