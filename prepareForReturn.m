submissionDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/exercise1/StudentSubmissions/"
outDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/exercise1/GradedSubmissions/"

if ~isdir(outDirectory)
    mkdir(outDirectory)
end

submissions = dir(submissionDirectory);
submissionName = string({submissions.name});
submissionName = submissionName([submissions.isdir]);

for ii = 1:length(submissionName)
    if submissionName(ii) == "." || submissionName(ii) == ".."
        continue
    end
    zipName = outDirectory + (submissionName(ii));
    folderName = submissionDirectory + (submissionName(ii));
    zip(zipName, folderName)
end
