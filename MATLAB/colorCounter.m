clear ;
close all;
clc;


filename = 'all.jpg';     % File name or location
original = imread(filename);% Read the RGB image
% original = imcomplement(original);
img = rgb2hsv(original);    % Convert the iamge to HSV color map
hue = round(img(:,:,1)*360);% Scale the range of the hue from [0,1] to [0:360]
value = round(img(:,:,3)*360);% Scale the range of the value from [0,1] to [0:360]
[x,y] = size(hue);          % Get the image dimensions
len = 1:y;                  % Image length

r_limit = [12,321];     % Red range
o_limit = [13, 32];     % Orange range
y_limit = [33, 64];     % Yellow range
g_limit = [65, 150];    % Green range
c_limit = [151, 200];   % Cyan range
b_limit = [201, 260];   % Blue range
pu_limit = [261, 290];  % Purple range
p_limit = [291, 320];   % Pink range


% Initialize counter for each color
Red = zeros(1,y);
Orange = zeros(1,y);
Yellow = zeros(1,y);
Green = zeros(1,y);
Cyan = zeros(1,y);
Blue = zeros(1,y);
Purple = zeros(1,y);
Pink = zeros(1,y);
White = zeros(1,y);
Black = zeros(1,y);

c_list = {'Red', 'Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Purple',...
    'Pink', 'White', 'Black'};

for i = 1:x
    for j = 1:y
        
        % If red
        if (hue(i,j) >= r_limit(2) || hue(i,j) <= r_limit(1) && hue(i,j) ~= 0 )
            Red(1,j) = Red(1,j) +1;
        end
        % If orange
        if (hue(i,j) >= o_limit(1) && hue(i,j) <= o_limit(2) )
            Orange(1,j) = Orange(1,j) +1;
        end
        % If yellow
        if (hue(i,j) >= y_limit(1) && hue(i,j) <= y_limit(2) )
            Yellow(1,j) = Yellow(1,j) +1;
        end
        % If green
        if (hue(i,j) >= g_limit(1) && hue(i,j) <= g_limit(2) )
            Green(1,j) = Green(1,j) +1;
        end    
        % If cyan
        if (hue(i,j) >= c_limit(1) && hue(i,j) <= c_limit(2) )
            Cyan(1,j) = Cyan(1,j) +1;
        end              
        % If cyan
        if (hue(i,j) >= c_limit(1) && hue(i,j) <= c_limit(2) )
            Cyan(1,j) = Cyan(1,j) +1;
        end
        % If blue
        if (hue(i,j) >= b_limit(1) && hue(i,j) <= b_limit(2) )
            Blue(1,j) = Blue(1,j) +1;
        end
        % If purple
        if (hue(i,j) >= pu_limit(1) && hue(i,j) <= pu_limit(2) )
            Purple(1,j) = Purple(1,j) +1;
        end  
        % If pink
        if (hue(i,j) >= p_limit(1) && hue(i,j) <= p_limit(2) )
            Pink(1,j) = Pink(1,j) +1;
        end
    end
end


% Store the ratio of each color to the total number of pixels
color_ratio = [(sum(Red)/numel(hue)), (sum(Orange)/numel(hue)), ...
    (sum(Yellow)/numel(hue)), (sum(Green)/numel(hue)), ...
    (sum(Cyan)/numel(hue)), (sum(Blue)/numel(hue)), ...
    (sum(Purple)/numel(hue)), (sum(Pink)/numel(hue)), ...
    (sum(White)/numel(hue)), (sum(Black)/numel(hue))];

% Find the max value of out array
[val, id] = max(color_ratio);

% Total number of pixels of each color
total = [ sum(Red),sum(Orange),sum(Yellow),sum(Green),sum(Cyan),...
sum(Blue),sum(Purple),sum(Pink), sum(White), sum(Black)];

% Combain the counters 
counters = [Red,Orange,Yellow,Green,Cyan,Blue,Purple,Pink,White,Black];

% plot the original image and the number of pixels of each color on each
% raw
figure;
plot(len,Red,'r','LineWidth',1.2);
hold on;
plot(len,Orange,'Color',[230/255, 115/255, 0],'LineWidth',1.2);
plot(len,Yellow,'Color',[255/255, 191/255, 0],'LineWidth',1.2);
plot(len,Green,'Color',[26/255, 194/255, 0],'LineWidth',1.2);
plot(len,Cyan,'Color',[0, 194/255, 171/255],'LineWidth',1.2);
plot(len,Blue,'Color',[31/255, 87/255, 255/255],'LineWidth',1.2);
plot(len,Purple,'Color',[161/255, 0, 230/255],'LineWidth',1.2);
plot(len,Pink,'Color',[230/255, 0, 157/255],'LineWidth',1.2);

grid on;
title('Number Of Pixels Of Eache Color Vs Column', 'FontSize',17);
ylabel('Total Number Of Pixels At That Column', 'FontSize',15);
xlabel('Column Number', 'FontSize',15);
legend('Red','Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Purple', 'Pink',...
    'location', 'bestoutside'); % 'White','Black'
axis([1 (y+1) 0 (max(counters)+10)]);
hold off;

figure;
h(1) = stem(2,sum(Red),'r','LineWidth',40);
hold on;
h(2) = stem(3,sum(Orange),'Color',[230/255, 115/255, 0],'LineWidth',40);
h(3) = stem(4,sum(Yellow),'Color',[255/255, 191/255, 0],'LineWidth',40);
h(4) = stem(5,sum(Green),'Color',[26/255, 194/255, 0],'LineWidth',40);
h(5) = stem(6,sum(Cyan),'Color',[0, 194/255, 171/255],'LineWidth',40);
h(6) = stem(7,sum(Blue),'Color',[31/255, 87/255, 255/255],'LineWidth',40);
h(7) = stem(8,sum(Purple),'Color',[161/255, 0, 230/255],'LineWidth',40);
h(8) = stem(9,sum(Pink),'Color',[230/255, 0, 157/255],'LineWidth',40);

set( h(1),'Marker', 'none');
set( h(2),'Marker', 'none');
set( h(3),'Marker', 'none');
set( h(4),'Marker', 'none');
set( h(5),'Marker', 'none');
set( h(6),'Marker', 'none');
set( h(7),'Marker', 'none');
set( h(8),'Marker', 'none');

title('Histogram', 'FontSize',17);
ylabel('Total Number Of Pixels', 'FontSize',15);
xlabel('Color', 'FontSize',15);
set(gca,'XTick',2:8);
set(gca,'XTickLabel','');
axis([1 10 0 max(total)]);
grid on;
hold off;


% Show the original and the complement Images
figure;
imshow(original);
title('Original Image', 'FontSize',17);


% Display the dominiat color
d = char(c_list(id));
disp(['The dominiat color is : ', d]);
disp(val);
