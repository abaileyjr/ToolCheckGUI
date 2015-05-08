classdef Mentor < Person
    %MENTOR Creation of a Mentor object for tool checkout
    %   Mentor is a subclass for the superclass Person.  In addition to
    %   the Person class properties, each mentor has a School property and
    %   a Students property, which defines the School and Students associated
    %   with each individual mentor
    %
    %   The constructor calls the Person superclass constructor, setting 
    %   the name of the mentor. Then the constructor sets the CanPurchase
    %   property while also setting Status Property. Only Staff can purchase.
    %
    %   The following additional method sets the respective property of the
    %   Mentor.
    %       setSchool(obj, school)
    %
    %   Created by: Alice Chow, 23404699
    
    properties
        School;
    end
    
    methods
        function obj = Mentor(name)
            obj = obj@Person(name);
            obj.CanPurchase = 0;
            obj.setStatus('Mentor');
        end
        
        function obj = setSchool(obj, name)
            obj.School = name;
        end
       
    end
    
end

