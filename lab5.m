%% CMPUT 307 Lab 5
%% Group 8
%% Shuyun Xiong 1392041
%% Michael Xi
clc;
clear all; 
close all;
% 1. Read the given video
filename='cube.mp4';
cubeVid = VideoReader(filename);
nframes = cubeVid.NumberOfFrames;  %for using afterwards
% 2. Read single frame
singleFrame = read(cubeVid, 1);
figure, imshow(singleFrame); title('Single frame: First frame');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 3. Convert the frame into 'double'
frameDoubleData = double(singleFrame);

% 4. Separate the read channel and display the 20th frame.
frame20 = read(cubeVid,20);
figure, imshow(frame20); title('Frame 20');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;
frame20red = frame20(:,:,1); % get red channel
figure, imshow(frame20red); title('red channel');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 5. Get blue channel for frame 20 and invert it.
frame20blue = frame20(:,:,3); % Blue channel
invertBlueFrame20 = 255 - frame20blue;
figure, imshow(invertBlueFrame20); title('Invert Blue Channel');
imwrite(invertBlueFrame20, 'im1.jpg');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 6. Multiply the red channel and the inverted blue channel.
multi = (double(frame20red) .* double(invertBlueFrame20)) ./ 400;
multiImg = uint8(multi);
imwrite(multiImg, 'im2.jpg');
figure, imshow(multiImg); title('Multiplied Image');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 7. Highlight the red object.
highlightImg = im2bw(multiImg, 0.3);
figure, imshow(highlightImg); title('Highlight Red Object');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 8. Obtain the centroid of the red object.
[x,y] = find (highlightImg) ;
CenterOfMassXY = [mean(x) mean(y)] ;
CenterOfMassXY = round(CenterOfMassXY);
frame20(CenterOfMassXY(1),CenterOfMassXY(2),1) = 0;
frame20(CenterOfMassXY(1),CenterOfMassXY(2),2) = 0;
frame20(CenterOfMassXY(1),CenterOfMassXY(2),3) = 255;
figure, imshow(frame20); title('Centroid of Red Object.');
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;







% redCubeValue = 50;
% redCube = rgb2gray(read(cubeVid,71));
% noDarkCar = imextendedmax(redCube, redCubeValue);
% imshow(redCube)
% figure, imshow(redCube)
% 
% sedisk = strel('disk',2);
% noSmallStructures = imopen(noDarkCar, sedisk);
% imshow(noSmallStructures)
% 
% nframes = cubeVid.NumberOfFrames;
% I = read(cubeVid, 1);
% taggedCars = zeros([size(I,1) size(I,2) 3 nframes], class(I));
% 
% for k = 1 : nframes
%     singleFrame = read(cubeVid, k);
% 
%     % Convert to grayscale to do morphological processing.
%     I = rgb2gray(singleFrame);
% 
%     % Remove dark cars.
%     noDarkCars = imextendedmax(I, redCubeValue);
% 
%     % Remove lane markings and other non-disk shaped structures.
%     noSmallStructures = imopen(noDarkCars, sedisk);
% 
%     % Remove small structures.
%     noSmallStructures = bwareaopen(noSmallStructures, 150);
% 
%     % Get the area and centroid of each remaining object in the frame. The
%     % object with the largest area is the light-colored car.  Create a copy
%     % of the original frame and tag the car by changing the centroid pixel
%     % value to red.
%     taggedCars(:,:,:,k) = singleFrame;
% 
%     stats = regionprops(noSmallStructures, {'Centroid','Area'});
%     if ~isempty([stats.Area])
%         areaArray = [stats.Area];
%         [junk,idx] = max(areaArray);
%         c = stats(idx).Centroid;
%         c = floor(fliplr(c));
%         width = 2;
%         row = c(1)-width:c(1)+width;
%         col = c(2)-width:c(2)+width;
%         taggedCars(row,col,1,k) = 255;
%         taggedCars(row,col,2,k) = 0;
%         taggedCars(row,col,3,k) = 0;
%     end
% end
% 
% frameRate = cubeVid.FrameRate;
% implay(taggedCars,frameRate);
