classdef Student < Person
    %STUDENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Mentors
    end
    
    methods
        function obj = Student(name)
            obj = obj@Person(name);
            obj.CanPurchase = 0;
        end
        
        function obj = setSchool(obj, name)
            obj.School = name;
        end
        
        function obj = setMentor(obj, mentor)
            obj.Mentors = mentor;
        end
    end
    
end

