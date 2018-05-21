function [ e_temp ] = Feature_Exreaction( X )
%FEATURE_EXREACTION extracts feature from one c
%   Detailed explanation goes here
character = cell2mat(X);
ind = find(character(3, :)==1);
    e_temp = [];
    for j = 1 : length(ind)-1
        a = character(1, ind(j+1)) - character(1, ind(j));
        b = character(2, ind(j+1)) - character(2, ind(j));
        if a == 0 && b ==0
            continue
        end
        ang = angle(complex(a,b));
        if -pi/8 <= ang && ang < pi/8
            range = 1;
        elseif pi/8 <= ang && ang < 3*pi/8
            range = 2;
        elseif 3*pi/8 <= ang && ang < 5*pi/8
            range = 3;
        elseif 5*pi/8 <= ang && ang < 7*pi/8
            range = 4;
        elseif 7*pi/8 <= ang || ang < -7*pi/8
            range = 5;    
        elseif -7*pi/8 <= ang && ang < -5*pi/8
            range = 6;    
        elseif -5*pi/8 <= ang && ang < -3*pi/8
            range = 7;    
        elseif -3*pi/8 <= ang && ang < -pi/8
            range = 8;    
        end
        if ind(j) + 1 == ind(j+1)
            e_temp = [e_temp, range];
        else
            e_temp = [e_temp, range + 8];
        end
    end

end

