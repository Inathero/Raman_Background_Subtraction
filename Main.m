close all;
set(0, 'DefaultTextInterpreter', 'none')
path(path, 'Functions')

[NonCancerAverage, NonCancerAverageSubs, NonCXRange] = Raman_ProcessAverageSpectrum('./Scans/Scan_000_Spec.Data 1_F.spc', 85);

[CancerAverage, CancerAverageSubs, CXRange]          = Raman_ProcessAverageSpectrum('./Scans/Scan_005_Spec.Data 1_F.spc', 85);

% Non-Cancer, Average, No Background Subtraction
figure;
plot(NonCXRange, NonCancerAverage);
title('Scan 000 Average Spectrum');
xlabel('Frequency (cm-1)')
ylabel('Raman Intensity (a.u.)')

% Non-Cancer, Average, Background Subtraction
figure;
plot(NonCXRange, NonCancerAverageSubs);
title('Scan 000 Average Spectrum Background Subtracted');
xlabel('Frequency (cm-1)')
ylabel('Raman Intensity (a.u.)')

% Cancer, Average, No Background Subtraction
figure;
plot(CXRange, CancerAverage);
title('Scan 005 Average Spectrum');
xlabel('Frequency (cm-1)')
ylabel('Raman Intensity (a.u.)')

% Cancer, Average, Background Subtraction
figure;
plot(CXRange, CancerAverageSubs);
title('Scan 005 Average Spectrum Background Subtracted');
xlabel('Frequency (cm-1)')
ylabel('Raman Intensity (a.u.)')

CancerAverageScaled = General_ScaleSpectrum(CancerAverageSubs, NonCancerAverageSubs);

% Non-Cancer vs Cancer, Average, Background Subtraction
figure; hold;
plot( NonCancerAverageSubs);
plot( CancerAverageScaled);
title('Scan 000 vs Scan 005 Scaled');
xlabel('Frequency (cm-1)')
ylabel('Raman Intensity (a.u.)')
legend('Non-Cancer', 'Cancer');
