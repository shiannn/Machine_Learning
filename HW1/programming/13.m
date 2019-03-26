function SVM_pack13(data)
    x=data(:,2:3);
    y=data(:,1);
    m=size(x,1);
    for i=1:m
        if(y(i,1)==2)
            y(i,1)=1;
        else
            y(i,1)=-1;
        end
    end
    %C_array=[-6,-4,-2,0,2];
    %C_array=[-3,-2,-1,0,1];
    C_array=[-5,-3,-1,1,3];
    y_axis=zeros(1,5);
    for k=1:5
        C=10.^C_array(k);
        SVMModel=fitcsvm(x,y,'KernelFunction','linear','BoxConstraint',C,'Solver','SMO','DeltaGradientTolerance',1e-10,'GapTolerance',1e-10,'KKTTolerance',1e-10);
        SVMModel.ConvergenceInfo;
        w=SVMModel.Beta;
        y_axis(k)=normest(w);        
    end
    plot(C_array,y_axis)
    title('|w| vs log_{10}C')
end