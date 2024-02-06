%Create the grading environment based on files in the submittedAssignments folder


assignmentNum = 5;

%find the files in the submission folder
folder = input("Enter the path to the submissions folder: ", 's');
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
        %unzip the file
        unzip(folder + file, folder + name);
        %delete the zip file
        delete(folder + file);
    elseif contains(char(file), ".m")
        %move the file to the folder
        movefile(folder + file, folder + name);
        delete(folder + file);
    end
end
