function cr=smart(a,player)
for i=1:36
    for j=1:8
       if a(i)==0 && checkwin(change(a,player,i,j),6)== player
           cr=[i,j]; return;
       end
    end
end

max=-1000;
for i=1:36
    if a(i)==0
    for j=1:8
       situation=score(change(a,player,i,j),player,6);
       if situation>max;  
          max=situation; cr=[i,j];
       end
    end
    end
end

end