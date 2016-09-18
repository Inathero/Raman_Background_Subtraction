function [AverageSpectrum, AverageSpectrumSubs, XRange] = Raman_ProcessAverageSpectrum( spcFileName, lowerCutOff)
 
% Load SPC File
    file = tgspcread(spcFileName);
% Obtain Spectrum Average
    AverageSpectrum = mean(file.Y,2);
% Prune Spectrum and X-Range
    AverageSpectrum = AverageSpectrum(lowerCutOff:end,1);
    XRange = file.X(lowerCutOff:end,1);
% Obtain lower envelope
    [~,ylower] = envelope(AverageSpectrum);
% Subtract Average from lower envelop
    AverageSpectrumSubs = AverageSpectrum - ylower;
    
end

