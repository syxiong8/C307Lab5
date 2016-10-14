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

% 8. Obtain the centroid of the red object (Frame 20, marked as blue).
[x,y] = find (highlightImg) ;
centre = round([mean(x) mean(y)]);
figure, imshow(frame20); title('Centroid of Red Object.'); hold on;
plot(centre(2), centre(1), 'b.'); hold off;
fprintf('Program paused. Press enter to continue.\n');
pause;
close all;

% 9. Showing the trajectory of the centroid of the red
allCentreX = [];
allCentreY = [];
for k = 1 : cubeVid.NumberOfFrames
    singleFrame = read(cubeVid, k);
    frameRed = singleFrame(:,:,1);
    frameBlue = singleFrame(:,:,3);
    invertBlue = 255 - frameBlue;
    multiFrame = uint8((double(frameRed) .* double(invertBlue)) ./ 400);
    highlightImg = im2bw(multiFrame, 0.3);
    [x,y] = find (highlightImg) ;
    centre = round([mean(x) mean(y)]);
    allCentreX = [allCentreX centre(2)];
    allCentreY = [allCentreY centre(1)];
%%  test code for each frame check
%     figure, imshow(read(cubeVid, k)); title('Trajectory of the centroid'); hold on;
%     plot(centre(2), centre(1), 'bo');
%     hold off;
%     fprintf('Program paused. Press enter to continue.\n');
%     pause;
end

centroidPlot = figure, imshow(read(cubeVid, 1)); title('Trajectory of the centroid'); hold on;
plot(allCentreX, allCentreY, 'b.');
hold off;
saveas(centroidPlot, 'im3.jpg')

