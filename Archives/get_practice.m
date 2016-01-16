function [ ordered_test,count_grids ] = get_practice( actual_grid_classes,Test_data_MEDIAN_normalized )

   count_grids=zeros(10:1);
   classcount=1;
   ordered_test=zeros(size(Test_data_MEDIAN_normalized,1),size(Test_data_MEDIAN_normalized,2));
  
   counter1=1;
   
   while (classcount<11)
    counter=0;
    
        for k=1:size(actual_grid_classes,2)
            if actual_grid_classes(1,k)==classcount
            ordered_test(counter1,:)=Test_data_MEDIAN_normalized(k,:);
            counter=counter+1; 
            count_grids(classcount)=counter;
            counter1=counter1+1;
            
            end
        end
    classcount=classcount+1;
   end
end 
         
