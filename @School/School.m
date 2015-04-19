classdef School < handle
    %SCHOOL This class contains the class that handles all the information
    %regarding a school and its information.
    %
    
    properties
        PandaPoints
        Name
    end
    
    methods
        function obj=School(name)
            %Creates a name property for the school
            obj.Name = name;
            
            %loop to search the database for the school
            [~,schools]=xlsread('Database.xlsx','School','A:A');
            i=1;
            n=0;
            while~(n==1)
                if strcmp(schools{i},name)
                    obj.PandaPoints=xlsread('Database.xlsx','School', sprintf('B%d:B%d',i,i));
                    n=1;
                else
                    i=i+1;
                end
            end
        end
    end
    
end

