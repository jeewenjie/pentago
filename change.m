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