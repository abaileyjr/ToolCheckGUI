classdef Staff < Person
    %STAFF Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = Staff(name)
            obj = obj@Person(name);
            obj.CanPurchase = 1;
        end
        
    end
    
end

