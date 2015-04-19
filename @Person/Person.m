classdef Person < handle
    %PERSON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name
        ID
        Status
        CanPurchase
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

