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
% if sum(sum(a))<=6
% if a(2,2)==color
% sc=sc+10;
% end
% if a(2,5)==color
% sc=sc+10;
% end
% if a(5,2)==color
% sc=sc+10;
% end
% if a(5,5)==color
% sc=sc+10;
% end
% return;
% end
if a(2,2)==color
sc=sc+1.012;
end
if a(2,5)==color
sc=sc+1.012;
end
if a(5,2)==color
sc=sc+1.012;
end
if a(5,5)==color
sc=sc+1.012;
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
elseif a(1,i)==3-color
sc=sc+0.004;
end
if a(6,i)==color
sc=sc-0.01;
elseif a(6,i)==3-color
sc=sc+0.004;
end
end
for i=1:6
if a(i,1)==color
sc=sc-0.01;
elseif a(i,1)==3-color
sc=sc+0.004;
end
if a(i,6)==color
sc=sc-0.01;
elseif a(i,6)==3-color
sc=sc+0.004;
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
sc=sc+1.6;
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
sc=sc+1.6;
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
sc=sc+1.6;
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
sc=sc+1.6;
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
sc=sc+1.6;
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
sc=sc+1.6;
if j==0
sc=sc+0.2;
end
end
end
if a(2+i,3+j)==color && a(3+i,3+j)==color && a(1+i,3+j)==0
sc=sc+0.5;
end
% dia
% if a(1+i,2+j)==color && a(2+i,3+j)==color
% sc=sc+0.5;
% end
% if a(1+i,2+j)==color && a(2+i,1+j)==color
% sc=sc+0.5;
% end
% if a(3+i,2+j)==color && a(2+i,1+j)==color
% sc=sc+0.5;
% end
% if a(3+i,2+j)==color && a(2+i,3+j)==color
% sc=sc+0.5;
% end
% long dia
if a(3+i,3+j)==color && a(2+i,2+j)==color
if a(1+i,1+j)==0
sc=sc+0.5;
end
if a(1+i,1+j)==color
sc=sc+1.6;
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
sc=sc+1.6;
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
for i=1:6
if a(i,1)==0 && a(i,6)==0 && a(i,2)*a(i,3)*a(i,4)*a(i,5)~=0
if a(i,2)+a(i,3)+a(i,4)+a(i,5)==4*color
sc=sc+8;
end
if a(i,2)+a(i,3)+a(i,4)+a(i,5)==9-2*color
sc=sc+6;
end
end
if a(i,1)==0 && a(i,2)==0 && a(i,3)==3-color && a(i,4)==3-color && a(i,5)==3-color && a(i,6)==color
sc=sc+6.5;
end
if a(i,1)==color && a(i,2)==3-color && a(i,3)==3-color && a(i,4)==3-color && a(i,5)==0 && a(i,6)==0
sc=sc+6.5;
end
 
if a(1,i)==0 && a(6,i)==0 && a(2,i)*a(3,i)*a(4,i)*a(5,i)~=0
if a(2,i)+a(3,i)+a(4,i)+a(5,i)==4*color
sc=sc+8;
end
if a(2,i)+a(3,i)+a(4,i)+a(5,i)==9-2*color
sc=sc+6;
end
end
if a(1,i)==0 && a(2,i)==0 && a(3,i)==3-color && a(4,i)==3-color && a(5,i)==3-color && a(6,i)==color
sc=sc+6.5;
end
if a(1,i)==color && a(2,i)==3-color && a(3,i)==3-color && a(4,i)==3-color && a(5,i)==0 && a(6,i)==0
sc=sc+6.5;
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