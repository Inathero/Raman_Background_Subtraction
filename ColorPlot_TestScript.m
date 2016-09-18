file = tgspcread('./Scans/Scan_000_Spec.Data 1_F.spc');
scans = file.Y;
spcMatrix = zeros(100,100,1024);
tCol = 0;

% Reshape matrix
for row=1:100
   for column=1:100
      tCol = tCol + 1;
      spcMatrix(row,column,:) = scans(:,tCol);
   end
end

% Get value at specified wave number
spcColorPlot = zeros(100,100);
for row=1:100
   for column=1:100
       spcColorPlot(row,column) = spcMatrix(row,column,172);
   end
end

imagesc(spcColorPlot);