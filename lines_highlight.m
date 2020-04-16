pwd;
[file,path]=uigetfile({'*.jpg';'*.png';'*.jpeg';'*.jfif';'*.tif'},'File Selector');
name=[path,file];
rotI = imread(name); 
rotI=rgb2gray(rotI);
BW = edge(rotI,'sobel');
imshow(BW);
[H,theta,rho] = hough(BW);
figure
imshow(imadjust(rescale(H)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)

P = houghpeaks(H,50,'threshold',0);
x = theta(P(:,2));
y = rho(P(:,1));
lines = houghlines(BW,theta,rho,P,'FillGap',1,'MinLength',20);
figure, imshow(rotI), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];    
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

