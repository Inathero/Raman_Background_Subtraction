function [AverageSpectrum, AverageSpectrumSubs, XRange] = Raman_ProcessAverageSpectrum( spcFileName, lowerCutOff, iMethod)
 
% Load SPC File
    file = tgspcread(spcFileName);
% Obtain Spectrum Average
    AverageSpectrum = double(mean(file.Y,2));
% Prune Spectrum and X-Range
    AverageSpectrum = AverageSpectrum(lowerCutOff:end,1);
    XRange = file.X(lowerCutOff:end,1);
if strcmp(iMethod,'envelope')
% Obtain lower envelope
    [~,ylower] = envelope(AverageSpectrum);
% Subtract Average from lower envelop
    AverageSpectrumSubs = AverageSpectrum - ylower;
else
    invertSpectrum = AverageSpectrum * -1;
    invertSpectrum = invertSpectrum - min(invertSpectrum);
    [~,loc] = findpeaks(invertSpectrum, 'MinPeakWidth', 4);
    loc = [1; loc];
    loc(end+1) = length(AverageSpectrum);
    splineRange = 1:length(AverageSpectrum);
    if strcmp(iMethod, 'lerp')
        ySpline = interp1q(loc,AverageSpectrum(loc),splineRange');
        figure; hold;
        plot(AverageSpectrum);
        plot(ySpline);
        scatter(loc, AverageSpectrum(loc));
        hold;
        figure;
        plot(AverageSpectrum - ySpline);
        AverageSpectrumSubs = AverageSpectrum - ySpline;
    title('lerp');
    elseif strcmp(iMethod, 'spline')
        ySpline = spline(loc,AverageSpectrum(loc),splineRange)';
        figure; 
        hold;
        plot(AverageSpectrum);
        plot(ySpline);
        scatter(loc, AverageSpectrum(loc));
        hold;
        figure;
        plot(AverageSpectrum - ySpline);
        AverageSpectrumSubs = AverageSpectrum - ySpline;
    title('spline');
    elseif strcmp(iMethod, 'polyfit')    
        ySpline = [];
        for i = 1:2:length(loc)
            if i+2 > length(loc)
            ySplinea = polyfit(loc(i:length(loc)),AverageSpectrum(loc(i:length(loc))),1);
            ySpline = [ySpline  polyval(ySplinea,loc(i):loc(end))];
            else
            ySplinea = polyfit(loc(i:i+2),AverageSpectrum(loc(i:i+2)),2);
            ySpline = [ySpline  polyval(ySplinea,loc(i):loc(i+2))];
            end
        end
        figure; hold;
        plot(AverageSpectrum);
        plot(ySpline);
    scatter(loc, AverageSpectrum(loc));
    hold;
    figure;
    plot(AverageSpectrum - ySpline(1:length(AverageSpectrum))');
    AverageSpectrumSubs = AverageSpectrum - ySpline(1:length(AverageSpectrum))';
    title('PolyFit');
    end
end
end

