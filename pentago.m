function pentago
tile{3} = imread('blue.png','png');
tile{2} = imread('red.png','png');
tile{1} = imread('empty.png','png');

%First, user can choose either 6*6 or 9*9 board.
n = input('Please choose 6*6 or 9*9 board(enter 6 or 9):');



%%%%%%%%%%%%% case for 6*6 %%%%%%%%%%%%%%%%%
if n == 6

    
%Show the intial diagram.
mat = [];
mat = [mat, tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1}];
mat=[mat;mat;mat;mat;mat;mat];
set(gcf,'Position',[150 150 50*7 50*7]);
image(mat);


%Determine G_board as a cell containing pictures.
G_board = cell(6,6);
for a = 1:6
    for b = 1:6
        G_board{a,b} = tile{1};
    end
end

%Determine A as a matrix containing numbers.
A = zeros(6,6);



count = 1;
while count < 36
n1 = mod(count,2)+1;
% First, add a marble into a position.
  
  if n1 == 2 %First player.
   fprintf('player 1');
   [y,x] = ginput(1);
   x = ceil(x/500);
   y = ceil(y/500);
   while A(x,y)~= 0 
       [y,x] = ginput(1);
       x = ceil(x/500);
       y = ceil(y/500);
   end
       
   add_red(x,y);   
 
 
  elseif n1 == 1 %Second player.
    fprintf('player 2');
    [y,x] = ginput(1);
   x = ceil(x/500);
   y = ceil(y/500);
     while A(x,y)~= 0 
       [y,x] = ginput(1);
       x = ceil(x/500);
       y = ceil(y/500);
   end
   add_blue(x,y);
  end
  
   

  
G_board = transf(A,6); %Transfer A to G_board.
mat = [G_board{1,:};G_board{2,:};G_board{3,:};G_board{4,:};G_board{5,:};G_board{6,:}];
image(mat);  %Show the diagram.

%Second, user can rotate any small matrix.

if n1 == 2
index = input('Please enter the index that you want to rotate the matrix(first player):');
elseif n1 == 1
index = input('Please enter the index that you want to rotate the matrix(scond player):');
end

while index<1 || index >8
    index = input('Index should be 1 to 8. Please enter again:');
end
A =rot6(A,index);
G_board = transf(A,6);
mat = [G_board{1,:};G_board{2,:};G_board{3,:};G_board{4,:};G_board{5,:};G_board{6,:}];
 image(mat); 

%Third, check win. 
%If a user wins, break the while loop.If all spaces on the board are occupied, break the loop.
%Otherwise, come back to the starting point of loop.
r = check(A,6);
if r == 1
    fprintf('The first player wins!');
    break
elseif r == 2
    fprintf('The second player wins!');
    break
elseif r ==3
    fprintf('It is a draw!');
    break
end
count = count+1;
end
end




%%%%%%%% case for 9*9 %%%%%%%%
% Case of 9*9 board is similar to 6*6.
if n == 9
mat = [];
mat = [mat, tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{1} ,tile{1},tile{1},];
mat=[mat;mat;mat;mat;mat;mat;mat;mat;mat];
set(gcf,'Position',[150 150 50*7 50*7]);
image(mat);

G_board = cell(9,9);
for i = 1:9
    for j = 1:9
        G_board{i,j} = tile{1};
    end
end


A = zeros(9,9);

count = 1;
while count < 81
n1 = mod(count,2)+1;
  
if n1 == 2 %First player.
   fprintf('player 1');
   [y,x] = ginput(1);
   x = ceil(x/500);
   y = ceil(y/500);
   while A(x,y)~= 0 
       [y,x] = ginput(1);
       x = ceil(x/500);
       y = ceil(y/500);
   end    
   add_red(x,y);   
 
 
  elseif n1 == 1 %Second player.
    fprintf('player 2');
    [y,x] = ginput(1);
   x = ceil(x/500);
   y = ceil(y/500);
     while A(x,y)~= 0 
       [y,x] = ginput(1);
       x = ceil(x/500);
       y = ceil(y/500);
   end
   add_blue(x,y);
end
  
G_board = transf(A,9);
mat = [G_board{1,:};G_board{2,:};G_board{3,:};G_board{4,:};G_board{5,:};G_board{6,:};G_board{7,:};G_board{8,:};G_board{9,:}];
image(mat);  

if n1 == 2
index = input('Please enter the index that you want to rotate the matrix(first player):');
elseif n1 == 1
index = input('Please enter the index that you want to rotate the matrix(scond player):');
end

while index<1 || index > 18
    index = input('Index should be 1 to 18. Please enter again:');
end
A =rot9(A,index);
disp(A);
G_board = transf(A,9);
mat = [G_board{1,:};G_board{2,:};G_board{3,:};G_board{4,:};G_board{5,:};G_board{6,:};G_board{7,:};G_board{8,:};G_board{9,:}];
 image(mat); 
r = check(A,9);
if r == 1
    fprintf('The first player wins!');
    break
elseif r == 2
    fprintf('The second player wins!');
    break
elseif r ==3
    fprintf('It is a draw!');
    break
end
count = count+1;
end

end






%%%%%%%% function for add a red marble %%%%%%%%%%
  function  add_red(x,y)
  A(x,y) = 1;
  end
%%%%%%% function for add a blue marble %%%%%%%%%
  function  add_blue(x,y)
  A(x,y) = 2;
  end

%%%%%%% function for transfer matrix A to cell G_board %%%%%%%%
  function G_board = transf(A,n)
    if n == 6
        G_board{6,6}=imread('empty.png','png');
    elseif n ==9
        G_board{9,9}=imread('empty.png','png');
    end
    for c = 1:n
        for d = 1:n
          if A(c,d) == 1
            G_board{c,d} = imread('red.png','png');
          elseif A(c,d) == 2
            G_board{c,d} = imread('blue.png','png');
          else
            G_board{c,d} = imread('empty.png','png');
          end
        end
    end 
  end
  

 %%%%%%%  function for rotate 6*6 %%%%%%%%%      
    function output  = rot6(A, index)
    switch index
        case 1
           A(1:3,4:6) = rot90(rot90(rot90(A(1:3,4:6))));
          
        case 2 
            A(4:6,1:3) =rot90(A(4:6,1:3));
           
        case 3
            A(4:6,4:6) =rot90(rot90(rot90(A(4:6,4:6))));
           
        case 5
            A(4:6,1:3) =rot90(rot90(rot90(A(4:6,1:3))));
          
        case 7
            A(1:3,1:3) =rot90(rot90(rot90(A(1:3,1:3))));
           
        case 4
           A(4:6,4:6) =rot90(A(4:6,4:6));
          
        case 6
            A(1:3,1:3) =rot90(A(1:3,1:3));
            
        case 8
            A(1:3,1:3) =rot90(A(1:3,1:3));
          
    end
        output = A;
    end


%%%%%%%%%function for rorate 9*9%%%%%%%
 function output  = rot9(A, index)
    switch index
        case 1
           A(1:3,7:9) = rot90(rot90(rot90(A(1:3,7:9))));
        case 2
           A(1:3,7:9) = rot90((A(1:3,7:9)));
        case 3
           A(4:6,7:9) = rot90(rot90(rot90(A(4:6,7:9))));
        case 4
           A(4:6,7:9) = rot90((A(4:6,7:9)));
        case 5
            A(7:9,7:9) = rot90(rot90(rot90(A(7:9,7:9))));
        case 6
            A(7:9,7:9) = rot90((A(7:9,7:9))); 
        case 7
             A(7:9,4:6) = rot90(rot90(rot90(A(7:9,4:6))));
        case 8
            A(7:9,4:6) = rot90((A(7:9,4:6))); 
        case 9
             A(7:9,1:3) = rot90(rot90(rot90(A(7:9,1:3))));
        case 10
            A(7:9,1:3) = rot90((A(7:9,1:3))); 
        case 11
             A(4:6,1:3) = rot90(rot90(rot90(A(4:6,1:3))));
        case 12
            A(4:6,1:3) = rot90((A(4:6,1:3))); 
        case 13
             A(1:3,1:3) = rot90(rot90(rot90(A(1:3,1:3))));
        case 14
               A(1:3,1:3) = rot90((A(1:3,1:3))); 
        case 15
             A(1:3,4:6) = rot90(rot90(rot90(A(1:3,4:6))));
        case 16          
             A(1:3,4:6) = rot90((A(1:3,4:6))); 
        case 17
             A(4:6,4:6) = rot90(rot90(rot90(A(4:6,4:6))));
        case 18
             A(4:6,4:6) = rot90(rot90(rot90(A(4:6,4:6))));
    end
    output = A;
 end

%%%%%%%%%% function for check win %%%%%%%%%%%
function [ r ] = check( mt, n)
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
c1=0; c2=0;
    for i=1:n
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



  end
