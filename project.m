pwd;
[file,path]=uigetfile({'*.jpg';'*.png';'*.jpeg';'*.jfif';'*.tif'},'File Selector');
name=[path,file];

rotI = imread(name);  %read the image
% imshow(rotI);

rotI=rgb2gray(rotI);    %converts to gray scale image

BW = edge(rotI,'sobel');    %edge detection using sobel method
%imshow(BW);

[H,theta,rho] = hough(BW);  %hough transform of the image

% tansform graph
% figure
% imshow(imadjust(rescale(H)),[],...
%        'XData',theta,...
%        'YData',rho,...
%        'InitialMagnification','fit');
% xlabel('\theta (degrees)')
% ylabel('\rho')
% axis on
% axis normal 
% hold on
% colormap(gca,hot)

P = houghpeaks(H,50,'threshold',0);
x = theta(P(:,2));
y = rho(P(:,1));

% plot(x,y,'s','color','white');

lines = houghlines(BW,theta,rho,P,'FillGap',1,'MinLength',20);

T = struct2table(lines);    %convert the struct array to a table
Z=table2array(T);
lines1 = sortrows(Z,2);  %sortedT

figure, imshow(rotI), hold on   %form to fill

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    m=lines1(k,1);
    n=lines1(k,2)-17;
    prompt='enter input------>';
    name=input(prompt,'s');
    rotI=insertText(rotI,[m n],name,'BoxColor','white');
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
%    plot(lines(:,1),lines(:,2),'LineWidth',2,'Color','green');

%    Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end

imshow(rotI);
end

% highlight the longest line segment
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

imwrite(rotI,'formoutput.jpeg');