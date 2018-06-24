function cr= make_a_move_computer(a,player)
%function [ pos_played rotation_played ] = make_a_move_computer ( Board , who_to_play )


        
for ii=1:36
    for j1=1:8
       if a(ii)==0 && checkwin(change(a,player,ii,j1),6)== player
           cr=[ii,j1]; return;
       end
    end
end

max=-1000;
for ii=1:36
    if a(ii)==0
    for jj=1:8
       situation=score(change(a,player,ii,jj),player,6);
       if situation>max;  
          max=situation; cr=[ii,jj];
       end
    end
    end
end

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
c1=0; c2=0;
for i=1:n
    if mt(i,i)==1
        c2=0; c1=c1+1;
    elseif mt(i,i)==2
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
        
    for i=1:n-5
        c1=0; c2=0;
        for j=1:n-i
            if mt(i+j,j)==1
                c2=0; c1=c1+1;
            elseif mt(i+j,j)==2
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

    mtt=mt';
    for i=1:n-5
        c1=0; c2=0;
        for j=1:n-i
            if mtt(i+j,j)==1
                c2=0; c1=c1+1;
            elseif mtt(i+j,j)==2
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

c1=0; c2=0;
for i=1:n
    if mt(i,i)==1
        c2=0; c1=c1+1;
    elseif mt(i,i)==2
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
        
    for i=1:n-5
        c1=0; c2=0;
        for j=1:n-i
            if mt(i+j,j)==1
                c2=0; c1=c1+1;
            elseif mt(i+j,j)==2
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

    mtt=mt';
    for i=1:n-5
        c1=0; c2=0;
        for j=1:n-i
            if mtt(i+j,j)==1
                c2=0; c1=c1+1;
            elseif mtt(i+j,j)==2
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

function sc=score(a,color,n)
sc=0; 
for i=1:n^2
    if a(i)==0 
    for j=1:2*((n/3)^2)
       if checkwin(change(a,3-color,i,j),n)== 3-color
           sc=-100;
           return;
       end
    end
    end
end    
    
if n==6
%     if sum(sum(a))<=6
%         if a(2,2)==color
%             sc=sc+10;
%         end
%         if a(2,5)==color
%             sc=sc+10;
%         end
%         if a(5,2)==color
%             sc=sc+10;
%         end
%         if a(5,5)==color
%             sc=sc+10;
%         end
%         return;
%     end
    if a(2,2)==color
        sc=sc+1;
        if a(5,5)==color
            sc=sc+0.01;
        end
        if a(5,5)==3-color
            sc=sc+0.3;
        end
    end
    if a(2,5)==color
        sc=sc+1;
        if a(5,2)==color
            sc=sc+0.01;
        end
        if a(5,2)==3-color
            sc=sc+0.3;
        end
    end
    if a(5,2)==color
        sc=sc+1;
        if a(2,5)==color
            sc=sc+0.01;
        end
        if a(2,5)==3-color
            sc=sc+0.3;
        end
    end
    if a(5,5)==color
        sc=sc+1;
        if a(2,2)==color
            sc=sc+0.01;
        end
        if a(2,2)==3-color
            sc=sc+0.3;
        end
    end
    if a(3,3)==color
        sc=sc+0.1;
    end
    if a(3,4)==color
        sc=sc+0.1;
    end
    if a(4,3)==color
        sc=sc+0.1;
    end
    if a(4,4)==color
        sc=sc+0.1;
    end
    for i=1:6
        if a(1,i)==color
        sc=sc-0.01;
        end
        if a(6,i)==color
        sc=sc-0.01;
        end
    end
    for i=1:6
        if a(i,1)==color
        sc=sc-0.01;
        end
        if a(i,6)==color
        sc=sc-0.01;
        end
    end

    for i=0:3:3
        for j=0:3:3
            for k=1:3
                if a(k+i,1+j)*a(k+i,2+j)*a(k+i,3+j)~=0 && a(k+i,1+j)+a(k+i,2+j)+a(k+i,3+j)==6-color
                    sc=sc+1.05;
                end
                if a(1+i,k+j)*a(2+i,k+j)*a(3+i,k+j)~=0 && a(1+i,k+j)+a(2+i,k+j)+a(3+i,k+j)==6-color
                    sc=sc+1.05;
                end
            end
                     
            if a(1+i,1+j)==color && a(1+i,2+j)==color
                if a(1+i,3+j)==0
                   sc=sc+0.5;
                end
               if a(1+i,3+j)==color
                  sc=sc+1.1;
                  if i==3
                      sc=sc+0.2;
                  end
               end
            end
            if a(1+i,2+j)==color && a(1+i,3+j)==color && a(1+i,1+j)==0
               sc=sc+0.5;
            end
            if a(2+i,1+j)==color && a(2+i,2+j)==color
               if a(2+i,3+j)==0
                   sc=sc+0.5;
                end
               if a(2+i,3+j)==color
                  sc=sc+1.1;
               end
            end
            if a(2+i,2+j)==color && a(2+i,3+j)==color && a(2+i,1+j)==0
               sc=sc+0.5;
            end
            if a(3+i,1+j)==color && a(3+i,2+j)==color
               if a(3+i,3+j)==0
                   sc=sc+0.5;
               end
               if a(3+i,3+j)==color
                  sc=sc+1.1;
                  if i==0
                      sc=sc+0.2;
                  end
               end
            end
            if a(3+i,2+j)==color && a(3+i,3+j)==color && a(3+i,1+j)==0
               sc=sc+0.5;
            end
            % ve
            if a(1+i,1+j)==color && a(2+i,1+j)==color
               if a(3+i,1+j)==0
                   sc=sc+0.5;
               end
               if a(3+i,1+j)==color
                  sc=sc+1.1;
                  if j==3
                      sc=sc+0.2;
                  end
               end
            end
            if a(2+i,1+j)==color && a(3+i,1+j)==color && a(1+i,1+j)==0
               sc=sc+0.5;
            end
            if a(1+i,2+j)==color && a(2+i,2+j)==color
               if a(3+i,2+j)==0
                   sc=sc+0.5;
               end
               if a(3+i,2+j)==color
                  sc=sc+1.1;
               end
            end
            if a(2+i,2+j)==color && a(3+i,2+j)==color && a(1+i,2+j)==0
               sc=sc+0.5;
            end
            if a(1+i,3+j)==color && a(2+i,3+j)==color 
               if a(3+i,3+j)==0
                   sc=sc+0.5;
               end
               if a(3+i,3+j)==color
                  sc=sc+1.1;
                  if j==0
                      sc=sc+0.2;
                  end
               end
            end
            if a(2+i,3+j)==color && a(3+i,3+j)==color && a(1+i,3+j)==0
               sc=sc+0.5;
            end
%             dia
%             if a(1+i,2+j)==color && a(2+i,3+j)==color
%                sc=sc+0.5;
%             end
%             if a(1+i,2+j)==color && a(2+i,1+j)==color
%                sc=sc+0.5;
%             end
%             if a(3+i,2+j)==color && a(2+i,1+j)==color
%                sc=sc+0.5;
%             end
%             if a(3+i,2+j)==color && a(2+i,3+j)==color
%                sc=sc+0.5;
%             end
            % long dia
            if a(3+i,3+j)==color && a(2+i,2+j)==color
               if a(1+i,1+j)==0
                   sc=sc+0.5;
               end
               if a(1+i,1+j)==color
               sc=sc+1.1;
               end
            end
            if a(1+i,1+j)==color && a(2+i,2+j)==color && a(3+i,3+j)==0
               sc=sc+0.5;
            end
            if a(3+i,1+j)==color && a(2+i,2+j)==color
               if a(1+i,3+j)==0
                   sc=sc+0.5;
               end
               if a(1+i,3+j)==color
               sc=sc+1.1;
               end
            end
            if a(1+i,3+j)==color && a(2+i,2+j)==color && a(3+i,1+j)==0
               sc=sc+0.5;
            end
        end
    end     
    
    if a(2,2)==color && a(5,2)==color && a(1,2)==0 && a(6,2)==0 && a(3,2)+a(4,2)==color && a(3,2)*a(4,2)==0
sc=sc+4;
end
if a(2,5)==color && a(5,5)==color && a(1,5)==0 && a(6,5)==0 && a(3,5)+a(4,5)==color && a(3,5)*a(4,5)==0
sc=sc+4;
end
ra=a';
if ra(2,2)==color && ra(5,2)==color && ra(1,2)==0 && ra(6,2)==0 && ra(3,2)+ra(4,2)==color && ra(3,2)*ra(4,2)==0
sc=sc+4;
end
if ra(2,5)==color && ra(5,5)==color && ra(1,5)==0 && ra(6,5)==0 && ra(3,5)+ra(4,5)==color && ra(3,5)*ra(4,5)==0
sc=sc+4;
end
    
    % shi da sha zhao 
    for i=i:6
        if a(i,1)==0 && a(i,6)==0 && a(i,2)*a(i,3)*a(i,4)*a(i,5)~=0
            if a(i,2)+a(i,3)+a(i,4)+a(i,5)==4*color
                sc=sc+8;
            end
            if a(i,2)+a(i,3)+a(i,4)+a(i,5)==9-2*color
                sc=sc+6;
            end           
        end
        if a(1,i)==0 && a(6,i)==0 && a(2,i)*a(3,i)*a(4,i)*a(5,i)~=0
            if a(2,i)+a(3,i)+a(4,i)+a(5,i)==4*color
                sc=sc+8;
            end
            if a(2,i)+a(3,i)+a(4,i)+a(5,i)==9-2*color
                sc=sc+6;
            end           
        end
    end
    if a(1,1)==0 && a(6,6)==0 && a(2,2)*a(3,3)*a(4,4)*a(5,5)~=0
        if a(2,2)+a(3,3)+a(4,4)+a(5,5)==4*color
           sc=sc+8;
        end
        if a(2,2)+a(3,3)+a(4,4)+a(5,5)==9-2*color
           sc=sc+6;
        end
    end
    if a(1,6)==0 && a(6,1)==0 && a(2,5)*a(3,4)*a(4,3)*a(5,2)~=0
        if a(2,5)+a(3,4)+a(4,3)+a(5,2)==4*color
           sc=sc+8;
        end
        if a(2,5)+a(3,4)+a(4,3)+a(5,2)==9-2*color
           sc=sc+6;
        end
    end
            
end

end

function B=change(A,color,posi,rota)
% c=ceil(posi/6); r=posi-(c-1)*6;
% A(r,c)=color;
A(posi)=color;
switch rota
        case 1
           A(1:3,4:6) = rot90(rot90(rot90(A(1:3,4:6))));
          
        case 2 
            A(1:3,4:6) =rot90(A(1:3,4:6));
           
        case 3
            A(4:6,4:6) =rot90(rot90(rot90(A(4:6,4:6))));
           
        case 5
            A(4:6,1:3) =rot90(rot90(rot90(A(4:6,1:3))));
          
        case 7
            A(1:3,1:3) =rot90(rot90(rot90(A(1:3,1:3))));
           
        case 4
           A(4:6,4:6) =rot90(A(4:6,4:6));
          
        case 6
            A(4:6,1:3) =rot90(A(4:6,1:3));
            
        case 8
            A(1:3,1:3) =rot90(A(1:3,1:3));     
end
B=A;
end

end