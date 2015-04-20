classdef Tool < handle
  
    properties
        Name
        Quantity
    end
    
    
    methods
        function obj = Purchase(name)
            obj.Name = name;
        end
        
        function obj = setPrice(obj, price)
            obj.Price = price;
        end
    end
    
    
end
