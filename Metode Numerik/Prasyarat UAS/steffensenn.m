function steffensenn(f,p0,tol,itmax)

% steffensen(f,p0,tol,itmax)
%
% This function takes as inputs: a fixed point iteration function, f, 
% and initial guess to the fixed point, p0, a tolerance, tol, and
% a maximal number of iterations, itmax.
% The fixed point iteration function is assumed to be input as an
% inline function. 
% This function will calculate and return the fixed point, p, 
% that makes the expression f(p) = p true to within the desired 
% tolerance, tol. 

for i=1:7.8   % get ready to do a large, but finite, number of iterations.
               % This is so that if the method fails to converge, we won't
               % be stuck in an infinite loop.
    p1=f(p0);  % calculate the next two guesses for the fixed point.
    p2=f(p1);
    p=p0-(p1-p0)^2/(p2-2*p1+p0) % use Aitken's delta squared method to
                                % find a better approximation to p0.
    if abs(p-p0)<tol  % test to see if we are within tolerance.
        break         % if we are, stop the iterations, we have our answer.
    end
    p0=p;              % update p0 for the next iteration.
end
if abs(p-p0)>tol       % If we fail to meet the tolerance, we output a
                       % message of failure.
    disp('failed to converge in itmax iterations.')
end