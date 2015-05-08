classdef Tool < handle
%TOOL Creation of a Tool object for tool checkout
    %   Tool is a subclass of handle.  In addition to the handle class 
    %   properties, each Tool obj has a Name and Quanitity properties,
    %   which defines the Name of the Tool and how many are available to 
    %   be checked out.
    %
    %   The constructor sets the name of the Tool obj.
    %   The following additional methods set respective properties of the
    %   Purchase.
    %       setQuantity(obj, quant)
    %
    %   Created by: Sam Fung, 22769356  
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
