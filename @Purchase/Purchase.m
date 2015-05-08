classdef Purchase < handle
  %PURCHASE Creation of a Purchase object for tool checkout
    %   Purchase is a subclass of handle.  In addition to
    %   the handle class properties, each Purchase obj has a Name, Quanitity, 
    %   and Price property which defines the Name of the Purchasable, how
    %   many are available to be bought, as well as how much they cost.
    %
    %   The constructor sets the name of the Purchase obj.
    %   The following additional methods set respective properties of the
    %   Purchase.
    %       setQuantity(obj, quant)
    %       setPrice(obj, Price)
    %
    %   Created by: Anthony Bailey Jr, 23528518
    
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
