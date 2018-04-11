function x = conj_grad(b, A, x, max_it, tol, choice)
    
    if choice == 1
        % calculate residual vector r assoiated with x
        r = b - conv2(x,A,'same');
        p = r;
        rsold = r'*r;         
        for i=1:max_it
            Ap = conv2(p, A, 'same' );
            % compute the scalar alpha
            alpha = rsold / (p'*Ap);
            % update approximation
            x = x + alpha*p;
            r = r - alpha*Ap;
            rsnew = r'*r;
            % check convergence
            if abs(rsnew-rsold)<tol
                break;
            end
            p = r+(rsnew/rsold)*p;
            rsold = rsnew;
        end
        
    elseif choice == 2 
        r = b - A(x);
        p = r;
        rsold = r'*r;
%         absold = 1e20;
        for i=1:max_it
            Ap = A(p);
            alpha = rsold/(p'*Ap);
            x = x + alpha*p;
            r = r - alpha*Ap;
            rsnew = r'*r;
%             absnew = abs(rsnew-rsold);
            if abs(rsnew-rsold)<tol
                break;
            end
%             absold = absnew;
            p = r+(rsnew/rsold)*p;
            rsold = rsnew;
        end

        
    elseif choice == 3 
        r = b - A(x);
        p = r;
        rsold = sum( r.*r, 1) ;
%         absold = 1e20;
        for i=1:max_it
            Ap = A(p);
            alpha = rsold ./ sum(p.*Ap, 1);
            x = x + repmat(alpha, size(p,1),1 ).*p;
            r = r - repmat(alpha, size(p,1),1 ).*Ap;
            rsnew = sum(r.*r,1);
%             absnew = abs(rsnew-rsold);
            if sum( abs(rsnew-rsold) )<tol
                break;
            end
%             absold = absnew;
            p = r+ repmat(rsnew./rsold, size(p,1),1 ).*p;
            rsold = rsnew;
        end
    end
        
end
