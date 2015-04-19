classdef Checkout < handle
 
    
    properties
        Student = {};
        Mentor = {};
        Staff = {};
        School = {};
    end
    
    methods (Static)
        function [student, mentor, staff, school] = getData() 
            student = {}; %Sheet 1
            mentor = {}; % Sheet 2
            staff = {}; % Sheet 3
            school = {}; % Sheet4
            
            % Creates empty cells, may not be needed
            
            [~, student, ~] = xlsread('Database',1);
            [~, mentor, ~] = xlsread('Database',2);
            [~, staff, ~] = xlsread('Database',3);
            [~, school, ~] = xlsread('Database',4);
            
            % Reads the database xls file and stores the data in the
            % respective student, ,mentor, staff, and school arrays.
        end
        
        function [] = checkoutUI()
            % TO MAKE
        end
        
    end
    
    methods
        function obj = Checkout()
            [stud, men, staf, sch] = getData();
            % Gathers data and stores it into respective arrays.  stud is a
            % N x 2 array where column 1 stores the student name and column
            % 2 stores the school thes student goes to.  men is a N x 2
            % array with the same layout as student.  staf is an N x 1
            % array that holds the staff name.  sch is an N x 1 array that
            % contains the list of schools.
  
            
            for i = 1:length(stud)
                Checkout.Student{i,1} = student(stud{i,1});
                Checkout.Student{i,1}.setSchool(stud{i,2});
            end
            
            for i = 1:length(men)
                Checkout.Mentor{i,1} = mentor(men{i,1});
                Checkout.Mentor{i,1}.setSchool(men{i,2});
            end
            
            for i = 1:length(staf)
                Checkout.Staff{i,1} = staff(staf{i,1});
            end
            
            for i = 1:length(sch)
                Checkout.School{i,1} = school(sch{i,1});
            end
            
        end
        
    end
end
