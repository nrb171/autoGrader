% prepareForReturn.m
% This script prepares student submissions for upload into Canvas by creating a zip file for each submission.
% It takes the graded submission directory and output directory as inputs.

% Inputs:
%   submissionDirectory - The directory containing graded student submissions
%   outDirectory - The directory where the graded submissions will be stored
%
% Example usage:
%   submissionDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/exercise1/StudentSubmissions/";
%   outDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/exercise1/GradedSubmissions/";
%   prepareForReturn(submissionDirectory, outDirectory);
%
% Author: Nicholas Barron
submissionDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/midterm/StudentSubmissions/";
outDirectory = "/rita/s0/nrb171/teaching/meteo273/SP24/midterm/GradedSubmissions/";

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
