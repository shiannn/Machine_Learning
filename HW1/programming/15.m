function SVM_pack15(data)
    x=data(:,2:3);
    y=data(:,1);
    m=size(x,1);
    for i=1:m
        if(y(i,1)==0)
            y(i,1)=1;
        else
            y(i,1)=-1;
        end
    end
    %C_array=[-6,-4,-2,0,2];
    C_array=[-2,-1,0,1,2];
    y_axis=zeros(1,5);
    for k=1:5
        C=10.^C_array(k);
        SVMModel=fitcsvm(x,y,'KernelFunction','gaussian','KernelScale',1/sqrt(80),'BoxConstraint',C,'Solver','SMO');
        classOrder = SVMModel.ClassNames;
        sv = SVMModel.SupportVectors;
        %gscatter(x(:,1),x(:,2),y)
        %hold on
        %plot(sv(:,1),sv(:,2),'bo','MarkerSize',10)
        SVMModel.Alpha;
        is=SVMModel.IsSupportVector;
        w=[0,0];
   
        j=1;%ready for use
        for i=1:m
            if(is(i,1)==1)
                temp=x(i,:)*y(i,1)*SVMModel.Alpha(j);
                j=j+1;
                w=w+temp;
            end
        end
     
        y_axis(k)=1/normest(w);
    end
    plot(C_array,y_axis)
    title('distance between free SV and hyperplane  vs  log_{10}C')
end