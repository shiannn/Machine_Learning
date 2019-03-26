function SVM_pack16(data)
    [m n]=size(data);
    %gamma=[0,1,2,3,4];
    gamma=[-2,-1,0,1,2];
    C=0.1;
    for i=1:m
        if(data(i,1)==0)
            data(i,1)=1;
        else
            data(i,1)=-1;
        end
    end
    x_axis=zeros(1,5);
    for i=1:100
        data=data(randperm(m),:);
        valid=data(1:1000,:);
        training=data(1001:m,:);
        max=2000;
        min_gamma=0;
        for j=1:5
            error=0;
            SVMModel=fitcsvm(training(:,2:3),training(:,1),'KernelFunction','gaussian','KernelScale',1/sqrt(10.^gamma(j)),'BoxConstraint',C,'Solver','SMO');
            [label,score] = predict(SVMModel,valid(:,2:3));
            for(k=1:1000)
                if(valid(k,1)~=label(k))
                    error=error+1;
                end
            end
            if(error<max)
                max=error;
                min_gamma=j;
            end
        end
        x_axis(1,min_gamma)=x_axis(1,min_gamma)+1;
    end
    bar(x_axis)
    xlabel('log_{10}\gamma');	
    ylabel('number of times being selected');
    set(gca, 'xticklabel', {'-2','-1','0', '1', '2'});
end