%These choices depend on the problem being solved
x0=1;                      %The initial value
f(x)=1/2.*(x+2./x);      %The function that finds the next element in the sequence
tolerance=10^-10;         %10 digit accuracy is desired
epsilon=10^-16;            %Don't want to divide by a number smaller than this

maxIterations=20;          %Don't allow the iterations to continue indefinitely
haveWeFoundSolution=false; %Were we able to find the solution to within the desired tolerance? not yet.

for i = 1 : maxIterations 
    x1 = f(x0);
    x2 = f(x1);

    if(x1 ~= x0)
        lambda = absoluteValue((x2 - x1)/(x1 - x0));  %OPTIONAL: computes an approximation of |f'(fixedPoint)|, which is denoted by lambda
    end

    denominator = (x2 - x1) - (x1 - x0);

    if(absoluteValue(denominator) < epsilon)          %Don't want to divide by too small of a number
        print('WARNING: denominator is too small');
        break;                                        %Leave the loop
    end

    aitkenX = x2 - ( (x2 - x1)^2 )/denominator
    
    if(absoluteValue(aitkenX - x2) < tolerance)       %If the result is within toleranc
        fprintf('The fixed point is ', aitkenX)        %Display the result of the Aitken extrapolation
        haveWeFoundSolution = true;
        break;                                        %Done, so leave the loop
    end

    x0 = aitkenX;                                      %Update x0 to start again                  
    
end

if(haveWeFoundSolution == false)   %If we weren't able to find a solution to within the desired tolerance
    fprintf('Warning: Not able to find solution to within the desired tolerance of ', tolerance)
    fprintf('The last computed extrapolate was ', aitkenX)
end