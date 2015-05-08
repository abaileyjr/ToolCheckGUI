classdef School < handle
    %SCHOOL Creation of a School object for tool checkout
    %   School is a subclass of handle.  In addition to
    %   the handle class properties, each School obj has a Name and Price 
    %   property which defines the Name of the School, and how
    %   many PandaPoints are avaiable for the school to use.
    %
    %   The constructor sets the name of the School obj and set the
    %   PandaPoints of the School obj by reading the "Database"
    %   spreadsheet.
    %
    %   Created by: Anthony Bailey Jr, 23528518
    
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
                % if the school's name matches then grab the PandaPoints
                % and set the obj.PandaPoints value to that value.
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

