classdef Tool < handle
  
    properties
        Name
        Quantity
    end
    
    
    methods
        function obj = Tool(name)
            obj.Name = name;
        end
        
        function obj = setQuantity(obj, quant)
            obj.Quantity = quant;
        end
    end
    
    
end
