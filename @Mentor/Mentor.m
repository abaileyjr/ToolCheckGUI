classdef Mentor < Person
    %MENTOR Creation of a Mentor object for tool checkout
    %   Mentor is a subclass for the superclass Person.  In addition to
    %   the Person class properties, each mentor has a School property and
    %   a Students property, which defines the School and Students associated
    %   with each individual mentor
    %
    %   The constructor sets the name of the mentor and the CanPurchase
    %   property.  Only Staff can purchase.
    %   The following additional methods set respective properties of the
    %   Mentor.
    %       setSchool(obj, school)
    %       setStudents(obj, students)
    %
    %   Created by: Alice Chow, 23404699
    
    properties
        School;
    end
    
    methods
        function obj = Mentor(name)
            obj = obj@Person(name);
            obj.CanPurchase = 0;
            obj.Status='Mentor';
        end
        
        function obj = setSchool(obj, name)
            obj.School = name;
        end
       
    end
    
end

