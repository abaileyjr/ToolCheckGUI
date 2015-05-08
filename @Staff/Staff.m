classdef Staff < Person
    %STAFF Creation of a Staff object for tool checkout
    %   Staff is a subclass for the superclass Person.
    %
    %   The constructor sets the name of the Staff, the CanPurchase
    %   property, and the status.  Only Staff can purchase.
    %
    %   Created by: Mandy Chen, 23683660
    
    properties
    end
    
    methods
        function obj = Staff(name)
            obj = obj@Person(name);
            obj.CanPurchase = 1;
            obj.setStatus('Staff');
        end
        
    end
    
end

