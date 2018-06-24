function pentago
tile{3} = imread('blue.png','png');
tile{2} = imread('red.png','png');
tile{1} = imread('empty.png','png');
tile{4} = imread('rotdu.png','png');
tile{5} = imread('rotud.png','png');
tile{6} = imread('rotlr.png','png');
tile{7} = imread('rotrl.png','png');
tile{8} = imread('norot.png','png');

%First, user can choose either 6*6 or 9*9 board.
n = input('Please choose 6*6 or 9*9 board(enter 6 or 9):');

%Second, choose the type and level.
if n ==6
cho = input('Please input a number. Human vs human(1) or human vs smart AI(human first)(2) or human vs AI(AI first)(3)?');
elseif n ==9
disp('9*9 can be only played by human vs human!');
end


%%%%%%%%%%%%% case for 6*6(human vs smart AI) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n == 6 && cho == 2
   
%Show the intial diagram.
mat = [];
mat1 = [tile{8},tile{8},tile{8},tile{7},tile{6},tile{8},tile{8},tile{8}];
mat2 = [tile{8},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{8}];
mat3 = [tile{4},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{4}];
mat4 = [tile{5},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{5}];
mat=[mat1;mat2;mat2;mat3;mat4;mat2;mat2;mat1];
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

count = 0;
while count < 36
n1 = mod(count,2)+1;

% First, add a marble into a position.
  if n1 == 1 %First player.
   fprintf('player 1\n');
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   
   while x==1 || y==1 || x==8 || y==8 %Error checking
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
   
   while A(x-1,y-1)~=0 %Error Checking
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
   
   add_red(x,y);   
   disp(A);
   G_board = transf(A,6); %Transfer A to G_board.
    mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];   
   image(mat);
    
  fprintf('Now select the rotation\n');
  [y,x] = ginput(1);
  x = ceil(x/504);
  y = ceil(y/504);

   while sum(x==2:7)==1 && sum(y==2:7)==1 %Error checking for rotation. 
    [y,x] = ginput(1);
    x = ceil(x/504);
    y = ceil(y/504);
   end 

   A =rot6(A,x,y);
   disp(A);
   G_board = transf(A,6);
   mat = [mat1;[tile{8} G_board{1,:} tile{8}];[tile{8} G_board{2,:} tile{8}]; [tile{4} G_board{3,:} tile{4}] ;[tile{5} G_board{4,:} tile{5}] ;[tile{8} G_board{5,:} tile{8}] ; [tile{8} G_board{6,:} tile{8};mat1]];
   image(mat); 
   
   %checkwin
   r = checkwin(A,6);
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
   pause(0.8); %tic,pause(1),toc;
 
 
  elseif n1 == 2 %Second player.
      fprintf('Player 2(AI)\n');
    tic;
     strat = make_a_move_computer(A,2); %make_a_move_computer(player,a)
    add_blue2(strat(1));
     G_board = transf(A,6); %Transfer A to G_board.
     mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];
    image(mat);   
   image(mat);
   pause(0.8);
   A =rot(A,strat(2));
   disp(A);
   G_board = transf(A,6);
   mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];
    image(mat);   
    toc;
  end
 
%check win. 
%If a user wins, break the while loop.If all spaces on the board are occupied, break the loop.
%Otherwise, come back to the starting point of loop.
r = checkwin(A,6);
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


%%%%%%%%%%%%% case for 6*6(AI vs human)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n == 6 && cho == 3
   
%Show the intial diagram.
mat = [];
mat1 = [tile{8},tile{8},tile{8},tile{7},tile{6},tile{8},tile{8},tile{8}];
mat2 = [tile{8},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{8}];
mat3 = [tile{4},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{4}];
mat4 = [tile{5},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{5}];
mat=[mat1;mat2;mat2;mat3;mat4;mat2;mat2;mat1];
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
count = 0;
while count < 36
n1 = mod(count,2)+1;

  if n1 == 2 %second player.
   fprintf('player 2\n');
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   
   while x==1 || y==1 || x==8 || y==8 %Error checking
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
   
   while A(x-1,y-1)~=0 %Error Checking
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
   
   add_blue(x,y);   
   disp(A);
   G_board = transf(A,6); %Transfer A to G_board.
    mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];   
   image(mat);
    
  fprintf('Now select the rotation\n');
  [y,x] = ginput(1);
  x = ceil(x/504);
  y = ceil(y/504);

   while sum(x==2:7)==1 && sum(y==2:7)==1 %Error checking for rotation. 
    [y,x] = ginput(1);
    x = ceil(x/504);
    y = ceil(y/504);
   end 

   A =rot6(A,x,y);
   disp(A);
   G_board = transf(A,6);
   mat = [mat1;[tile{8} G_board{1,:} tile{8}];[tile{8} G_board{2,:} tile{8}]; [tile{4} G_board{3,:} tile{4}] ;[tile{5} G_board{4,:} tile{5}] ;[tile{8} G_board{5,:} tile{8}] ; [tile{8} G_board{6,:} tile{8};mat1]];
   image(mat); 
   
   %checkwin
   r = checkwin(A,6);
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
   pause(0.8); %tic,pause(1),toc;
   
 
  elseif n1 == 1 %first player.
      fprintf('Player 1(AI)\n');
    tic;
     strat = make_a_move_computer(A,2); %make_a_move_computer(player,a)
    add_red2(strat(1));
     G_board = transf(A,6); %Transfer A to G_board.
  mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];
   image(mat);
   pause(0.8);
   A =rot(A,strat(2));
   disp(A);
   G_board = transf(A,6);
  mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}]; 
    [tile{4} G_board{3,:} tile{4}] ;
    [tile{5} G_board{4,:} tile{5}] ;
    [tile{8} G_board{5,:} tile{8}] ; 
    [tile{8} G_board{6,:} tile{8};mat1]];
   image(mat);    
    toc;
  end
 
%check win. 
%If a user wins, break the while loop.If all spaces on the board are occupied, break the loop.
%Otherwise, come back to the starting point of loop.
r = checkwin(A,6);
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



%%%%%%%%%%%%% case for 6*6(human vs human)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n == 6 && cho == 1

%Show the intial diagram.
mat = [];
mat1 = [tile{8},tile{8},tile{8},tile{7},tile{6},tile{8},tile{8},tile{8}];
mat2 = [tile{8},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{8}];
mat3 = [tile{4},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{4}];
mat4 = [tile{5},tile{1}, tile{1}, tile{1}, tile{1} ,tile{1},tile{1},tile{5}];
mat=[mat1;mat2;mat2;mat3;mat4;mat2;mat2;mat1];
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
fprintf('The index of each position is from 1 to 36, from left to right and from up to down.\n');
count = 0;
while count < 36
n1 = mod(count,2)+1;
% First, add a marble into a position.
  
  if n1 == 1 %First player.
   fprintf('player 1\n');
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   
   while x==1 || y==1 || x==8 || y==8 %Error checking
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
   
   while A(x-1,y-1)~=0 %Error Checking
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
         
   add_red(x,y);   
 
  elseif n1 == 2 %Second player.
    fprintf('player 2\n');
    [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   
   while x==1 || y==1 || x==8 || y==8 
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
   
   while A(x-1,y-1)~=0
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
   
   add_blue(x,y);
  end
    
G_board = transf(A,6); %Transfer A to G_board.
mat = [mat1;[tile{8} G_board{1,:} tile{8}];[tile{8} G_board{2,:} tile{8}]; [tile{4} G_board{3,:} tile{4}] ;[tile{5} G_board{4,:} tile{5}] ;[tile{8} G_board{5,:} tile{8}] ; [tile{8} G_board{6,:} tile{8};mat1]];
image(mat);  %Show the diagram.

%Second, user can rotate any small matrix.

fprintf('Now select the rotation\n');
[y,x] = ginput(1);
x = ceil(x/504);
y = ceil(y/504);

while sum(x==2:7)==1 && sum(y==2:7)==1 %Error checking for rotation. 
    [y,x] = ginput(1);
    x = ceil(x/504);
    y = ceil(y/504);
end 

A =rot6(A,x,y);
G_board = transf(A,6);
mat = [mat1;[tile{8} G_board{1,:} tile{8}];[tile{8} G_board{2,:} tile{8}]; [tile{4} G_board{3,:} tile{4}] ;[tile{5} G_board{4,:} tile{5}] ;[tile{8} G_board{5,:} tile{8}] ; [tile{8} G_board{6,:} tile{8};mat1]];
image(mat); 

%Third, check win. 
%If a user wins, break the while loop.If all spaces on the board are occupied, break the loop.
%Otherwise, come back to the starting point of loop.
r = checkwin(A,6);
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


%%%%%%%% case for 9*9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case of 9*9 board is similar to 6*6.
if n == 9
mat = [];
mat1 = [tile{8},tile{8},tile{8},tile{7},tile{6},tile{8},tile{7},tile{6},tile{8},tile{8},tile{8}];
mat2 = [tile{8},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{8}];
mat3 = [tile{4},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{4}];
mat4 = [tile{5},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{5}];
mat5 = [tile{6},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{1},tile{7}];
mat6 = [tile{8},tile{8},tile{8},tile{7},tile{6},tile{8},tile{7},tile{6},tile{8},tile{8},tile{8}];
mat=[mat1;mat2;mat2;mat3;mat4;mat4;mat3;mat4;mat2;mat2;mat6];
set(gcf,'Position',[150 150 50*7 50*7]);
image(mat);

G_board = cell(9,9);
for a = 1:9
    for b = 1:9
        G_board{a,b} = tile{1};
    end
end

A = zeros(9,9);

count = 1;
while count < 81
n1 = mod(count,2)+1;
  
   if n1 == 2 %First player.
   fprintf('player 1\n');
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
    
   while x==1 || y==1 || x==11 || y==11 
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
 
   while A(x-1,y-1)~=0
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
   
   add_red(x,y);   
 
   elseif n1 == 1 %Second player.
    fprintf('player 2\n');
    [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
    
   while x==1 || y==1 || x==11 || y==11 
       [y,x] = ginput(1);
        x = ceil(x/504);
        y = ceil(y/504);
   end
   
   while A(x-1,y-1)~=0
   [y,x] = ginput(1);
   x = ceil(x/504);
   y = ceil(y/504);
   end
   
   add_blue(x,y);
   
   end
  
G_board = transf(A,9);
mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}];
    [tile{4} G_board{3,:} tile{4}];
    [tile{5} G_board{4,:} tile{5}];
    [tile{5} G_board{5,:} tile{5}];
    [tile{4} G_board{6,:} tile{4}];
    [tile{5} G_board{7,:} tile{5}];
    [tile{8} G_board{8,:} tile{8}];
    [tile{8} G_board{9,:} tile{8}];mat6];
image(mat);  

fprintf('Now select the rotation\n');
[y,x] = ginput(1);
x = ceil(x/504);
y = ceil(y/504);

while sum(x==2:10)==1 && sum(y==2:10)==1 %Error checking for rotation. 
    [y,x] = ginput(1);
    x = ceil(x/504);
    y = ceil(y/504);
end 

A =rot9(A,x,y);
G_board = transf(A,9);
mat = [mat1;[tile{8} G_board{1,:} tile{8}];
    [tile{8} G_board{2,:} tile{8}];
    [tile{4} G_board{3,:} tile{4}];
    [tile{5} G_board{4,:} tile{5}];
    [tile{5} G_board{5,:} tile{5}];
    [tile{4} G_board{6,:} tile{4}];
    [tile{5} G_board{7,:} tile{5}];
    [tile{8} G_board{8,:} tile{8}];
    [tile{8} G_board{9,:} tile{8}];mat6];
image(mat);  

r = checkwin(A,9);
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

%%%%%%%function for add a red marble(AI)%%%%%%%%
  function  add_red2(position)
  A(position) = 1;
  end
%%%%%%%function for add a blue marble(AI)%%%%%%%%
  function  add_blue2(position)
  A(position) = 2;
  end
%%%%%%%% function for add a red marble %%%%%%%%%%
  function  add_red(x,y)
  A(x-1,y-1) = 1;
  end
%%%%%%% function for add a blue marble %%%%%%%%%
  function  add_blue(x,y)
  A(x-1,y-1) = 2;
  end

%%%%%%% function for transfer matrix A to cell G_board %%%%%%%%
  function G_board = transf(A,n)
      
    if n == 6
        G_board{6,6}=imread('empty.png','png');
    elseif n == 9
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
    function [output,index]  = rot6(A,x,y)
    if x == 1 && y == 4
        index = 1;
    elseif x == 1 && y == 5
        index = 8;
    elseif x == 4 && y == 1
        index = 5;
    elseif x == 4 && y == 8
        index = 4;
    elseif x == 5 && y == 1
        index = 2;
    elseif x == 5 && y == 8
        index = 7;
    elseif x == 8 && y == 4
        index = 6;
    elseif x == 8 && y == 5
        index = 3;
    end
  
    switch index
        case 1
           A(1:3,1:3) = rot90(A(1:3,1:3));
          
        case 2 
            A(4:6,1:3) =rot90(A(4:6,1:3));
           
        case 3
            A(4:6,4:6) =rot90(A(4:6,4:6));
           
        case 4
            A(1:3,4:6) =rot90(A(1:3,4:6));
          
        case 5
            A(1:3,1:3) =rot90(rot90(rot90(A(1:3,1:3))));
           
        case 6
           A(4:6,1:3) =rot90(rot90(rot90(A(4:6,1:3))));
          
        case 7
            A(4:6,4:6) =rot90(rot90(rot90(A(4:6,4:6))));
            
        case 8
            A(1:3,4:6) =rot90(rot90(rot90(A(1:3,4:6))));
    end
        output = A;
    end


%%%%%%%%%function for rorate 9*9%%%%%%%
 function [output,index]  = rot9(A,x,y)
    
     if x == 1 && y == 4
       index = 14;
    elseif x == 4 && y == 1 
       index = 13 ;
    elseif x == 5 && y == 1
        index = 12;
    elseif x == 7 && y == 1
        index = 11;
    elseif x == 8 && y == 1
        index = 10;
    elseif x == 11 && y == 4
        index = 9;
    elseif x == 11 && y == 5
        index = 8;
    elseif x == 11 && y == 7
        index = 7;
    elseif x == 11 && y == 8
        index = 6;
    elseif x == 8 && y == 11
        index = 5;
    elseif x == 7 && y == 11
        index = 4;
    elseif x == 5 && y == 11 
        index = 3;
    elseif x == 4 && y == 11
        index = 2;
    elseif x == 1 && y == 8
        index = 1;
    elseif x == 1 && y == 7
        index = 16;
    elseif x == 1 && y == 5
        index = 15;
    elseif x == 6 && y == 1
        index = 18;
    elseif x == 6 && y == 11
        index = 17;
    end
        
    switch index
        case 1
           A(1:3,7:9) = rot90(rot90(rot90(A(1:3,7:9))));
        case 2
           A(1:3,7:9) = rot90(A(1:3,7:9));
        case 3
           A(4:6,7:9) = rot90(rot90(rot90(A(4:6,7:9))));
        case 4
           A(4:6,7:9) = rot90(A(4:6,7:9));
        case 5
            A(7:9,7:9) = rot90(rot90(rot90(A(7:9,7:9))));
        case 6
            A(7:9,7:9) = rot90(A(7:9,7:9)); 
        case 7
             A(7:9,4:6) = rot90(rot90(rot90(A(7:9,4:6))));
        case 8
            A(7:9,4:6) = rot90(A(7:9,4:6)); 
        case 9
             A(7:9,1:3) = rot90(rot90(rot90(A(7:9,1:3))));
        case 10
            A(7:9,1:3) = rot90(A(7:9,1:3)); 
        case 11
            A(4:6,1:3) = rot90(rot90(rot90(A(4:6,1:3))));
        case 12
            A(4:6,1:3) = rot90(A(4:6,1:3)); 
        case 13
             A(1:3,1:3) = rot90(rot90(rot90(A(1:3,1:3))));
        case 14
             A(1:3,1:3) = rot90(A(1:3,1:3)); 
        case 15
             A(1:3,4:6) = rot90(rot90(rot90(A(1:3,4:6))));
        case 16          
             A(1:3,4:6) = rot90(A(1:3,4:6)); 
        case 17
             A(4:6,4:6) = rot90(rot90(rot90(A(4:6,4:6))));
        case 18
             A(4:6,4:6) = rot90(A(4:6,4:6));
        end
    output = A;
    end

%funnction for checkwin&&&&&&&&
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



%%%%%%%  function for rotate 6*6(AI) %%%%%%%%%      
    function output  = rot(A, index)
    switch index
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
        output = A;
    end


  end




