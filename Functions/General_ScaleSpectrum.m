function [ outSpectrumOne, outSpectrumTwo ] = General_ScaleSpectrum( inSpectrumOne, inSpectrumTwo )

    outSpectrumOne = inSpectrumOne .* max(inSpectrumTwo)/max(inSpectrumOne);
    outSpectrumTwo = inSpectrumTwo .* max(inSpectrumOne)/max(inSpectrumTwo);
    
end


