clear

path = "inputs/object.jpg"

I = imread(path);

% classiification of jpg file.
% Any pixel with an RGB value of less than 200 is considered not to belong to the object.

indices = abs(I)<200;        
I(indices) = NaN;                  

indices = abs(I)>200;
I(indices) = 1;

coor(1) = determine_center(I,1);    % determine row coordinate of c.o.g.
coor(2) = determine_center(I,2);    % determine column coordinate of c.o.g.

disp('R;C :')                     % output of the coordinates of the center of gravity
disp(coor)


indices = find(abs(I)==1);
I(indices) = 255;

I(coor(1):coor(1)+1,coor(2):coor(2)+1,2) = 0;       % marking c.o.g. in output file
I(coor(1):coor(1)+1,coor(2):coor(2)+1,3) = 0;

imshow(I)


function coordinates = determine_center(I,dimension)

    a=0;
    b=0;
    Z = zeros(size(I,dimension),1);

    for i = 1:size(I,dimension)

        if dimension == 1
            Z(i) = sum(I(i,:));
        elseif dimension == 2
            Z(i) = sum(I(:,i));
        else
            error('Dimension is invalid')
        end

    end

    for i = 1:size(I,dimension)

        if a > b
            break
        else
            
            a=0;
            b=0;
            
            for j = 1:i
                a = a + Z(j) * abs(j-i);
            end
    
            for j = i:size(I,dimension)
                b = b + Z(j) * abs(j-i);
            end
            
        end
    end

    coordinates = i-2;
end


