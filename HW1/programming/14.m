function SVM_pack14(data)
    x=data(:,2:3);
    y=data(:,1);
    m=size(x,1);
    for i=1:m
        if(y(i,1)==4)
            y(i,1)=1;
        else
            y(i,1)=-1;
        end
    end
    %C_array=[-6,-4,-2,0,2];
    C_array=[-5,-3,-1,1,3];
    y_axis=zeros(1,5);
    for k=1:5
        C=10.^C_array(k);
        SVMModel=fitcsvm(x,y,'KernelFunction','polynomial','PolynomialOrder',2,'BoxConstraint',C,'Solver','SMO');
        classOrder = SVMModel.ClassNames;
        sv = SVMModel.SupportVectors;
        %gscatter(x(:,1),x(:,2),y)
        %hold on
        %plot(sv(:,1),sv(:,2),'bo','MarkerSize',10)
        SVMModel.Alpha;
        is=SVMModel.IsSupportVector;
        
        error=0;
        [label,score] = predict(SVMModel,x);
        
        for(i=1:m)
            [label(i),y(i)];
            
            if(label(i)~=y(i))
                error=error+1;
            end
        end
         
        Ein=error/m;
        y_axis(k)=Ein;
    end
    plot(C_array,y_axis)
    title('Ein vs log_{10}C')
    ylim([0.089 0.09])
end
function ret=kernel_poly(x,y)
    ret=((1+dot(x,y))*(1+dot(x,y)));
end