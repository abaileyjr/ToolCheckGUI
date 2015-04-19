classdef Mentor < Person
    %MENTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        School;
        Students;
    end
    
    methods
        function obj = Mentor(name)
            obj = obj@Person(name);
            obj.CanPurchase = 0;
        end
        
        function obj = setSchool(obj, name)
            obj.School = name;
        end
        
        function obj = setStudent(obj, student)
            obj.Students = student;
        end
    end
    
end

