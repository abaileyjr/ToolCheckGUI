classdef Purchase < handle
  
    properties
        Name
        Quantity
        Price
    end
    
    
    methods
        function obj = Purchase(name)
            obj.Name = name;
        end
        
        function obj = setQuantity(obj, quant)
            obj.Quantity = quant;
        end
        
        function obj = setPrice(obj, price)
            obj.Price = price;
        end
    end
    
    
end
