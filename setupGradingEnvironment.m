%Create the folders based off the files in the assignments folder

%unzip all of the files in the assignments folder

assignmentNum = 5;

%find the files in the submission folder
files = dir("./assignment" + assignmentNum + "/submissions/");
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
    if isfolder("./assignment" + assignmentNum + "/submissions/" + name) == 0
        mkdir("assignment" + assignmentNum + "/submissions/" + name);
    end

    % ---------------------------- unzip the file ---------------------------- %
    if contains(char(file), ".zip")
        %unzip the file
        unzip("./assignment" + assignmentNum + "/submissions/" + file, "./assignment" + assignmentNum + "/submissions/" + name);
        %delete the zip file
        delete("./assignment" + assignmentNum + "/submissions/" + file);
    elseif contains(char(file), ".m")
        %move the file to the folder
        movefile("./assignment" + assignmentNum + "/submissions/" + file, "./assignment" + assignmentNum + "/submissions/" + name);
        delete("./assignment" + assignmentNum + "/submissions/" + file);
    end
end