clc;
clear;
close all;

% Allow the user to choose any image
%function UploadButtonPushed(app,event);

%end
%[file,path] = uigetfile({'*.jpg;*.png;*.jpeg'});

%img = imread(fullfile(path,file));
img = imread("good_images/product1.jpg")

imshow(img);
title('Original Image');

% Convert the image to Grayscale

  gray = rgb2gray(img);

  figure;
  imshow(gray);
  title('Grayscale Image');

  filtered = medfilt2(gray);

  figure
  imshow(filtered)
  title('Filtered Image')

%  Detect Edges forGood Images

  edges = edge(gray, 'Canny');
 
  figure;
  imshow(edges);
  imwrite(edges,'results/edge_result.jpg');
  title('Edge Detection');



% For Defective Images

edges = edge(gray, 'Canny');
stats = regionprops(edges,'BoundingBox','Area');

figure;

imshow(img)

hold on

for k = 1:length(stats)

    if stats(k).Area > 50

        rectangle(...
            'Position',stats(k).BoundingBox,...
            'EdgeColor','red',...
            'LineWidth',2);

    end

end

title('Detected Defect')


%.....................................
%imshow(edges);
%img = imread('defective_images/How to Repair a Broken Laptop Screen!.jpg');
%title('Edge Detection');
%...................................

%CLASSIFICATION

  numEdges = sum(edges(:));
  
  disp(['Number of edge pixels: ', num2str(numEdges)]);
 
  %set a threshold for the number of edge pixels; 
 
 threshold = 8000;
 
 %if numEdges > threshold

 if numEdges > threshold

     result = "BAD PRODUCT";
     %   disp('DEFECTIVE PRODUCT');

 else

     result = "GOOD PRODUCT";
     %    disp('GOOD PRODUCT');

 end

%Display it nicely
disp(result);

% Display it on the image
text(20,40,result,...
    'Color','blue',...
    'FontSize',18,...
    'FontWeight','bold');

% More Measurements