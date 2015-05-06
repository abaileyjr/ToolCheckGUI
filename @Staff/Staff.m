classdef Staff < Person
    %STAFF Creation of a Staff object for tool checkout
    %   Staff is a subclass for the superclass Person.
    %
    %   The constructor sets the name of the staff and the CanPurchase
    %   property.  Only Staff can purchase.
    %
    %   Created by: Alice Chow, 23404699
    
    properties
    end
    
    methods
        function obj = Staff(name)
            obj = obj@Person(name);
            obj.CanPurchase = 1;
            obj.Status='Staff';
        end
        
    end
    
end

