classdef Person < handle
    %PERSON Creation of a Person object for tool checkout
    %   Person is a superclass for the subclasses Mentor, Staff, and
    %   Student.  Each person has a Name, ID, Status, and a CanPurchase
    %   property.
    %
    %   The constructor sets the name of the object.
    %   The following additional methods set respective properties of the class
    %       setID(obj, id)
    %       setStatus(obj, status)
    %
    %   Created by: Alice Chow, 23404699
    
    
    properties
        Name;
        ID;
        Status;
        CanPurchase;
    end
    
    methods
        function obj = Person(name)
            obj.Name = name;
        end
        
        function obj = setID(obj, id)
            obj.ID = id;
        end
        
        function obj = setStatus(obj, status)
            obj.Status = status;
        end
    end
    
end
