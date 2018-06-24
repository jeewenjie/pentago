function [ r ] = checkwin( mt, n)
re1=0;re2=0;
%First loop to check all the rows.
    for i=1:n
        c1=0; c2=0;
        for j=1:n
            if mt(i,j)==1
               c2=0; c1=c1+1;
            elseif mt(i,j)==2
                c1=0; c2=c2+1;
            else c1=0; c2=0;
            end        
            if c1==5 
               re1=1; 
            end
            if c2==5
               re2=1; 
            end 
        end   
    end
    
%This for checking the diagonal.

    for i=1:n
        c1=0; c2=0;
        for j=1:(n+1-i)
            if mt((i-1+j),j)==1
                c2=0; c1=c1+1;
            elseif mt((i-1+j),j)==2
                c1=0; c2=c2+1;
            else c1=0; c2=0;
            end        
        if c1==5 
           re1=1; 
        end
        if c2==5
           re2=1;
        end
        end
    end

%Rotate the original matrix to check all the colums and anti-diagonals
 mt=rot90(mt);
%First loop to check all the columns.
    for i=1:n
        c1=0; c2=0;
        for j=1:n
            if mt(i,j)==1
               c2=0; c1=c1+1;
            elseif mt(i,j)==2
                c1=0; c2=c2+1;
            else c1=0; c2=0;
            end
            if c1==5 
               re1=1;
            end
            if c2==5
               re2=1; 
            end
         end
    end
%This for checking the diagonal. 

    for i=1:n
        c1=0; c2=0;
        for j=1:(n+1-i)
        if mt((i-1+j),j)==1
            c2=0; c1=c1+1;
        elseif mt((i-1+j),j)==2
            c1=0; c2=c2+1;
        else c1=0; c2=0;       
        end
        if c1==5 
           re1=1; 
        end
        if c2==5
           re2=1;
        end
        end
    end
    
% final check of each case
 if re1==1 && re2==1
     r=3;
 elseif re1==1 && re2==0
     r=1;
 elseif re1==0 && re2==1
     r=2;
 else r=0;
     
 if r==0 && (prod(prod(mt))~=0)
    r=3;
 end
 end
end