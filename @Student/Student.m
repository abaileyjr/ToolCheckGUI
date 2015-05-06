classdef Student < Person
    %STUDENT Creation of a Student object for tool checkout
    %   Student is a subclass for the superclass Person.  In addition to
    %   the Person class properties, each student has a School property and
    %   a Mentors property, which defines the School and Mentors associated
    %   with each individual student
    %
    %   The constructor sets the name of the student and the CanPurchase
    %   property.  Only Staff can purchase.
    %   The following additional methods set respective properties of the
    %   Student.
    %       setSchool(obj, school)
    %       setMentors(obj, mentors)
    %
    %   Created by: Alice Chow, 23404699
    
    properties
        School;
    end
    
    methods
        function obj = Student(name)
            obj = obj@Person(name);
            obj.CanPurchase = 0;
            obj.Status='Student';
        end
        
        function obj = setSchool(obj, name)
            obj.School = name;
        end
         
    end
    
end

