classdef toolCheckout < handle
%TOOLCHECKOUT Creation of a toolCheckout object
    %   toolCheckout is a subclass of handle.  In addition to
    %   the handle class properties, each toolCheckout has the following 
    %   properties:
    %
    %   Students - Cell Array that stores Student objects
    %   Mentors - Cell Array that stores Mentor objects
    %   Staffs - Cell Array that stores Staff objects
    %   Schools - Cell Array that stores School objects
    %   Purchasables - Cell Array that stores Purchase objects
    %   Tools - Cell Array that stores Tool objects
    %   Info -  A container for information
    %
    %   The constructor calls the data function. A function that scrapes
    %   the Database sheets for the information in the Student, Staff,
    %   Mentors, Schools, Tools, and Purchase Sheets. It then uses the
    %   outputs of the data function to then set the property cell arrays
    %   with the various objects each cell array needs to hold. Lastly the
    %   constructor calls the function checkoutui, which opens the GUI for
    %   the user to interact with.
    %
    %   Created by: Sam Fung, 22769356 
    
    properties
        Students = {};
        Mentors  = {};
        Staffs = {};
        Schools = {};
        Purchasables={};
        Tools = {};
        Info = {};
    end
    
   
    
    methods
        
        function obj = toolCheckout()
            [stud, men, staf, sch, purch, purchnum, tool,toolquant] = data();
            % Gathers data and stores it into respective arrays.  stud is a
            % N x 2 array where column 1 stores the student name and column
            % 2 stores the school thes student goes to.  men is a N x 2
            % array with the same layout as student.  staf is an N x 1
            % array that holds the staff name.  sch is an N x 1 array that
            % contains the list of schools.
            
            for i = 1:length(stud)
                obj.Students{i,1} = Student(stud{i,1});
                obj.Students{i,1}.setSchool(stud{i,2});
            end
            
            for i = 1:length(men)
                obj.Mentors{i,1} = Mentor(men{i,1});
                obj.Mentors{i,1}.setSchool(men{i,2});
            end
            
            for i = 1:length(staf)
                obj.Staffs{i,1} = Staff(staf{i,1});
            end
            
            for i = 1:length(sch)
                obj.Schools{i,1} = School(sch{i,1});
            end
            
            for i = 1:length(purch)
                obj.Purchasables{i,1} = Purchase(purch{i,1});
                obj.Purchasables{i,1}.setPrice(purchnum(i,1));
                obj.Purchasables{i,1}.setQuantity(purchnum(i,2));
            end
            
            for i = 1:length(tool)
                obj.Tools{i,1} = Tool(tool{i,1});
                obj.Tools{i,1}.setQuantity(toolquant(i,1));
                
            end         
            checkoutui(obj);
        end
        
    end
end
